Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264797AbTB0LlH>; Thu, 27 Feb 2003 06:41:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264788AbTB0Lkd>; Thu, 27 Feb 2003 06:40:33 -0500
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:29455 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S264797AbTB0LjG>; Thu, 27 Feb 2003 06:39:06 -0500
Date: Thu, 27 Feb 2003 12:49:17 +0100
From: Matthias Andree <ma@dt.e-technik.uni-dortmund.de>
To: Linus Torvalds <torvalds@transmeta.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [BK PATCH] BK-kernel-tools/shortlog update 4/5
Message-ID: <20030227114917.GA15261@merlin.emma.line.org>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 4 out of 5 total that adds new addresses to\nthe BK-kernel-tools/shortlog file.\nTo be applied in order.\n\nBy Vitezslav Samel and myself, Matthias Andree.
You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.34, 2003-02-14 20:40:42+01:00, matthias.andree@gmx.de
  Vitezslav Samel has figured out another 31 address-to-name mappings.


 shortlog |   54 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 53 insertions(+), 1 deletion(-)


diff -Nru a/shortlog b/shortlog
--- a/shortlog	Thu Feb 27 12:43:49 2003
+++ b/shortlog	Thu Feb 27 12:43:49 2003
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.66 2003/01/18 12:44:33 emma Exp $
+# $Id: lk-changelog.pl,v 0.73 2003/02/14 10:45:45 vita Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -141,6 +141,8 @@
 'bdschuym@pandora.be' => 'Bart De Schuymer',
 'beattie@beattie-home.net' => 'Brian Beattie', # from david.nelson
 'benh@kernel.crashing.org' => 'Benjamin Herrenschmidt',
+'benh@zion.wanadoo.fr' => 'Benjamin Herrenschmidt',
+'bergner@vnet.ibm.com' => 'Peter Bergner',
 'bero@arklinux.org' => 'Bernhard Rosenkraenzer',
 'bfennema@falcon.csc.calpoly.edu' => 'Ben Fennema',
 'bgerst@didntduck.org' => 'Brian Gerst',
@@ -187,6 +189,7 @@
 'cruault@724.com' => 'Charles-Edouard Ruault',
 'ctindel@cup.hp.com' => 'Chad N. Tindel',
 'cubic@miee.ru' => 'Ruslan U. Zakirov',
+'cw@f00f.org' => 'Chris Wedgwood',
 'cyeoh@samba.org' => 'Christopher Yeoh',
 'da-x@gmx.net' => 'Dan Aloni',
 'daisy@teetime.dynamic.austin.ibm.com' => 'Daisy Chang', # from shortlog
@@ -246,6 +249,7 @@
 'drow@nevyn.them.org' => 'Daniel Jacobowitz',
 'dsaxena@mvista.com' => 'Deepak Saxena',
 'duncan.sands@math.u-psud.fr' => 'Duncan Sands',
+'dwmw2@dwmw2.baythorne.internal' => 'David Woodhouse',
 'dwmw2@infradead.org' => 'David Woodhouse',
 'dwmw2@redhat.com' => 'David Woodhouse',
 'dz@cs.unitn.it' => 'Massimo Dal Zotto',
@@ -256,6 +260,7 @@
 'edv@macrolink.com' => 'Ed Vance',
 'edward_peng@dlink.com.tw' => 'Edward Peng',
 'efocht@ess.nec.de' => 'Erich Focht',
+'eike-kernel@sf-tec.de' => 'Rolf Eike Beer', # sent by himself
 'eike@bilbo.math.uni-mannheim.de' => 'Rolf Eike Beer',
 'elenstev@mesatop.com' => 'Steven Cole',
 'engebret@us.ibm.com' => 'Dave Engebretsen',
@@ -264,6 +269,7 @@
 'erik@aarg.net' => 'Erik Arneson',
 'erik_habbinga@hp.com' => 'Erik Habbinga',
 'eyal@eyal.emu.id.au' => 'Eyal Lebedinsky', # lbdb
+'falk.hueffner@student.uni-tuebingen.de' => 'Falk Hueffner',
 'fbl@conectiva.com.br' => 'Flávio Bruno Leitner', # google
 'fdavis@si.rr.com' => 'Frank Davis',
 'felipewd@terra.com.br' => 'Felipe Damasio', # by self (did not ask to include the W.)
