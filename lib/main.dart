import 'package:flutter/material.dart';
import 'package:ticket_booking/CustomShapeClipper.dart';
import 'package:ticket_booking/CustomeAppBar.dart';
import 'package:ticket_booking/flight_list.dart';

void main() {
  runApp(MaterialApp(
    title: 'Flight Book',
    debugShowCheckedModeBanner: false,
    home: HomeScreen(),
    theme: appTheme,
  ));
}

//colors for gradient
Color firstColor = Color(0xFFF47D15);
Color secondColor = Color(0xFFEF772C);
//theme data
ThemeData appTheme =
    ThemeData(primaryColor: Color(0xFFF3791A), fontFamily: 'Oxygen');

List<String> locations = ['Boston  (BOS)', 'New York City (JFK)'];

//text Styles

const TextStyle dropDownLabelStyle =
    TextStyle(color: Colors.white, fontSize: 16);
const TextStyle dropDownMenuItemStyle =
    TextStyle(color: Colors.black, fontSize: 16);

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomAppBar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            HomeScreenTop(),
            HomeScreenBotttom(),
          ],
        ),
      ),
    );
  }
}

class HomeScreenTop extends StatefulWidget {
  HomeScreenTop({Key key}) : super(key: key);

  @override
  _HomeScreenTopState createState() => _HomeScreenTopState();
}

class _HomeScreenTopState extends State<HomeScreenTop> {
//keep track of which index is selcted
  var selectedlocationIndex = 0;

  bool isFlightSelected = true;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
//using this for custom curves
        ClipPath(
          clipper: CustomShapeClipper(),
          child: Container(
            height: 400,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [firstColor, secondColor]),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.white),
                      SizedBox(
                        width: 16,
                      ),
                      PopupMenuButton(
                        child: Row(
                          children: [
                            Text(locations[selectedlocationIndex],
                                style: dropDownLabelStyle),
                            Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.white,
                            )
                          ],
                        ),
                        itemBuilder: (BuildContext context) =>
                            <PopupMenuItem<int>>[
                          PopupMenuItem(
                            child: Text(
                              locations[0],
                              style: dropDownMenuItemStyle,
                            ),
                            value: 0,
                          ),
                          PopupMenuItem(
                            child: Text(
                              locations[1],
                              style: dropDownMenuItemStyle,
                            ),
                            value: 1,
                          )
                        ],
                        onSelected: (index) {
                          setState(() {
                            selectedlocationIndex = index;
                          });
                        },
                      ),
                      Spacer(),
                      Icon(
                        Icons.settings,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
                SizedBox(height: 40),
                Text(
                  'Where would\n you want to go ?',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                    child: TextField(
                      controller: TextEditingController(text: locations[1]),
                      style: dropDownMenuItemStyle,
                      cursorColor: appTheme.primaryColor,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        suffixIcon: Material(
                          elevation: 2,
                          borderRadius: BorderRadius.circular(50),
                          child: InkWell(
                            child: Icon(Icons.search, color: Colors.black),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FlightListing()));
                            },
                          ),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        child: ChoiceChip(
                            icon: Icons.flight,
                            text: 'Flight',
                            isFlightSelected: isFlightSelected),
                        onTap: () {
                          setState(() {
                            isFlightSelected = true;
                          });
                        },
                      ),
                      SizedBox(width: 20),
                      InkWell(
                        child: ChoiceChip(
                            icon: Icons.hotel,
                            text: 'Hotels',
                            isFlightSelected: !isFlightSelected),
                        onTap: () {
                          setState(() {
                            isFlightSelected = false;
                          });
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class ChoiceChip extends StatefulWidget {
  final IconData icon;
  final String text;
  final bool isFlightSelected;
  ChoiceChip({this.icon, this.text, this.isFlightSelected});

  @override
  _ChoiceChipState createState() => _ChoiceChipState();
}

class _ChoiceChipState extends State<ChoiceChip> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 17, vertical: 7),
      decoration: widget.isFlightSelected
          ? BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
            )
          : null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(widget.icon, size: 25, color: Colors.white),
          SizedBox(width: 8),
          Text(
            widget.text,
            style: TextStyle(fontSize: 16, color: Colors.white),
          )
        ],
      ),
    );
  }
}

class HomeScreenBotttom extends StatelessWidget {
  const HomeScreenBotttom({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 16),
              Text(
                'Currently Watched Items',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              Spacer(),
              Text(
                'VIEW ALL (12)',
                style: TextStyle(
                  color: appTheme.primaryColor,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 210,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: cityCards,
          ),
        )
      ],
    );
  }
}

List<CityCard> cityCards = [
  CityCard('LasVegas', '45', 'assets/images/lasvegas.jpg', 'Feb 2021', '2250',
      '4299'),
  CityCard(
      'Athens', '45', 'assets/images/athens.jpg', 'Feb 2021', '2250', '4299'),
  CityCard('LasVegas', '45', 'assets/images/lasvegas.jpg', 'Feb 2021', '2250',
      '4299'),
  CityCard(
      'Sydney', '45', 'assets/images/sydney.jpeg', 'Feb 2021', '2250', '4299')
];

class CityCard extends StatelessWidget {
  final String imagePath, cityName, monthYear, discount, oldPrice, newPrice;
  const CityCard(this.cityName, this.discount, this.imagePath, this.monthYear,
      this.newPrice, this.oldPrice);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Stack(
              children: [
                Container(
                  height: 190,
                  width: 160,
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  left: 0,
                  bottom: 0,
                  width: 160,
                  height: 60,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [Colors.black, Colors.black12],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 10,
                  bottom: 10,
                  right: 10,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cityName,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 18),
                          ),
                          Text(
                            monthYear,
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                                fontSize: 14),
                          )
                        ],
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          '$discount%',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 5.0,
              ),
              Text(
                '\$$newPrice',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
              SizedBox(
                width: 5.0,
              ),
              Text(
                '(\$$oldPrice)',
                style: TextStyle(
                    decoration: TextDecoration.lineThrough,
                    color: Colors.black45,
                    fontWeight: FontWeight.normal,
                    fontSize: 11),
              )
            ],
          ),
        ],
      ),
    );
  }
}
