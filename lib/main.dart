import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tab_bar/json_data.dart';

void main() {
  runApp(MyApp());
}

//how this use full?
//make tab in list(list of category)
//when i press on onTap try to call netowrk api for that index
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    ;
    return DefaultTabController(
      length: 10,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          bottom: TabBar(
              indicatorColor: Colors.white,
              isScrollable: true,
              physics: ScrollPhysics(),
              onTap: (index) {
                print(
                    'here call give me item from category of index in list of category, and from tabbar view you have to call the item of this index if it is empy dispaly circulerIndecator otherwise print al the data');
              },
              tabs: [
                for (int i = 0; i < 10; i++) ...{
                  Tab(
                    text: i.toString(),
                  )
                }
              ]),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            for (int i = 0; i < 10; i++) MyController(i: i),
          ],
        ),
      ),
    );
  }
}

class MyController extends StatefulWidget {
  final int i;
  MyController({
    Key key,
    this.i,
  }) : super(key: key);

  @override
  _MyControllerState createState() => _MyControllerState(i);
}

class _MyControllerState extends State<MyController>
    with AutomaticKeepAliveClientMixin {
  _MyControllerState(this.i);
  final int i;
  final JsonData data = JsonData();

  @override
  void initState() {
    print(
        'here call to the api for category of this $i that have in the list of the category');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    print('iam builded');
    return ListView.builder(
      itemCount: data.data.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(data.data[index]['name']),
          subtitle: Text(data.data[index]['age'].toString()),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