@@ -291,6 +297,7 @@
 'garloff@suse.de' => 'Kurt Garloff',
 'geert@linux-m68k.org' => 'Geert Uytterhoeven',
 'george@mvista.com' => 'George Anzinger',
+'georgn@somanetworks.com' => 'Georg Nikodym',
 'gerg@moreton.com.au' => 'Greg Ungerer',
 'gerg@snapgear.com' => 'Greg Ungerer',
 'ghoz@sympatico.ca' => 'Ghozlane Toumi',
@@ -337,6 +344,7 @@
 'ica2_ts@csv.ica.uni-stuttgart.de' => 'Thiemo Seufer', # google
 'info@usblcd.de' =>  'Adams IT Services',
 'ink@jurassic.park.msu.ru' => 'Ivan Kokshaysky',
+'ionut@badula.org' => 'Ion Badulescu',
 'ionut@cs.columbia.edu' => 'Ion Badulescu',
 'ioshadij@hotmail.com' => 'Ishan O. Jayawardena',
 'irohlfs@irohlfs.de' => 'Ingo Rohlfs',
@@ -351,6 +359,7 @@
 'james_mcmechan@hotmail.com' => 'James McMechan',
 'jamey.hicks@hp.com' => 'Jamey Hicks',
 'jamey@crl.dec.com' => 'Jamey Hicks',
+'jamie@shareable.org' => 'Jamie Lokier',
 'jani@astechnix.ro' => 'Jani Monoses',
 'jani@iv.ro' => 'Jani Monoses',
 'jb@jblache.org' => 'Julien Blache',
@@ -438,6 +447,7 @@
 'kkeil@suse.de' => 'Karsten Keil',
 'kmsmith@umich.edu' => 'Kendrick M. Smith',
 'knan@mo.himolde.no' => 'Erik Inge Bolsø',
+'kochi@hpc.bs1.fc.nec.co.jp' => 'Kochi Takayoshi',
 'komujun@nifty.com' => 'Jun Komuro', # google
 'kraxel@bytesex.org' => 'Gerd Knorr',
 'kraxel@suse.de' => 'Gerd Knorr',
@@ -445,10 +455,12 @@
 'kronos@kronoz.cjb.net' => 'Luca Tettamanti',
 'kuba@mareimbrium.org' => 'Kuba Ober',
 'kuebelr@email.uc.edu' => 'Robert Kuebel',
+'kunihiro@ipinfusion.com' => 'Kunihiro Ishiguro',
 'kuznet@mops.inr.ac.ru' => 'Alexey Kuznetsov',
 'kuznet@ms2.inr.ac.ru' => 'Alexey Kuznetsov',
 'ladis@psi.cz' => 'Ladislav Michl',
 'laforge@gnumonks.org' => 'Harald Welte',
+'latten@austin.ibm.com' => 'Joy Latten',
 'laurent@latil.nom.fr' => 'Laurent Latil',
 'lawrence@the-penguin.otak.com' => 'Lawrence Walton',
 'ldb@ldb.ods.org' => 'Luca Barbieri',
@@ -464,6 +476,7 @@
 'lm@bitmover.com' => 'Larry McVoy',
 'lord@sgi.com' => 'Stephen Lord',
 'lowekamp@cs.wm.edu' => 'Bruce B. Lowekamp', # lbdb
+'luben@splentec.com' => 'Luben Tuikov',
 'luc.vanoostenryck@easynet.be' => 'Luc Van Oostenryck', # lbdb
 'lucasvr@terra.com.br' => 'Lucas Correia Villa Real', # google
 'm.c.p@wolk-project.de' => 'Marc-Christian Petersen',
@@ -473,6 +486,7 @@
 'maneesh@in.ibm.com' => 'Maneesh Soni',
 'manfred@colorfullife.com' => 'Manfred Spraul',
 'manik@cisco.com' => 'Manik Raina',
+'manish@zambeel.com' => 'Manish Lachwani',
 'mannthey@us.ibm.com' => 'Keith Mannthey',
 'marc@mbsi.ca' => 'Marc Boucher',
 'marcel@holtmann.org' => 'Marcel Holtmann', # sent by himself
@@ -535,12 +549,15 @@
 'nahshon@actcom.co.il' => 'Itai Nahshon',
 'nathans@sgi.com' => 'Nathan Scott',
 'neilb@cse.unsw.edu.au' => 'Neil Brown',
