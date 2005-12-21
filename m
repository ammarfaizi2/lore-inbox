Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932239AbVLUBsp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239AbVLUBsp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 20:48:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbVLUBsp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 20:48:45 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:53194 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932239AbVLUBso (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 20:48:44 -0500
Date: Tue, 20 Dec 2005 19:48:40 -0600
From: Robin Holt <holt@sgi.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [Patch 2/5] Rebuild scripts/genksyms/keywords.c_shipped following parse.y change.
Message-ID: <20051221014840.GC2784@lnx-holt.americas.sgi.com>
References: <20051221014550.GA2784@lnx-holt.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051221014550.GA2784@lnx-holt.americas.sgi.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

scripts/genksyms/keywords.c_shipped regenerated following parse.y change.

Signed-off-by: Robin Holt <holt@sgi.com>


Index: linux-2.6/scripts/genksyms/keywords.c_shipped
===================================================================
--- linux-2.6.orig/scripts/genksyms/keywords.c_shipped	2005-12-20 19:12:49.654035222 -0600
+++ linux-2.6/scripts/genksyms/keywords.c_shipped	2005-12-20 19:13:11.998530413 -0600
@@ -1,7 +1,38 @@
-/* ANSI-C code produced by gperf version 2.7.2 */
+/* ANSI-C code produced by gperf version 3.0.1 */
 /* Command-line: gperf -L ANSI-C -a -C -E -g -H is_reserved_hash -k '1,3,$' -N is_reserved_word -p -t scripts/genksyms/keywords.gperf  */
+
+#if !((' ' == 32) && ('!' == 33) && ('"' == 34) && ('#' == 35) \
+      && ('%' == 37) && ('&' == 38) && ('\'' == 39) && ('(' == 40) \
+      && (')' == 41) && ('*' == 42) && ('+' == 43) && (',' == 44) \
+      && ('-' == 45) && ('.' == 46) && ('/' == 47) && ('0' == 48) \
+      && ('1' == 49) && ('2' == 50) && ('3' == 51) && ('4' == 52) \
+      && ('5' == 53) && ('6' == 54) && ('7' == 55) && ('8' == 56) \
+      && ('9' == 57) && (':' == 58) && (';' == 59) && ('<' == 60) \
+      && ('=' == 61) && ('>' == 62) && ('?' == 63) && ('A' == 65) \
+      && ('B' == 66) && ('C' == 67) && ('D' == 68) && ('E' == 69) \
+      && ('F' == 70) && ('G' == 71) && ('H' == 72) && ('I' == 73) \
+      && ('J' == 74) && ('K' == 75) && ('L' == 76) && ('M' == 77) \
+      && ('N' == 78) && ('O' == 79) && ('P' == 80) && ('Q' == 81) \
+      && ('R' == 82) && ('S' == 83) && ('T' == 84) && ('U' == 85) \
+      && ('V' == 86) && ('W' == 87) && ('X' == 88) && ('Y' == 89) \
+      && ('Z' == 90) && ('[' == 91) && ('\\' == 92) && (']' == 93) \
+      && ('^' == 94) && ('_' == 95) && ('a' == 97) && ('b' == 98) \
+      && ('c' == 99) && ('d' == 100) && ('e' == 101) && ('f' == 102) \
+      && ('g' == 103) && ('h' == 104) && ('i' == 105) && ('j' == 106) \
+      && ('k' == 107) && ('l' == 108) && ('m' == 109) && ('n' == 110) \
+      && ('o' == 111) && ('p' == 112) && ('q' == 113) && ('r' == 114) \
+      && ('s' == 115) && ('t' == 116) && ('u' == 117) && ('v' == 118) \
+      && ('w' == 119) && ('x' == 120) && ('y' == 121) && ('z' == 122) \
+      && ('{' == 123) && ('|' == 124) && ('}' == 125) && ('~' == 126))
+/* The character set is not based on ISO-646.  */
+#error "gperf generated tables don't work with this execution character set. Please report a bug to <bug-gnu-gperf@gnu.org>."
+#endif
+
+#line 1 "scripts/genksyms/keywords.gperf"
+
+#line 3 "scripts/genksyms/keywords.gperf"
 struct resword { const char *name; int token; };
