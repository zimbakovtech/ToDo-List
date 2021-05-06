import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(MaterialApp(
      theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primarySwatch: Colors.grey),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    ));

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Color primaryColor = Color(0xff81C9F9);
  Color secondaryColor = Color(0xff545454);
  Color tertiaryColor = Colors.white;

  bool theme = true;

  List todos = [];
  List state = [];
  String _value;
  var dateTime = DateFormat('dd-MMM-yy hh:mm a').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: AppBar(
        leading: IconButton(
          color: secondaryColor,
          onPressed: () {
            setState(() {
              theme = !theme;
              primaryColor = theme ? Color(0xff81C9F9) : Colors.redAccent;
              secondaryColor = theme ? Color(0xff545454) : Colors.grey[850];
            });
          },
          icon: Icon(
              theme ? Icons.toggle_off_outlined : Icons.toggle_on_outlined),
        ),
        toolbarHeight: 100.0,
        centerTitle: true,
        title: Text(
          'To-Do List',
          style: TextStyle(
            color: secondaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
          ),
        ),
        backgroundColor: primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30.0),
          ),
        ),
      ),
      floatingActionButton: Container(
        height: 75.0,
        width: 75.0,
        child: FittedBox(
          child: FloatingActionButton(
            tooltip: 'Add new task',
            child: Icon(
              Icons.add,
              color: primaryColor,
            ),
            backgroundColor: tertiaryColor,
            onPressed: () {
              return showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                        backgroundColor: secondaryColor,
                        title: Text(
                          'Add new task',
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        content: Container(
                            height: 120.0,
                            width: 120.0,
                            child: Column(children: [
                              TextField(
                                autocorrect: true,
                                textCapitalization:
                                    TextCapitalization.sentences,
                                maxLength: 30,
                                autofocus: true,
                                decoration: InputDecoration(
                                  hintText: 'Add new task...',
                                  hintStyle: TextStyle(
                                    color: primaryColor,
                                  ),
                                  labelStyle: TextStyle(
                                    color: primaryColor,
                                  ),
                                ),
                                onChanged: (String result) {
                                  setState(() {
                                    _value = result;
                                  });
                                },
                                textInputAction: TextInputAction.go,
                                onSubmitted: (_value) {
                                  setState(() {
                                    todos.add(_value);
                                    Navigator.of(context).pop();
                                    state.add(false);
                                  });
                                },
                              ),
                              SizedBox(height: 10.0),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: primaryColor,
                                      ),
                                      child: Text(
                                        'Cancel',
                                        style: TextStyle(
                                          color: secondaryColor,
                                        ),
                                      ),
                                    ),
                                    ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            todos.add(_value);
                                            Navigator.of(context).pop();
                                            state.add(false);
                                          });
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: primaryColor,
                                        ),
                                        child: Text('Save',
                                            style: TextStyle(
                                              color: secondaryColor,
                                            )))
                                  ]),
                            ])));
                  });
            },
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: ListView.builder(
            itemCount: todos.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: ListTile(
                      leading: IconButton(
                        tooltip: 'Mark as done',
                        onPressed: () {
                          setState(() {
                            state[index] = !state[index];
                          });
                        },
                        icon: Icon(
                          Icons.check_box,
                          color: state[index] ? secondaryColor : primaryColor,
                        ),
                      ),
                      title: Text(
                        '${todos[index]}',
                        style: TextStyle(
                          color: state[index] ? secondaryColor : null,
                          fontSize: 18.0,
                          decoration:
                              state[index] ? TextDecoration.lineThrough : null,
                        ),
                      ),
                      subtitle: Text('$dateTime'),
                      trailing: IconButton(
                        tooltip: 'Delete task',
                        icon: Icon(
                          Icons.delete,
                          color: primaryColor,
                        ),
                        onPressed: () {
                          setState(() {
                            todos.removeAt(index);
                            state.removeAt(index);
                          });
                        },
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 12.0,
        color: primaryColor,
        child: Container(
          height: 60.0,
        ),
      ),
    );
  }
}