+'neilt@slimy.greenend.org.uk' => 'Neil Turton',
 'nemosoft@smcc.demon.nl' => 'Nemosoft Unv.',
 'netfilter@interlinx.bc.ca' => 'Brian J. Murrell',
+'nick.holloway@pyrites.org.uk' => 'Nick Holloway',
 'nico@cam.org' => 'Nicolas Pitre',
 'nicolas.aspert@epfl.ch' => 'Nicolas Aspert',
 'nicolas.mailhot@laposte.net' => 'Nicolas Mailhot',
 'nkbj@image.dk' => 'Niels Kristian Bech Jensen',
+'nlaredo@transmeta.com' => 'Nathan Laredo',
 'nmiell@attbi.com' => 'Nicholas Miell',
 'nobita@t-online.de' => 'Andreas Busch',
 'okir@suse.de' => 'Olaf Kirch', # lbdb
@@ -557,6 +574,7 @@
 'os@emlix.com' => 'Oskar Schirmer', # sent by himself
 'osst@riede.org' => 'Willem Riede',
 'otaylor@redhat.com' => 'Owen Taylor',
+'p.guehring@futureware.at' => 'Philipp Gühring',
 'p2@ace.ulyssis.sutdent.kuleuven.ac.be' => 'Peter De Shrijver',
 'p_gortmaker@yahoo.com' => 'Paul Gortmaker',
 'pasky@ucw.cz' => 'Petr Baudis',
@@ -606,6 +624,7 @@
 'ralf@linux-mips.org' => 'Ralf Bächle',
 'ramune@net-ronin.org' => 'Daniel A. Nobuto',
 'randy.dunlap@verizon.net' => 'Randy Dunlap',
+'raul@pleyades.net' => 'Raul Nunez de Arenas Coronado',
 'ray-lk@madrabbit.org' => 'Ray Lee',
 'rbh00@utsglobal.com' => 'Richard Hitt', # asked him, he prefers Richard
 'rbt@mtlb.co.uk' => 'Robert Cardell',
@@ -631,6 +650,7 @@
 'robert.olsson@data.slu.se' => 'Robert Olsson',
 'rohit.seth@intel.com' => 'Rohit Seth',
 'rol@as2917.net' => 'Paul Rolland',
+'roland@frob.com' => 'Roland McGrath',
 'roland@redhat.com' => 'Roland McGrath',
 'roland@topspin.com' => 'Roland Dreier',
 'romieu@cogenit.fr' => 'François Romieu',
@@ -675,6 +695,7 @@
 'shaggy@austin.ibm.com' => 'Dave Kleikamp',
 'shaggy@kleikamp.austin.ibm.com' => 'Dave Kleikamp',
 'shaggy@shaggy.austin.ibm.com' => 'Dave Kleikamp', # lbdb
+'shemminger@osdl.org' => 'Stephen Hemminger',
 'shingchuang@via.com.tw' => 'Shing Chuang',
 'silicon@falcon.sch.bme.hu' => 'Szilárd Pásztor', # google
 'simonb@lipsyncpost.co.uk' => 'Simon Burley',
@@ -684,12 +705,16 @@
 'snailtalk@linux-mandrake.com' => 'Geoffrey Lee', # by himself
 'solar@openwall.com' => 'Solar Designer',
 'sparker@sun.com' => 'Steven Parker', # by Duncan Laurie
+'sprite@sprite.fr.eu.org' => 'Jeremie Koenig',
 'spse@secret.org.uk' => 'Simon Evans', # by Kristian Peters
+'sri@us.ibm.com' => 'Sridhar Samudrala',
 'sridhar@dyn9-47-18-140.beaverton.ibm.com' => 'Sridhar Samudrala',
 'sridhar@dyn9-47-18-86.beaverton.ibm.com' => 'Sridhar Samudrala',
 'sridhar@x1-6-00-10-a4-8b-06-f6.attbi.com' => 'Sridhar Samudrala',
 'srompf@isg.de' => 'Stefan Rompf',
+'stanley.wang@linux.co.intel.com' => 'Stanley Wang',
 'steiner@sgi.com' => 'Jack Steiner',
+'stekloff@w-stekloff.beaverton.ibm.com' => 'Daniel Stekloff',
 'stelian.pop@fr.alcove.com' => 'Stelian Pop',
 'stelian@popies.net' => 'Stelian Pop',
 'stern@rowland.harvard.edu' => 'Alan Stern',