-/* maximum key range = 109, duplicates = 0 */
+/* maximum key range = 68, duplicates = 0 */
 
 #ifdef __GNUC__
 __inline
@@ -15,32 +46,32 @@ is_reserved_hash (register const char *s
 {
   static const unsigned char asso_values[] =
     {
-      113, 113, 113, 113, 113, 113, 113, 113, 113, 113,
-      113, 113, 113, 113, 113, 113, 113, 113, 113, 113,
-      113, 113, 113, 113, 113, 113, 113, 113, 113, 113,
-      113, 113, 113, 113, 113, 113, 113, 113, 113, 113,
-      113, 113, 113, 113, 113, 113, 113, 113, 113, 113,
-      113, 113, 113, 113, 113, 113, 113, 113, 113, 113,
-      113, 113, 113, 113, 113, 113, 113, 113, 113,   5,
-      113, 113, 113, 113, 113, 113,   0, 113, 113, 113,
-        0, 113, 113, 113, 113, 113, 113, 113, 113, 113,
-      113, 113, 113, 113, 113,   0, 113,   0, 113,  20,
-       25,   0,  35,  30, 113,  20, 113, 113,  40,  30,
-       30,   0,   0, 113,   0,  51,   0,  15,   5, 113,
-      113, 113, 113, 113, 113, 113, 113, 113, 113, 113,
-      113, 113, 113, 113, 113, 113, 113, 113, 113, 113,
-      113, 113, 113, 113, 113, 113, 113, 113, 113, 113,
-      113, 113, 113, 113, 113, 113, 113, 113, 113, 113,
-      113, 113, 113, 113, 113, 113, 113, 113, 113, 113,
-      113, 113, 113, 113, 113, 113, 113, 113, 113, 113,
-      113, 113, 113, 113, 113, 113, 113, 113, 113, 113,
-      113, 113, 113, 113, 113, 113, 113, 113, 113, 113,
-      113, 113, 113, 113, 113, 113, 113, 113, 113, 113,
-      113, 113, 113, 113, 113, 113, 113, 113, 113, 113,
-      113, 113, 113, 113, 113, 113, 113, 113, 113, 113,
-      113, 113, 113, 113, 113, 113, 113, 113, 113, 113,
-      113, 113, 113, 113, 113, 113, 113, 113, 113, 113,
-      113, 113, 113, 113, 113, 113
+      71, 71, 71, 71, 71, 71, 71, 71, 71, 71,
+      71, 71, 71, 71, 71, 71, 71, 71, 71, 71,
+      71, 71, 71, 71, 71, 71, 71, 71, 71, 71,
+      71, 71, 71, 71, 71, 71, 71, 71, 71, 71,
+      71, 71, 71, 71, 71, 71, 71, 71, 71, 71,
+      71, 71, 71, 71, 71, 71, 71, 71, 71, 71,
+      71, 71, 71, 71, 71, 71, 71, 71, 71, 15,
+      71, 71, 71, 71, 71, 71, 15, 71, 71, 71,
+      10, 71, 71, 71, 71, 71, 71, 71, 71, 71,
+      71, 71, 71, 71, 71,  0, 71,  0, 71,  5,
+       5,  0, 10, 20, 71, 25, 71, 71, 20,  0,
+      20, 30, 25, 71, 10,  5,  0, 20, 15, 71,
+      71, 71, 71, 71, 71, 71, 71, 71, 71, 71,
+      71, 71, 71, 71, 71, 71, 71, 71, 71, 71,
+      71, 71, 71, 71, 71, 71, 71, 71, 71, 71,
+      71, 71, 71, 71, 71, 71, 71, 71, 71, 71,
+      71, 71, 71, 71, 71, 71, 71, 71, 71, 71,
+      71, 71, 71, 71, 71, 71, 71, 71, 71, 71,
+      71, 71, 71, 71, 71, 71, 71, 71, 71, 71,
+      71, 71, 71, 71, 71, 71, 71, 71, 71, 71,
+      71, 71, 71, 71, 71, 71, 71, 71, 71, 71,
+      71, 71, 71, 71, 71, 71, 71, 71, 71, 71,
+      71, 71, 71, 71, 71, 71, 71, 71, 71, 71,
+      71, 71, 71, 71, 71, 71, 71, 71, 71, 71,
+      71, 71, 71, 71, 71, 71, 71, 71, 71, 71,
+      71, 71, 71, 71, 71, 71
     };
   return len + asso_values[(unsigned char)str[2]] + asso_values[(unsigned char)str[0]] + asso_values[(unsigned char)str[len - 1]];
 }
@@ -56,77 +87,112 @@ is_reserved_word (register const char *s
       TOTAL_KEYWORDS = 41,
       MIN_WORD_LENGTH = 3,
       MAX_WORD_LENGTH = 17,
-      MIN_HASH_VALUE = 4,
-      MAX_HASH_VALUE = 112
+      MIN_HASH_VALUE = 3,
+      MAX_HASH_VALUE = 70
     };
 
   static const struct resword wordlist[] =
     {
-      {""}, {""}, {""}, {""},
-      {"auto", AUTO_KEYW},
-      {""}, {""},
+      {""}, {""}, {""},
+#line 24 "scripts/genksyms/keywords.gperf"
+      {"asm", ASM_KEYW},
+      {""},
+#line 7 "scripts/genksyms/keywords.gperf"
+      {"__asm", ASM_KEYW},
+      {""},
+#line 8 "scripts/genksyms/keywords.gperf"
       {"__asm__", ASM_KEYW},
       {""},
+#line 21 "scripts/genksyms/keywords.gperf"
       {"_restrict", RESTRICT_KEYW},
+#line 50 "scripts/genksyms/keywords.gperf"
       {"__typeof__", TYPEOF_KEYW},
+#line 9 "scripts/genksyms/keywords.gperf"
       {"__attribute", ATTRIBUTE_KEYW},
-      {"__restrict__", RESTRICT_KEYW},
+#line 11 "scripts/genksyms/keywords.gperf"
+      {"__const", CONST_KEYW},
+#line 10 "scripts/genksyms/keywords.gperf"
       {"__attribute__", ATTRIBUTE_KEYW},
+#line 12 "scripts/genksyms/keywords.gperf"
+      {"__const__", CONST_KEYW},
+#line 16 "scripts/genksyms/keywords.gperf"
+      {"__signed__", SIGNED_KEYW},
+#line 42 "scripts/genksyms/keywords.gperf"
+      {"static", STATIC_KEYW},
       {""},
-      {"__volatile", VOLATILE_KEYW},
+#line 15 "scripts/genksyms/keywords.gperf"
+      {"__signed", SIGNED_KEYW},
+#line 30 "scripts/genksyms/keywords.gperf"
+      {"char", CHAR_KEYW},
       {""},
+#line 43 "scripts/genksyms/keywords.gperf"
+      {"struct", STRUCT_KEYW},
+#line 22 "scripts/genksyms/keywords.gperf"
+      {"__restrict__", RESTRICT_KEYW},
+#line 23 "scripts/genksyms/keywords.gperf"
+      {"restrict", RESTRICT_KEYW},
+#line 33 "scripts/genksyms/keywords.gperf"
+      {"enum", ENUM_KEYW},
+#line 17 "scripts/genksyms/keywords.gperf"
+      {"__volatile", VOLATILE_KEYW},
+#line 34 "scripts/genksyms/keywords.gperf"
+      {"extern", EXTERN_KEYW},
+#line 18 "scripts/genksyms/keywords.gperf"
       {"__volatile__", VOLATILE_KEYW},
-      {"EXPORT_SYMBOL", EXPORT_SYMBOL_KEYW},
-      {""}, {""}, {""},
-      {"EXPORT_SYMBOL_GPL", EXPORT_SYMBOL_KEYW},
+#line 37 "scripts/genksyms/keywords.gperf"
       {"int", INT_KEYW},
-      {"char", CHAR_KEYW},
-      {""}, {""},
-      {"__const", CONST_KEYW},
+      {""},
+#line 31 "scripts/genksyms/keywords.gperf"
+      {"const", CONST_KEYW},
+#line 32 "scripts/genksyms/keywords.gperf"
+      {"double", DOUBLE_KEYW},
+      {""},
+#line 13 "scripts/genksyms/keywords.gperf"
       {"__inline", INLINE_KEYW},
-      {"__const__", CONST_KEYW},
+#line 29 "scripts/genksyms/keywords.gperf"
+      {"auto", AUTO_KEYW},
+#line 14 "scripts/genksyms/keywords.gperf"
       {"__inline__", INLINE_KEYW},
-      {""}, {""}, {""}, {""},
-      {"__asm", ASM_KEYW},
-      {"extern", EXTERN_KEYW},
+#line 41 "scripts/genksyms/keywords.gperf"
+      {"signed", SIGNED_KEYW},
       {""},
-      {"register", REGISTER_KEYW},
+#line 46 "scripts/genksyms/keywords.gperf"
+      {"unsigned", UNSIGNED_KEYW},
       {""},
-      {"float", FLOAT_KEYW},
+#line 40 "scripts/genksyms/keywords.gperf"
+      {"short", SHORT_KEYW},
+#line 49 "scripts/genksyms/keywords.gperf"
       {"typeof", TYPEOF_KEYW},
+#line 44 "scripts/genksyms/keywords.gperf"
       {"typedef", TYPEDEF_KEYW},
-      {""}, {""},
-      {"_Bool", BOOL_KEYW},
-      {"double", DOUBLE_KEYW},
-      {""}, {""},
-      {"enum", ENUM_KEYW},
-      {""}, {""}, {""},
+#line 48 "scripts/genksyms/keywords.gperf"
       {"volatile", VOLATILE_KEYW},
+      {""},
+#line 35 "scripts/genksyms/keywords.gperf"
+      {"float", FLOAT_KEYW},
+      {""}, {""},
+#line 39 "scripts/genksyms/keywords.gperf"
+      {"register", REGISTER_KEYW},
+#line 47 "scripts/genksyms/keywords.gperf"
       {"void", VOID_KEYW},
-      {"const", CONST_KEYW},
-      {"short", SHORT_KEYW},
-      {"struct", STRUCT_KEYW},
       {""},
-      {"restrict", RESTRICT_KEYW},
+#line 36 "scripts/genksyms/keywords.gperf"
+      {"inline", INLINE_KEYW},
       {""},
-      {"__signed__", SIGNED_KEYW},
+#line 5 "scripts/genksyms/keywords.gperf"
+      {"EXPORT_SYMBOL", EXPORT_SYMBOL_KEYW},
       {""},
-      {"asm", ASM_KEYW},
-      {""}, {""},
-      {"inline", INLINE_KEYW},
-      {""}, {""}, {""},
-      {"union", UNION_KEYW},
-      {""}, {""}, {""}, {""}, {""}, {""},
-      {"static", STATIC_KEYW},
+#line 20 "scripts/genksyms/keywords.gperf"
+      {"_Bool", BOOL_KEYW},
+      {""},
+#line 6 "scripts/genksyms/keywords.gperf"
+      {"EXPORT_SYMBOL_GPL", EXPORT_SYMBOL_KEYW},
       {""}, {""}, {""}, {""}, {""}, {""},
-      {"__signed", SIGNED_KEYW},
-      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
-      {""}, {""}, {""}, {""}, {""},
-      {"unsigned", UNSIGNED_KEYW},
-      {""}, {""}, {""}, {""},
+#line 38 "scripts/genksyms/keywords.gperf"
       {"long", LONG_KEYW},
-      {""}, {""}, {""}, {""}, {""}, {""}, {""},
-      {"signed", SIGNED_KEYW}
+      {""}, {""}, {""}, {""}, {""},
+#line 45 "scripts/genksyms/keywords.gperf"
+      {"union", UNION_KEYW}
     };
 
   if (len <= MAX_WORD_LENGTH && len >= MIN_WORD_LENGTH)
