Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137019AbREKAah>; Thu, 10 May 2001 20:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137020AbREKAa2>; Thu, 10 May 2001 20:30:28 -0400
Received: from srvr2.telecom.lt ([212.59.0.1]:16788 "EHLO mail.takas.lt")
	by vger.kernel.org with ESMTP id <S137019AbREKAaT>;
	Thu, 10 May 2001 20:30:19 -0400
Message-Id: <200105110030.CAA1192576@mail.takas.lt>
Date: Fri, 11 May 2001 02:21:25 +0200 (EET)
From: Nerijus Baliunas <nerijus@users.sourceforge.net>
Subject: [PATCH] for iso8859-13
To: linux-kernel@vger.kernel.org
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Disposition: INLINE
X-Mailer: Mahogany, 0.62 'Mars', compiled for Linux 2.2.19 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch for Documentation/Configure.help in 2.4.4-ac6. Adds
missing iso8859-13 to CONFIG_NLS_DEFAULT and corrects some texts.

--- Configure.help        Fri May 11 01:52:15 2001
+++ Configure.help.new        Fri May 11 02:02:53 2001
@@ -12567,8 +12567,8 @@
   cp862, cp863, cp864, cp865, cp866, cp869, cp874, cp932, cp936,
   cp949, cp950, cp1251, cp1255, euc-jp, euc-kr, gb2312, iso8859-1,
   iso8859-2, iso8859-3, iso8859-4, iso8859-5, iso8859-6, iso8859-7,
-  iso8859-8, iso8859-9, iso8859-14, iso8859-15, koi8-r, koi8-ru,
-  koi8-u, sjis, tis-620, utf8.
+  iso8859-8, iso8859-9, iso8859-13, iso8859-14, iso8859-15,
+  koi8-r, koi8-ru, koi8-u, sjis, tis-620, utf8.
   If you specify a wrong value, it will use the built-in NLS;
   compatible with iso8859-1.
 
@@ -12605,7 +12605,8 @@
   DOS/Windows partitions correctly. This does apply to the filenames
   only, not to the file contents. You can include several codepages;
   say Y here if you want to include the DOS codepage that is used
-  for the Baltic Rim Languages. If unsure, say N.
+  for the Baltic Rim Languages (Latvian and Lithuanian). If unsure,
+  say N.
 
 Codepage 850 (Europe)
 CONFIG_NLS_CODEPAGE_850
@@ -12804,7 +12805,7 @@
   say Y here if you want to include the DOS codepage for Traditional
   Chinese(Big5).
 
-NLS ISO 8859-1  (Latin 1; Western European Languages)
+NLS ISO 8859-1 (Latin 1; Western European Languages)
 CONFIG_NLS_ISO8859_1
   If you want to display filenames with native language characters
   from the Microsoft FAT file system family or from JOLIET CDROMs
@@ -12815,7 +12816,7 @@
   Galician, Irish, Icelandic, Italian, Norwegian, Portuguese, Spanish,
   and Swedish. It is also the default for the US. If unsure, say Y.
 
-NLS ISO 8859-2  (Latin 2; Slavic/Central European Languages)
+NLS ISO 8859-2 (Latin 2; Slavic/Central European Languages)
 CONFIG_NLS_ISO8859_2
   If you want to display filenames with native language characters
   from the Microsoft FAT file system family or from JOLIET CDROMs
@@ -12825,7 +12826,7 @@
   languages: Czech, German, Hungarian, Polish, Rumanian, Croatian,
   Slovak, Slovene.
 
-NLS ISO 8859-3  (Latin 3; Esperanto, Galician, Maltese, Turkish)
+NLS ISO 8859-3 (Latin 3; Esperanto, Galician, Maltese, Turkish)
 CONFIG_NLS_ISO8859_3
   If you want to display filenames with native language characters
   from the Microsoft FAT file system family or from JOLIET CDROMs
@@ -12834,16 +12835,16 @@
   set, which is popular with authors of Esperanto, Galician, Maltese,
   and Turkish.
 
-NLS ISO 8859-4  (Latin 4; old Baltic charset)
+NLS ISO 8859-4 (Latin 4; old Baltic charset)
 CONFIG_NLS_ISO8859_4
   If you want to display filenames with native language characters
   from the Microsoft FAT file system family or from JOLIET CDROMs
   correctly on the screen, you need to include the appropriate
   input/output character sets. Say Y here for the Latin 4 character
   set which introduces letters for Estonian, Latvian, and
-  Lithuanian. It is an incomplete predecessor of Latin 6.
+  Lithuanian. It is an incomplete predecessor of Latin 7.
 
-NLS ISO 8859-5  (Cyrillic)
+NLS ISO 8859-5 (Cyrillic)
 CONFIG_NLS_ISO8859_5
   If you want to display filenames with native language characters
   from the Microsoft FAT file system family or from JOLIET CDROMs
@@ -12853,7 +12854,7 @@
   Macedonian, Russian, Serbian, and Ukrainian. Note that the charset
   KOI8-R is preferred in Russia.
 
-NLS ISO 8859-6  (Arabic)
+NLS ISO 8859-6 (Arabic)
 CONFIG_NLS_ISO8859_6
   If you want to display filenames with native language characters
   from the Microsoft FAT file system family or from JOLIET CDROMs
@@ -12861,7 +12862,7 @@
   input/output character sets. Say Y here for ISO8859-6, the Arabic
   character set.
 
-NLS ISO 8859-7  (Modern Greek)
+NLS ISO 8859-7 (Modern Greek)
 CONFIG_NLS_ISO8859_7
   If you want to display filenames with native language characters
   from the Microsoft FAT file system family or from JOLIET CDROMs
@@ -12877,7 +12878,7 @@
   input/output character sets. Say Y here for ISO8859-8, the Hebrew
   character set.
 
-NLS ISO 8859-9  (Latin 5; Turkish)
+NLS ISO 8859-9 (Latin 5; Turkish)
 CONFIG_NLS_ISO8859_9
   If you want to display filenames with native language characters
   from the Microsoft FAT file system family or from JOLIET CDROMs
@@ -12886,7 +12887,7 @@
   set, and it replaces the rarely needed Icelandic letters in Latin 1
   with the Turkish ones. Useful in Turkey.
 
-nls iso8859-10
+NLS ISO 8859-10 (Latin 6; Nordic)
 CONFIG_NLS_ISO8859_10
   If you want to display filenames with native language characters
   from the Microsoft FAT file system family or from JOLIET CDROMs
@@ -12902,7 +12903,8 @@
   from the Microsoft FAT file system family or from JOLIET CDROMs
   correctly on the screen, you need to include the appropriate
   input/output character sets. Say Y here for the Latin 7 character
-  set, which supports modern Baltic languages including Latvian.
+  set, which supports modern Baltic languages including Latvian
+  and Lithuanian.
 
 NLS ISO 8859-14 (Latin 8; Celtic)
 CONFIG_NLS_ISO8859_14
@@ -12926,8 +12928,8 @@
   Portuguese, Spanish, and Swedish. Latin 9 is an update to
   Latin 1 (ISO 8859-1) that removes a handful of rarely used
   characters and instead adds support for Estonian, corrects the
-  support for French and Finnish, and adds the new Euro character.  If
-  unsure, say Y.
+  support for French and Finnish, and adds the new Euro character.
+  If unsure, say Y.
 
 NLS KOI8-R (Russian) 
 CONFIG_NLS_KOI8_R



