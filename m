Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263109AbRE1Rq4>; Mon, 28 May 2001 13:46:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263110AbRE1Rqq>; Mon, 28 May 2001 13:46:46 -0400
Received: from srvr2.telecom.lt ([212.59.0.1]:43986 "EHLO mail.takas.lt")
	by vger.kernel.org with ESMTP id <S263109AbRE1Rqh>;
	Mon, 28 May 2001 13:46:37 -0400
Message-Id: <200105281746.TAA1134871@mail.takas.lt>
Date: Mon, 28 May 2001 19:41:24 +0200 (EET)
From: Nerijus Baliunas <nerijus@users.sourceforge.net>
Subject: [PATCH] fix more typos in Configure.help and fs/nls/Config.in
To: linux-kernel@vger.kernel.org
cc: alan@lxorguk.ukuu.org.uk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Disposition: INLINE
X-Mailer: Mahogany, 0.63 'Saugus', compiled for Linux 2.2.19 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The ISO639 registrars call it "Belarusian". See
http://lcweb.loc.gov/standards/iso639-2/langhome.html
under "English Name of Language".

Against 2.4.5-ac2:


--- Configure.help.orig Mon May 28 19:23:18 2001
+++ Configure.help      Mon May 28 19:31:50 2001
@@ -12838,7 +12838,7 @@
   only, not to the file contents. You can include several codepages;
   say Y here if you want to include the DOS codepage for Thai.

-Windows CP1251 (Bulgarian, Belarussian)
+Windows CP1251 (Bulgarian, Belarusian)
 CONFIG_NLS_CODEPAGE_1251
   The Microsoft FAT file system family can deal with filenames in
   native language character sets. These character sets are stored in
@@ -12847,7 +12847,7 @@
   DOS/Windows partitions correctly. This does apply to the filenames
   only, not to the file contents. You can include several codepages;
   say Y here if you want to include the DOS codepage for Russian and
-  Bulgarian and Belarussian.
+  Bulgarian and Belarusian.

 Japanese charsets (Shift-JIS, EUC-JP)
 CONFIG_NLS_CODEPAGE_932
@@ -12938,7 +12938,7 @@
   from the Microsoft FAT file system family or from JOLIET CDROMs
   correctly on the screen, you need to include the appropriate
   input/output character sets. Say Y here for ISO8859-5, a Cyrillic
-  character set with which you can type Bulgarian, Byelorussian,
+  character set with which you can type Bulgarian, Belarusian,
   Macedonian, Russian, Serbian, and Ukrainian. Note that the charset
   KOI8-R is preferred in Russia.

@@ -13027,13 +13027,13 @@
   input/output character sets. Say Y here for the preferred Russian
   character set.

-NLS KOI8-U/RU (Ukrainian, Belarussian)
+NLS KOI8-U/RU (Ukrainian, Belarusian)
 CONFIG_NLS_KOI8_U
   If you want to display filenames with native language characters
   from the Microsoft FAT file system family or from JOLIET CDROMs
   correctly on the screen, you need to include the appropriate
   input/output character sets. Say Y here for the preferred Ukrainian
-  (koi8-u) and Belarussian (koi8-ru) character sets.
+  (koi8-u) and Belarusian (koi8-ru) character sets.

 NLS UTF8
 CONFIG_NLS_UTF8
@@ -19014,7 +19014,7 @@
 # LocalWords:  prio Micom xIO dwmw rimi OMIRR omirr omirrd unicode ntfs cmu NIC
 # LocalWords:  Braam braam Schmidt's freiburg nls codepages codepage Romanian
 # LocalWords:  Slovak Slovenian Sorbian Nordic iso Catalan Faeroese Galician SZ
-# LocalWords:  Valencian Slovene Esperanto Estonian Latvian Byelorussian KOI mt
+# LocalWords:  Valencian Slovene Esperanto Estonian Latvian Belarusian KOI mt
 # LocalWords:  charset Inuit Greenlandic Sami Lappish koi Alexey Kuznetsov's sa
 # LocalWords:  Specialix specialix DTR RTS RTSCTS cycladesZ Exabyte ftape's inr
 # LocalWords:  Iomega's LBFM claus ZFTAPE VFS zftape zft William's lzrw DFLT kb



--- Config.in.orig      Sun May 27 00:10:50 2001
+++ Config.in   Mon May 28 19:32:25 2001
@@ -29,7 +29,7 @@
   tristate 'Codepage 852 (Central/Eastern Europe)' CONFIG_NLS_CODEPAGE_852
   tristate 'Codepage 855 (Cyrillic)'               CONFIG_NLS_CODEPAGE_855
   tristate 'Codepage 857 (Turkish)'                CONFIG_NLS_CODEPAGE_857
-  tristate 'Codepage 860 (Portugese)'              CONFIG_NLS_CODEPAGE_860
+  tristate 'Codepage 860 (Portuguese)'              CONFIG_NLS_CODEPAGE_860
   tristate 'Codepage 861 (Icelandic)'              CONFIG_NLS_CODEPAGE_861
   tristate 'Codepage 862 (Hebrew)'                 CONFIG_NLS_CODEPAGE_862
   tristate 'Codepage 863 (Canadian French)'        CONFIG_NLS_CODEPAGE_863
@@ -43,7 +43,7 @@
   tristate 'Korean charset (CP949, EUC-KR)'        CONFIG_NLS_CODEPAGE_949
   tristate 'Thai charset (CP874, TIS-620)'         CONFIG_NLS_CODEPAGE_874
   tristate 'Hebrew charsets (ISO-8859-8, CP1255)'  CONFIG_NLS_ISO8859_8
-  tristate 'Windows CP1251 (Bulgarian, Belarussian)' CONFIG_NLS_CODEPAGE_1251
+  tristate 'Windows CP1251 (Bulgarian, Belarusian)' CONFIG_NLS_CODEPAGE_1251
   tristate 'NLS ISO 8859-1  (Latin 1; Western European Languages)' CONFIG_NLS_ISO8859_1
   tristate 'NLS ISO 8859-2  (Latin 2; Slavic/Central European Languages)' CONFIG_NLS_ISO8859_2
   tristate 'NLS ISO 8859-3  (Latin 3; Esperanto, Galician, Maltese, Turkish)' CONFIG_NLS_ISO8859_3
@@ -56,7 +56,7 @@
   tristate 'NLS ISO 8859-14 (Latin 8; Celtic)'      CONFIG_NLS_ISO8859_14
   tristate 'NLS ISO 8859-15 (Latin 9; Western European Languages with Euro)' CONFIG_NLS_ISO8859_15
   tristate 'NLS KOI8-R (Russian)'                   CONFIG_NLS_KOI8_R
-  tristate 'NLS KOI8-U/RU (Ukrainian, Belarussian)' CONFIG_NLS_KOI8_U
+  tristate 'NLS KOI8-U/RU (Ukrainian, Belarusian)' CONFIG_NLS_KOI8_U
   tristate 'NLS UTF8'                               CONFIG_NLS_UTF8
   endmenu
 fi


