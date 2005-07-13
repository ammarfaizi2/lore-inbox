Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262206AbVGMRsp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262206AbVGMRsp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 13:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262064AbVGMRhT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 13:37:19 -0400
Received: from mta04.mail.t-online.hu ([195.228.240.57]:19961 "EHLO
	mta04.mail.t-online.hu") by vger.kernel.org with ESMTP
	id S262126AbVGMRfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 13:35:12 -0400
Subject: [PATCH 19/19] Kconfig I18N: UI: Hungarian translation
From: Egry =?ISO-8859-1?Q?G=E1bor?= <gaboregry@t-online.hu>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       Massimo Maiurana <maiurana@inwind.it>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       KernelFR <kernelfr@traduc.org>,
       Arnaldo Carvalho de Melo <acme@conectiva.com.br>
In-Reply-To: <1121273456.2975.3.camel@spirit>
References: <1121273456.2975.3.camel@spirit>
Content-Type: text/plain; charset=UTF-8
Date: Wed, 13 Jul 2005 19:35:05 +0200
Message-Id: <1121276105.2975.52.camel@spirit>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hungarian translation of the configuration interfaces.

Signed-off-by: Egry Gabor <gaboregry@t-online.hu>
---

 po/hu.po |  953 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 953 insertions(+)

diff -puN /dev/null po/hu.po
--- /dev/null	2005-07-13 15:43:03.451152136 +0200
+++ linux-2.6.13-rc3-i18n-kconfig-gabaman/po/hu.po	2005-07-13 18:32:20.000000000 +0200
@@ -0,0 +1,953 @@
+# translation of hu.po to hungarian
+# Linux kernel 2.6.13-rc2 Kconfig .pot file
+# Licensed under GNU GPL v2
+#
+# The Linux Kernel Translation Project
+# http://tlktp.sourceforge.net
+#
+# Translators:
+# - Egry Gábor <gabaman@users.sourceforge.net>
+#
+msgid ""
+msgstr ""
+"Project-Id-Version: Linux 2.6.13-rc2\n"
+"Report-Msgid-Bugs-To: \n"
+"POT-Creation-Date: 2005-07-11 19:55+0200\n"
+"PO-Revision-Date: 2005-07-11 16:44+0200\n"
+"Last-Translator: Egry Gábor <gabaman@users.sourceforge.net>\n"
+"Language-Team: TLKTP <tlktp-general@lists.sourceforge.net>\n"
+"MIME-Version: 1.0\n"
+"Content-Type: text/plain; charset=UTF-8\n"
+"Content-Transfer-Encoding: 8bit\n"
+"X-Generator: KBabel 1.10.1\n"
+
+#: scripts/lxdialog/checklist.c:117 scripts/lxdialog/menubox.c:149
+msgid "Select"
+msgstr "Kiválaszt"
+
+#: scripts/lxdialog/checklist.c:118 scripts/lxdialog/inputbox.c:36
+#: scripts/lxdialog/menubox.c:151
+msgid " Help "
+msgstr " Segítség "
+
+#: scripts/lxdialog/inputbox.c:35 scripts/lxdialog/msgbox.c:74
+msgid "  Ok  "
+msgstr "  OK  "
+
+#: scripts/lxdialog/menubox.c:150 scripts/lxdialog/textbox.c:126
+msgid " Exit "
+msgstr " Kilép "
+
+#: scripts/lxdialog/menubox.c:441 scripts/lxdialog/yesno.c:91
+#: scripts/kconfig/gconf.c:1109 scripts/kconfig/qconf.cc:645
+msgid "y"
+msgstr "i"
+
+#: scripts/lxdialog/menubox.c:445 scripts/lxdialog/yesno.c:95
+#: scripts/kconfig/gconf.c:422 scripts/kconfig/gconf.c:1109
+#: scripts/kconfig/gconf.c:1270 scripts/kconfig/gconf.c:1271
+#: scripts/kconfig/qconf.cc:243 scripts/kconfig/qconf.cc:436
+#: scripts/kconfig/qconf.cc:645
+msgid "Y"
+msgstr "I"
+
+#: scripts/lxdialog/menubox.c:449 scripts/lxdialog/yesno.c:99
+#: scripts/kconfig/gconf.c:1105 scripts/kconfig/qconf.cc:649
+msgid "n"
+msgstr "n"
+
+#: scripts/lxdialog/menubox.c:453 scripts/lxdialog/yesno.c:103
+#: scripts/kconfig/gconf.c:410 scripts/kconfig/gconf.c:1105
+#: scripts/kconfig/gconf.c:1259 scripts/kconfig/gconf.c:1260
+#: scripts/kconfig/qconf.cc:244 scripts/kconfig/qconf.cc:256
+#: scripts/kconfig/qconf.cc:257 scripts/kconfig/qconf.cc:434
+#: scripts/kconfig/qconf.cc:649
+msgid "N"
+msgstr "N"
+
+#: scripts/lxdialog/yesno.c:33
+msgid " Yes "
+msgstr " Igen "
+
+#: scripts/lxdialog/yesno.c:34
+msgid "  No  "
+msgstr " Nem "
+
+#: scripts/kconfig/mconf.c:164
+msgid ""
+"Arrow keys navigate the menu.  <Enter> selects submenus --->.  Highlighted "
+"letters are hotkeys.  Pressing <Y> includes, <N> excludes, <M> modularizes "
+"features.  Press <Esc><Esc> to exit, <?> for Help, </> for Search.  Legend: "
+"[*] built-in  [ ] excluded  <M> module  < > module capable"
+msgstr ""
+"A nyíl gombokkal lehet navigálni a menüben.  Az <Enter> kiválasztja az "
+"almenüket --->.  A kiemelt betűk a gyorsgombok.  Az <I> lenyomása a "
+"tartalmazás, az <N> a kihagyás az <M> a modularizásás.  Az <ESC><ESC> "
+"megnyomása a kilépés, a <?> a Segítség, a </> a Keresés.  Jelölés: [*] "
+"befordított  [ ] kihagyott  <M> modul  < > modul képes."
+
+#: scripts/kconfig/mconf.c:171
+msgid ""
+"Use the arrow keys to navigate this window or press the hotkey of the item "
+"you wish to select followed by the <SPACE BAR>. Press <?> for additional "
+"information about this option."
+msgstr ""
+"Használja a nyíl billentyűket az ablakban történő navigáláshoz vagy nyomja "
+"meg az elemhez tartozó gyorsbillentyűt a kiválasztáshoz a <SZÓKÖZ> billentyű "
+"lenyomása után. Nyomja le a <?> gombot az opcióval kapcsolatos további "
+"információk eléréséhez."
+
+#: scripts/kconfig/mconf.c:176
+msgid ""
+"Please enter a decimal value. Fractions will not be accepted.  Use the <TAB> "
+"key to move from the input field to the buttons below it."
+msgstr ""
+"Kérem adjon meg egy decimális értéket. A törtek nem lesznek elfogadva.  "
+"Használja a <TAB> gombot a beviteli mezőről az alsó gombokra történő "
+"mozgáshoz."
+
+#: scripts/kconfig/mconf.c:180
+msgid ""
+"Please enter a hexadecimal value. Use the <TAB> key to move from the input "
+"field to the buttons below it."
+msgstr ""
+"Kérem adjon meg egy hexadecimális értéket.  Használja a <TAB> gombot a "
+"beviteli mezőről az alsó gombokra történő mozgáshoz."
+
+#: scripts/kconfig/mconf.c:183
+msgid ""
+"Please enter a string value. Use the <TAB> key to move from the input field "
+"to the buttons below it."
+msgstr ""
+"Kérlem adjon meg egy szöveges értéket.  Használja a <TAB> gombot a beviteli "
+"mezőről az alsó gombokra történő mozgáshoz."
+
+#: scripts/kconfig/mconf.c:186
+msgid ""
+"This feature depends on another which has been configured as a module.\n"
+"As a result, this feature will be built as a module."
+msgstr ""
+"Ez a jellemző függ egy másiktól, ami modulként van beállítva.\n"
+"Emiatt ez a jellemző modulként lesz fordítva."
+
+#: scripts/kconfig/mconf.c:189
+msgid "There is no help available for this kernel option.\n"
+msgstr "Nincs elérhető segítség ehhez a rendszermag opcióhoz.\n"
+
+#: scripts/kconfig/mconf.c:311
+#, c-format
+msgid ""
+"Your display is too small to run Menuconfig!\n"
+"It must be at least 19 lines by 80 columns.\n"
+msgstr ""
+"A kijelző túl kicsi a Menuconfig futtatásához!\n"
+"Legalább 19 sornak és 80 oszlopnak kell lennie.\n"
+
+#: scripts/kconfig/mconf.c:373
+#, c-format
+msgid "Prompt: %s\n"
+msgstr "Prompt: %s\n"
+
+#: scripts/kconfig/mconf.c:374
+#, c-format
+msgid "  Defined at %s:%d\n"
+msgstr "  Definiálva: %s:%d\n"
+
+#: scripts/kconfig/mconf.c:377
+msgid "  Depends on: "
+msgstr "  Függ: "
+
+#: scripts/kconfig/mconf.c:385
+msgid "  Location:\n"
+msgstr "  Helye:\n"
+
+#: scripts/kconfig/mconf.c:391
+msgid "<choice>"
+msgstr "<kiválasztás>"
+
+#: scripts/kconfig/mconf.c:404
+#, c-format
+msgid "Symbol: %s [=%s]\n"
+msgstr "Szimbólum: %s [=%s]\n"
+
+#: scripts/kconfig/mconf.c:411
+msgid "  Selects: "
+msgstr "  Kiválaszt: "
+
+#: scripts/kconfig/mconf.c:420
+msgid "  Selected by: "
+msgstr "  Kiválasztó: "
+
+#: scripts/kconfig/mconf.c:436
+msgid "No matches found.\n"
+msgstr "Nincsenek találatok.\n"
+
+#: scripts/kconfig/mconf.c:507
+#, c-format
+msgid "interrupted(%d)\n"
+msgstr "megszakítva(%d)\n"
+
+#: scripts/kconfig/mconf.c:512
+#, c-format
+msgid ""
+"exit state: %d\n"
+"exit data: '%s'\n"
+msgstr ""
+"kilépési állapot: %d\n"
+"kilépési adat: '%s'\n"
+
+#: scripts/kconfig/mconf.c:518
+#, c-format
+msgid "interrupted\n"
+msgstr "megszakítva\n"
+
+#: scripts/kconfig/mconf.c:535
+msgid "Search Configuration Parameter"
+msgstr "Beállítás Paraméter Keresése"
+
+#: scripts/kconfig/mconf.c:537
+msgid "Enter Keyword"
+msgstr "Kulcsszó megadása"
+
+#: scripts/kconfig/mconf.c:548
+msgid "Search Configuration"
+msgstr "Beállítás Keresése"
+
+#: scripts/kconfig/mconf.c:557
+msgid "Search Results"
+msgstr "Keresés Eredményei"
+
+#: scripts/kconfig/mconf.c:627 scripts/kconfig/mconf.c:678
+#: scripts/kconfig/gconf.c:416 scripts/kconfig/gconf.c:1107
+#: scripts/kconfig/gconf.c:1265 scripts/kconfig/gconf.c:1266
+#: scripts/kconfig/qconf.cc:248 scripts/kconfig/qconf.cc:249
+#: scripts/kconfig/qconf.cc:435 scripts/kconfig/qconf.cc:647
+msgid "M"
+msgstr "M"
+
+#: scripts/kconfig/mconf.c:694 scripts/kconfig/mconf.c:701
+#: scripts/kconfig/conf.c:327 scripts/kconfig/qconf.cc:289
+#, c-format
+msgid " (NEW)"
+msgstr " (ÚJ)"
+
+#: scripts/kconfig/mconf.c:730 scripts/kconfig/mconf.c:895
+#: scripts/kconfig/mconf.c:944
+msgid "Main Menu"
+msgstr "Főmenü"
+
+#: scripts/kconfig/mconf.c:745
+msgid "    Load an Alternate Configuration File"
+msgstr "    Alternatív Beállítások Fájl Betöltése"
+
+#: scripts/kconfig/mconf.c:747
+msgid "    Save Configuration to an Alternate File"
+msgstr "   Beállítások mentése egy Alternatív Fájlba"
+
+#: scripts/kconfig/mconf.c:802
+msgid "README"
+msgstr "OLVASSEL"
+
+#: scripts/kconfig/mconf.c:967
+msgid "You have made an invalid entry."
+msgstr "Egy érvénytelen bejegyzést készített."
+
+#: scripts/kconfig/mconf.c:996
+msgid "File does not exist!"
+msgstr "A fájl nem létezik!"
+
+#: scripts/kconfig/mconf.c:999
+msgid "Load Alternate Configuration"
+msgstr "Alternatív Beállítások Betöltése"
+
+#: scripts/kconfig/mconf.c:1025
+msgid "Can't create file!  Probably a nonexistent directory."
+msgstr "Fájl nem hozható létre!  Talán a könyvtár nem létezik."
+
+#: scripts/kconfig/mconf.c:1028
+msgid "Save Alternate Configuration"
+msgstr "Alternatív Beállítások Mentése"
+
+#: scripts/kconfig/mconf.c:1058 scripts/kconfig/gconf.c:278
+#, c-format
+msgid "Linux Kernel v%s Configuration"
+msgstr "Linux Rendszermag v%s Beállítások"
+
+#: scripts/kconfig/mconf.c:1075
+msgid "Do you wish to save your new kernel configuration?"
+msgstr "Mentve legyenek az új rendszermag beállításai?"
+
+#: scripts/kconfig/mconf.c:1083
+#, c-format
+msgid ""
+"\n"
+"\n"
+"Error during writing of the kernel configuration.\n"
+"Your kernel configuration changes were NOT saved.\n"
+"\n"
+msgstr ""
+"\n"
+"\n"
+"Hiba a rendszermag beállításainak írása alatt.\n"
+"A rendszermag beállítások változásai NINCSENEK elmentve.\n"
+"\n"
+
+#: scripts/kconfig/mconf.c:1089
+#, c-format
+msgid ""
+"\n"
+"\n"
+"*** End of Linux kernel configuration.\n"
+"*** Execute 'make' to build the kernel or try 'make help'.\n"
+"\n"
+msgstr ""
+"\n"
+"\n"
+"*** Vége a Linux rendszermag beállításoknak.\n"
+"*** Futtassa a 'make' parancsot a fordításhoz vagy *** próbálkozzon a 'make "
+"help' kiadásával.\n"
+"\n"
+
+#: scripts/kconfig/mconf.c:1094
+#, c-format
+msgid ""
+"\n"
+"\n"
+"Your kernel configuration changes were NOT saved.\n"
+"\n"
+msgstr ""
+"\n"
+"\n"
+"A rendszermag beállítások változásai NINCSENEK elmentve.\n"
+"\n"
+
+#: scripts/kconfig/conf.c:37 scripts/kconfig/gconf.c:44
+msgid "Sorry, no help available for this option yet.\n"
+msgstr "Sajnálom, még nincs elérhető segítség ehhez az opcióhoz.\n"
+
+#: scripts/kconfig/conf.c:59
+#, c-format
+msgid ""
+"aborted!\n"
+"\n"
+msgstr ""
+"megszakítva!\n"
+"\n"
+
+#: scripts/kconfig/conf.c:60
+#, c-format
+msgid "Console input/output is redirected. "
+msgstr "A konzol ki-/bemenete át van irányítva. "
+
+#: scripts/kconfig/conf.c:61
+#, c-format
+msgid ""
+"Run 'make oldconfig' to update configuration.\n"
+"\n"
+msgstr ""
+"Futtassa a 'make oldconfig' parancsot a beállítások frissítéséhez.\n"
+"\n"
+
+#: scripts/kconfig/conf.c:72
+#, c-format
+msgid "(NEW) "
+msgstr "(ÚJ) "
+
+#: scripts/kconfig/conf.c:330
+#, c-format
+msgid "%*schoice"
+msgstr "%*sválasztás"
+
+#: scripts/kconfig/conf.c:473
+#, c-format
+msgid ""
+"*\n"
+"* Restart config...\n"
+"*\n"
+msgstr ""
+"*\n"
+"* Beállítás újraindítása...\n"
+"*\n"
+
+#: scripts/kconfig/conf.c:511
+#, c-format
+msgid "%s: No default config file specified\n"
+msgstr "%s: Nincs alapértelmezett beállítás fájl megadva\n"
+
+#: scripts/kconfig/conf.c:531
+#, c-format
+msgid "%s [-o|-s] config\n"
+msgstr "%s [-o|-s] beállítás\n"
+
+#: scripts/kconfig/conf.c:537
+#, c-format
+msgid "%s: Kconfig file missing\n"
+msgstr "%s: Kconfig fájl hiányzik\n"
+
+#: scripts/kconfig/conf.c:546
+#, c-format
+msgid ""
+"***\n"
+"*** Can't find default configuration \"%s\"!\n"
+"***\n"
+msgstr ""
+"***\n"
+"*** Nem található az alapérelemzett beállítás: \"%s\"!\n"
+"***\n"
+
+#: scripts/kconfig/conf.c:554
+#, c-format
+msgid ""
+"***\n"
+"*** You have not yet configured your kernel!\n"
+"***\n"
+"*** Please run some configurator (e.g. \"make oldconfig\" or\n"
+"*** \"make menuconfig\" or \"make xconfig\").\n"
+"***\n"
+msgstr ""
+"***\n"
+"*** Nincs még beállítva a rendszermag!\n"
+"***\n"
+"*** Kérem futtassa valamelyik beállítót (pl. \"make oldconfig\" vagy\n"
+"*** \"make menuconfig\" vagy \"make xconfig\").\n"
+"***\n"
+
+#: scripts/kconfig/conf.c:583
+#, c-format
+msgid ""
+"\n"
+"*** Error during writing of the kernel configuration.\n"
+"\n"
+msgstr ""
+"\n"
+"*** Hiba a rendszermag beállítások írása közben.\n"
+"\n"
+
+#: scripts/kconfig/confdata.c:91
+#, c-format
+msgid ""
+"#\n"
+"# using defaults found in %s\n"
+"#\n"
+msgstr ""
+"#\n"
+"# A(z) %s fájlban megtalált alapértelmezések használata\n"
+"#\n"
+
+#: scripts/kconfig/confdata.c:315
+#, c-format
+msgid ""
+"#\n"
+"# Automatically generated make config: don't edit\n"
+"# Linux kernel version: %s\n"
+"%s%s#\n"
+msgstr ""
+"#\n"
+"# Automatikusan létrehozva a 'make config' által: ne szerkeszed!\n"
+"# Linux rendszermag verzió: %s\n"
+"%s%s#\n"
+
+#: scripts/kconfig/gconf.c:90 scripts/kconfig/gconf.c:161
+msgid "unknown"
+msgstr "ismeretlen"
+
+#: scripts/kconfig/gconf.c:92
+msgid "boolean"
+msgstr "logikai"
+
+#: scripts/kconfig/gconf.c:94
+msgid "tristate"
+msgstr "háromállapotú"
+
+#: scripts/kconfig/gconf.c:96
+msgid "int"
+msgstr "egész"
+
+#: scripts/kconfig/gconf.c:98
+msgid "hex"
+msgstr "hexa"
+
+#: scripts/kconfig/gconf.c:100
+msgid "string"
+msgstr "sztring"
+
+#: scripts/kconfig/gconf.c:102
+msgid "other"
+msgstr "egyéb"
+
+#: scripts/kconfig/gconf.c:118
+msgid "yes/"
+msgstr "igen/"
+
+#: scripts/kconfig/gconf.c:120
+msgid "mod/"
+msgstr "modul/"
+
+#: scripts/kconfig/gconf.c:122
+msgid "no/"
+msgstr "nem/"
+
+#: scripts/kconfig/gconf.c:124
+msgid "const/"
+msgstr "konstans/"
+
+#: scripts/kconfig/gconf.c:126
+msgid "check/"
+msgstr "ellenőrzés/"
+
+#: scripts/kconfig/gconf.c:128
+msgid "choice/"
+msgstr "választás/"
+
+#: scripts/kconfig/gconf.c:130
+msgid "choiceval/"
+msgstr "értékválasztás/"
+
+#: scripts/kconfig/gconf.c:132
+msgid "printed/"
+msgstr "kinyomtatott/"
+
+#: scripts/kconfig/gconf.c:134
+msgid "valid/"
+msgstr "érvényes/"
+
+#: scripts/kconfig/gconf.c:136
+msgid "optional/"
+msgstr "kiegészítő/"
+
+#: scripts/kconfig/gconf.c:138
+msgid "write/"
+msgstr "írás/"
+
+#: scripts/kconfig/gconf.c:140
+msgid "changed/"
+msgstr "változott/"
+
+#: scripts/kconfig/gconf.c:142
+msgid "new/"
+msgstr "új/"
+
+#: scripts/kconfig/gconf.c:144
+msgid "auto/"
+msgstr "auto/"
+
+#: scripts/kconfig/gconf.c:163
+msgid "prompt"
+msgstr "prompt"
+
+#: scripts/kconfig/gconf.c:165
+msgid "comment"
+msgstr "megjegyzés"
+
+#: scripts/kconfig/gconf.c:167
+msgid "menu"
+msgstr "menü"
+
+#: scripts/kconfig/gconf.c:169
+msgid "default"
+msgstr "alapértelmezett"
+
+#: scripts/kconfig/gconf.c:171
+msgid "choice"
+msgstr "választás"
+
+#: scripts/kconfig/gconf.c:196
+msgid "GUI loading failed !\n"
+msgstr "GUI betöltése sikertelen !\n"
+
+#: scripts/kconfig/gconf.c:328 scripts/kconfig/gconf.c:373
+msgid "Options"
+msgstr "Beállítások"
+
+#: scripts/kconfig/gconf.c:404 scripts/kconfig/qconf.cc:432
+msgid "Name"
+msgstr "Név"
+
+#: scripts/kconfig/gconf.c:428 scripts/kconfig/qconf.cc:439
+msgid "Value"
+msgstr "Érték"
+
+#: scripts/kconfig/gconf.c:533
+msgid "Warning !"
+msgstr "Figyelmeztetés !"
+
+#: scripts/kconfig/gconf.c:547
+msgid ""
+"\n"
+"Save configuration ?\n"
+msgstr ""
+"\n"
+"Beállítások mentése ?\n"
+
+#: scripts/kconfig/gconf.c:607 scripts/kconfig/gconf.c:635
+#: scripts/kconfig/gconf.c:650
+msgid "Error"
+msgstr "Hiba"
+
+#: scripts/kconfig/gconf.c:607
+msgid "Unable to load configuration !"
+msgstr "A beállítások nem tölthetők be !"
+
+#: scripts/kconfig/gconf.c:616
+msgid "Load file..."
+msgstr "Fájl betöltése..."
+
+#: scripts/kconfig/gconf.c:635 scripts/kconfig/gconf.c:650
+msgid "Unable to save configuration !"
+msgstr "A beállítások nem menthetők el !"
+
+#: scripts/kconfig/gconf.c:659
+msgid "Save file as..."
+msgstr "Mentés mint..."
+
+#: scripts/kconfig/gconf.c:776
+msgid ""
+"gkc is copyright (c) 2002 Romain Lievin <roms@lpg.ticalc.org>.\n"
+"Based on the source code from Roman Zippel.\n"
+msgstr ""
+"gkc is copyright (c) 2002 Romain Lievin <roms@lpg.ticalc.org>.\n"
+"Roman Zippel forráskódját alapul véve.\n"
+
+#: scripts/kconfig/gconf.c:794
+msgid ""
+"gkc is released under the terms of the GNU GPL v2.\n"
+"For more information, please see the source code or\n"
+"visit http://www.fsf.org/licenses/licenses.html\n"
+msgstr ""
+"A gkc a GNU GPL v2 szabályai allat jelent meg.\n"
+"A bővebb információkért lásd a forráskódot vagy a\n"
+"<http://www.fsf.org/licenses/licenses.html> oldalt.\n"
+
+#: scripts/kconfig/gconf.c:1107 scripts/kconfig/qconf.cc:647
+msgid "m"
+msgstr "m"
+
+#: scripts/kconfig/gconf.c:1193
+msgid "(NEW)"
+msgstr "(ÚJ)"
+
+#: scripts/kconfig/gconf.c:1617 scripts/kconfig/qconf.cc:1381
+#, c-format
+msgid "%s <config>\n"
+msgstr "%s <konfig>\n"
+
+#: scripts/kconfig/gconf.glade.h:1 scripts/kconfig/qconf.cc:863
+msgid "Back"
+msgstr "Vissza"
+
+#: scripts/kconfig/gconf.glade.h:2
+msgid "Collapse"
+msgstr "Felgördítés"
+
+#: scripts/kconfig/gconf.glade.h:3
+msgid "Collapse the whole tree in the right frame"
+msgstr "Az egész fa felgördítése a jobb keretben"
+
+#: scripts/kconfig/gconf.glade.h:4
+msgid "Expand"
+msgstr "Kiboltás"
+
+#: scripts/kconfig/gconf.glade.h:5
+msgid "Expand the whole tree in the right frame"
+msgstr "Az egész fa kibontása a jobb keretben"
+
+#: scripts/kconfig/gconf.glade.h:6
+msgid "Full"
+msgstr "Teljes"
+
+#: scripts/kconfig/gconf.glade.h:7
+msgid "Full view"
+msgstr "Teljes nézet"
+
+#: scripts/kconfig/gconf.glade.h:8
+msgid "Goes up of one level (single view)"
+msgstr "Egy szinttel feljebb (egyszerű megjelenítés)"
+
+#: scripts/kconfig/gconf.glade.h:9
+msgid "Gtk Kernel Configurator"
+msgstr "Gtk Rendszermag Beállító"
+
+#: scripts/kconfig/gconf.glade.h:10 scripts/kconfig/qconf.cc:868
+msgid "Load"
+msgstr "Betöltés"
+
+#: scripts/kconfig/gconf.glade.h:11
+msgid "Load a config file"
+msgstr "Egy beállítás fájl betöltése"
+
+#: scripts/kconfig/gconf.glade.h:12 scripts/kconfig/qconf.cc:870
+msgid "Save"
+msgstr "Menetés"
+
+#: scripts/kconfig/gconf.glade.h:13
+msgid "Save _as"
+msgstr "Mentés m_int"
+
+#: scripts/kconfig/gconf.glade.h:14
+msgid "Save a config file"
+msgstr "Egy beállítás fájl mentése"
+
+#: scripts/kconfig/gconf.glade.h:15
+msgid "Save the config in .config"
+msgstr "Beállítások mentése a .config fájlba"
+
+#: scripts/kconfig/gconf.glade.h:16
+msgid "Save the config in a file"
+msgstr "Beállítások mentése egy fájlba"
+
+#: scripts/kconfig/gconf.glade.h:17
+msgid "Show _data"
+msgstr "_Adatokat mutat"
+
+#: scripts/kconfig/gconf.glade.h:18
+msgid "Show _debug info"
+msgstr "Nyom_követési infó mutatása"
+
+#: scripts/kconfig/gconf.glade.h:19
+msgid "Show _name"
+msgstr "_Neveket mutat"
+
+#: scripts/kconfig/gconf.glade.h:20
+msgid "Show _range"
+msgstr "É_rtékeket mutat"
+
+#: scripts/kconfig/gconf.glade.h:21
+msgid "Show all _options"
+msgstr "_Összes beállítás mutatása"
+
+#: scripts/kconfig/gconf.glade.h:22
+msgid "Show all options"
+msgstr "Összes beállítás mutatása"
+
+#: scripts/kconfig/gconf.glade.h:23
+msgid "Show masked options"
+msgstr "Maszkolt beállítások mutatása"
+
+#: scripts/kconfig/gconf.glade.h:24
+msgid "Show name"
+msgstr "Neveket mutat"
+
+#: scripts/kconfig/gconf.glade.h:25
+msgid "Show range (Y/M/N)"
+msgstr "Értékeket mutat (I/M/N)"
+
+#: scripts/kconfig/gconf.glade.h:26
+msgid "Show value of the option"
+msgstr "Az opció értékének mutatása"
+
+#: scripts/kconfig/gconf.glade.h:27
+msgid "Single"
+msgstr "Egyszerű"
+
+#: scripts/kconfig/gconf.glade.h:28
+msgid "Single view"
+msgstr "Egyszerű nézet"
+
+#: scripts/kconfig/gconf.glade.h:29
+msgid "Sorry, no help available for this option yet."
+msgstr "Sajnálom, még nincs elérhető segítség ehhez az opcióhoz."
+
+#: scripts/kconfig/gconf.glade.h:30
+msgid "Split"
+msgstr "Felosztott"
+
+#: scripts/kconfig/gconf.glade.h:31
+msgid "Split view"
+msgstr "Felosztott nézet"
+
+#: scripts/kconfig/gconf.glade.h:32
+msgid "_About"
+msgstr "_Névjegy"
+
+#: scripts/kconfig/gconf.glade.h:33
+msgid "_File"
+msgstr "_Fájl"
+
+#: scripts/kconfig/gconf.glade.h:34
+msgid "_Help"
+msgstr "_Súgó"
+
+#: scripts/kconfig/gconf.glade.h:35
+msgid "_Introduction"
+msgstr "_Bemutatás"
+
+#: scripts/kconfig/gconf.glade.h:36
+msgid "_License"
+msgstr "_License"
+
+#: scripts/kconfig/gconf.glade.h:37
+msgid "_Load"
+msgstr "_Betöltés"
+
+#: scripts/kconfig/gconf.glade.h:38
+msgid "_Options"
+msgstr "_Beállítások"
+
+#: scripts/kconfig/gconf.glade.h:39
+msgid "_Quit"
+msgstr "_Kilép"
+
+#: scripts/kconfig/gconf.glade.h:40
+msgid "_Save"
+msgstr "_Menetés"
+
+#: scripts/kconfig/qconf.cc:418
+msgid "Option"
+msgstr "Opció"
+
+#: scripts/kconfig/qconf.cc:861
+msgid "Tools"
+msgstr "Eszközök"
+
+#: scripts/kconfig/qconf.cc:866
+msgid "Quit"
+msgstr "Kilép"
+
+#: scripts/kconfig/qconf.cc:866
+msgid "&Quit"
+msgstr "&Kilép"
+
+#: scripts/kconfig/qconf.cc:868
+msgid "&Load"
+msgstr "&Betöltés"
+
+#: scripts/kconfig/qconf.cc:870
+msgid "&Save"
+msgstr "&Menetés"
+
+#: scripts/kconfig/qconf.cc:872
+msgid "Save As..."
+msgstr "Mentés mint..."
+
+#: scripts/kconfig/qconf.cc:872
+msgid "Save &As..."
+msgstr "M&entés mint"
+
+#: scripts/kconfig/qconf.cc:874
+msgid "Single View"
+msgstr "Egyszerű Nézet"
+
+#: scripts/kconfig/qconf.cc:874 scripts/kconfig/qconf.cc:876
+msgid "Split View"
+msgstr "Felosztott nézet"
+
+#: scripts/kconfig/qconf.cc:878
+msgid "Full View"
+msgstr "Teljes nézet"
+
+#: scripts/kconfig/qconf.cc:881
+msgid "Show Name"
+msgstr "Neveket mutat"
+
+#: scripts/kconfig/qconf.cc:885
+msgid "Show Range"
+msgstr "Értékeket mutat"
+
+#: scripts/kconfig/qconf.cc:889
+msgid "Show Data"
+msgstr "Adatokat mutat"
+
+#: scripts/kconfig/qconf.cc:893
+msgid "Show All Options"
+msgstr "Összes beállítás mutatása"
+
+#: scripts/kconfig/qconf.cc:897
+msgid "Show Debug Info"
+msgstr "Nyomkövetési infó mutatása"
+
+#: scripts/kconfig/qconf.cc:902
+msgid "Introduction"
+msgstr "Bemutatás"
+
+#: scripts/kconfig/qconf.cc:904
+msgid "About"
+msgstr "Névjegy"
+
+#: scripts/kconfig/qconf.cc:919
+msgid "&File"
+msgstr "&Fájl"
+
+#: scripts/kconfig/qconf.cc:928
+msgid "&Option"
+msgstr "&Beállítások"
+
+#: scripts/kconfig/qconf.cc:939
+msgid "&Help"
+msgstr "&Súgó"
+
+#: scripts/kconfig/qconf.cc:1052
+msgid "type: "
+msgstr "típus: "
+
+#: scripts/kconfig/qconf.cc:1055
+msgid " (choice)"
+msgstr " (választás)"
+
+#: scripts/kconfig/qconf.cc:1058
+msgid "reverse dep: "
+msgstr "inverz függőség: "
+
+#: scripts/kconfig/qconf.cc:1066
+msgid "prompt: "
+msgstr "prompt: "
+
+#: scripts/kconfig/qconf.cc:1071
+msgid "default: "
+msgstr "alapértelmezett: "
+
+#: scripts/kconfig/qconf.cc:1077
+msgid "choice: "
+msgstr "választás: "
+
+#: scripts/kconfig/qconf.cc:1083
+msgid "select: "
+msgstr "kiválasztás: "
+
+#: scripts/kconfig/qconf.cc:1088
+msgid "range: "
+msgstr "tartomány: "
+
+#: scripts/kconfig/qconf.cc:1093
+msgid "unknown property: "
+msgstr "ismeretlen tulajdonság: "
+
+#: scripts/kconfig/qconf.cc:1120
+#, c-format
+msgid "defined at %s:%d<br><br>"
+msgstr "definiálva: %s:%d<br><br>"
+
+#: scripts/kconfig/qconf.cc:1130
+msgid "Unable to load configuration!"
+msgstr "Nem lehet betölteni a beállításokat!"
+
+#: scripts/kconfig/qconf.cc:1137 scripts/kconfig/qconf.cc:1146
+msgid "Unable to save configuration!"
+msgstr "Nem lehet elmenteni a beállításokat!"
+
+#: scripts/kconfig/qconf.cc:1282
+msgid "Save configuration?"
+msgstr "Konfigurácó mentése?"
+
+#: scripts/kconfig/qconf.cc:1284
+msgid "&Save Changes"
+msgstr "Változások &Mentése"
+
+#: scripts/kconfig/qconf.cc:1285
+msgid "&Discard Changes"
+msgstr "Változások &Eldobása"
+
+#: scripts/kconfig/qconf.cc:1286
+msgid "Cancel Exit"
+msgstr "Mégsem"
+
+#: scripts/kconfig/qconf.cc:1318
+msgid ""
+"qconf is Copyright (C) 2002 Roman Zippel <zippel@linux-m68k.org>.\n"
+"\n"
+"Bug reports and feature request can also be entered at http://bugzilla."
+"kernel.org/\n"
+msgstr ""
+"qconf is Copyright (C) 2002 Roman Zippel <zippel@linux-m68k.org>.\n"
+"\n"
+"A hibajelzést és a fejlesztési javaslatokat el lehet küldeni a http://"
+"bugzilla.kernel.org/ címre (kizárólag angolul).\n"
_