@@ -718,10 +743,12 @@
 'thiel@ksan.de' => 'Florian Thiel', # lbdb
 'thockin@freakshow.cobalt.com' => 'Tim Hockin',
 'thockin@sun.com' => 'Tim Hockin',
+'thomas@bender.thinknerd.de' => 'Thomas Walpuski',
 'tigran@aivazian.name' => 'Tigran Aivazian',
 'tim@physik3.uni-rostock.de' => 'Tim Schmielau',
 'tmcreynolds@nvidia.com' => 'Tom McReynolds',
 'tmolina@cox.net' => 'Thomas Molina',
+'toml@us.ibm.com' => 'Tom Lendacky',
 'tomita@cinet.co.jp' => 'Osamu Tomita',
 'tomlins@cam.org' => 'Ed Tomlinson',
 'tony.luck@intel.com' => 'Tony Luck',
@@ -756,6 +783,7 @@
 'vojtech@ucw.cz' => 'Vojtech Pavlik', # added by himself
 'wa@almesberger.net' => 'Werner Almesberger',
 'wahrenbruch@kobil.de' => 'Thomas Wahrenbruch',
+'warlord@mit.edu' => 'Derek Atkins',
 'wd@denx.de' => 'Wolfgang Denk',
 'wes@infosink.com' => 'Wes Schreiner',
 'wg@malloc.de' => 'Wolfram Gloger', # lbdb
@@ -769,14 +797,17 @@
 'wli@holomorphy.com' => 'William Lee Irwin III',
 'wolfgang.fritz@gmx.net' => 'Wolfgang Fritz', # by Kristian Peters
 'wolfgang@iksw-muees.de' => 'Wolfgang Muees',
+'wriede@riede.org' => 'Willem Riede',
 'wrlk@riede.org' => 'Willem Riede',
 'wstinson@infonie.fr' => 'William Stinson',
 'wstinson@wanadoo.fr' => 'William Stinson',
 'xkaspa06@stud.fee.vutbr.cz' => 'Tomas Kasparek',
+'ya@slamail.org' => 'Yaacov Akiba Slama',
 'yokota@netlab.is.tsukuba.ac.jp' => 'Yokota Hiroshi',
 'yoshfuji@linux-ipv6.org' => 'Hideaki Yoshifuji', # lbdb
 'yuri@acronis.com' => 'Yuri Per', # lbdb
 'zaitcev@redhat.com' => 'Pete Zaitcev',
+'zinx@epicsol.org' => 'Zinx Verituse',
 'zippel@linux-m68k.org' => 'Roman Zippel',
 'zubarev@us.ibm.com' => 'Irene Zubarev', # google
 'zwane@commfireservices.com' => 'Zwane Mwaikambo',
@@ -1307,6 +1338,27 @@
 __END__
 # --------------------------------------------------------------------
 # $Log: lk-changelog.pl,v $
+# Revision 0.73  2003/02/14 10:45:45  vita
+# Added 5 new addresses found by Google.
+#
+# Revision 0.72  2003/02/06 16:10:23  vita
+# Added 6 new addresses found by Google.
+#
+# Revision 0.71  2003/02/05 11:22:06  emma
+# New addresses Vita pulled out.
+#
+# Revision 0.70  2003/02/03 14:58:04  emma
+# Vita dug out more addresses.
+#
+# Revision 0.69  2003/01/28 23:30:02  emma
+# Another four addresses by Vita.
+#
+# Revision 0.68  2003/01/20 10:22:08  emma
+# Add new address for Rolf Eike Beer.
+#
+# Revision 0.67  2003/01/19 14:32:55  emma
+# Further addresses figured out by Vita.
+#
 # Revision 0.66  2003/01/18 12:44:33  emma
 # New addresses found out by Vita.
 #

===================================================================


This BitKeeper patch contains the following changesets:
1.34

# User:	matthias.andree
# Host:	gmx.de
# Root:	/suse/kernel/BK/BK-kernel-tools

# Patch vers:	1.3
# Patch type:	REGULAR

== ChangeSet ==
torvalds@penguin.transmeta.com|ChangeSet|20020201230659|29655|e2e55c41ab787ec2
matthias.andree@gmx.de|ChangeSet|20030118124634|45233
D 1.34 03/02/14 20:40:42+01:00 matthias.andree@gmx.de +1 -0
B torvalds@penguin.transmeta.com|ChangeSet|20020201230659|29655|e2e55c41ab787ec2
C
c Vitezslav Samel has figured out another 31 address-to-name mappings.
K 45219
P ChangeSet
------------------------------------------------

