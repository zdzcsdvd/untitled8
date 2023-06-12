import 'dart:async';
import 'dart:convert';

import 'package:flutter_trip/model/seach_model.dart';
import 'package:http/http.dart' as http;

///搜索接口
class SearchDao {
  static Future<SearchModel> fetch(String url, String text) async {
    var uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder(); // fix 中文乱码
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      //只有当当前输入的内容和服务端返回的内容一致时才渲染
      SearchModel model = SearchModel.fromJson(result);
    // 服务端返回的内容一致时才渲染
      model.keyword = text;
      return model;
    } else {
      throw Exception('Failed to load home_page.json');
    }
  }
}