0a0
> torvalds@home.transmeta.com|shortlog|20020518074718|31795|fe9afc709a0edabd matthias.andree@gmx.de|shortlog|20030214194041|22901

== shortlog ==
torvalds@home.transmeta.com|shortlog|20020518074718|31795|fe9afc709a0edabd
matthias.andree@gmx.de|shortlog|20030118124633|54880
D 1.14 03/02/14 20:40:41+01:00 matthias.andree@gmx.de +53 -1
B torvalds@penguin.transmeta.com|ChangeSet|20020201230659|29655|e2e55c41ab787ec2
C
c Vitezslav Samel has figured out another 31 address-to-name mappings.
K 22901
O -rwxrwxr-x
P shortlog
------------------------------------------------

D11 1
I11 1
# $Id: lk-changelog.pl,v 0.73 2003/02/14 10:45:45 vita Exp $
I143 2
'benh@zion.wanadoo.fr' => 'Benjamin Herrenschmidt',
'bergner@vnet.ibm.com' => 'Peter Bergner',
I189 1
'cw@f00f.org' => 'Chris Wedgwood',
I248 1
'dwmw2@dwmw2.baythorne.internal' => 'David Woodhouse',
I258 1
'eike-kernel@sf-tec.de' => 'Rolf Eike Beer', # sent by himself
I266 1
'falk.hueffner@student.uni-tuebingen.de' => 'Falk Hueffner',
I293 1
'georgn@somanetworks.com' => 'Georg Nikodym',
I339 1
'ionut@badula.org' => 'Ion Badulescu',
I353 1
'jamie@shareable.org' => 'Jamie Lokier',
I440 1
'kochi@hpc.bs1.fc.nec.co.jp' => 'Kochi Takayoshi',
I447 1
'kunihiro@ipinfusion.com' => 'Kunihiro Ishiguro',
I451 1
'latten@austin.ibm.com' => 'Joy Latten',
I466 1
'luben@splentec.com' => 'Luben Tuikov',
I475 1
'manish@zambeel.com' => 'Manish Lachwani',
I537 1
'neilt@slimy.greenend.org.uk' => 'Neil Turton',
I539 1
'nick.holloway@pyrites.org.uk' => 'Nick Holloway',
I543 1
'nlaredo@transmeta.com' => 'Nathan Laredo',
I559 1
'p.guehring@futureware.at' => 'Philipp Gühring',
I608 1
'raul@pleyades.net' => 'Raul Nunez de Arenas Coronado',
I633 1
'roland@frob.com' => 'Roland McGrath',
I677 1
'shemminger@osdl.org' => 'Stephen Hemminger',
I686 1
'sprite@sprite.fr.eu.org' => 'Jeremie Koenig',
I687 1
'sri@us.ibm.com' => 'Sridhar Samudrala',
I691 1
'stanley.wang@linux.co.intel.com' => 'Stanley Wang',
I692 1
'stekloff@w-stekloff.beaverton.ibm.com' => 'Daniel Stekloff',
I720 1
'thomas@bender.thinknerd.de' => 'Thomas Walpuski',
I724 1
'toml@us.ibm.com' => 'Tom Lendacky',
I758 1
'warlord@mit.edu' => 'Derek Atkins',
I771 1
'wriede@riede.org' => 'Willem Riede',
I775 1
'ya@slamail.org' => 'Yaacov Akiba Slama',
I779 1
'zinx@epicsol.org' => 'Zinx Verituse',
I1309 21
# Revision 0.73  2003/02/14 10:45:45  vita
# Added 5 new addresses found by Google.
#
# Revision 0.72  2003/02/06 16:10:23  vita
# Added 6 new addresses found by Google.
#
# Revision 0.71  2003/02/05 11:22:06  emma
# New addresses Vita pulled out.
#
# Revision 0.70  2003/02/03 14:58:04  emma
# Vita dug out more addresses.
#
# Revision 0.69  2003/01/28 23:30:02  emma
# Another four addresses by Vita.
#
# Revision 0.68  2003/01/20 10:22:08  emma
# Add new address for Rolf Eike Beer.
#
# Revision 0.67  2003/01/19 14:32:55  emma
# Further addresses figured out by Vita.
#

# Patch checksum=6253f9de
