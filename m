Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267333AbTBNTj7>; Fri, 14 Feb 2003 14:39:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267300AbTBNTid>; Fri, 14 Feb 2003 14:38:33 -0500
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:55556 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S267278AbTBNThu>; Fri, 14 Feb 2003 14:37:50 -0500
Date: Fri, 14 Feb 2003 20:47:41 +0100
From: Matthias Andree <ma@dt.e-technik.uni-dortmund.de>
To: Linus Torvalds <torvalds@transmeta.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/4] Update BK-kernel-tools/shortlog
Message-ID: <20030214194741.GA31097@merlin.emma.line.org>
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

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.34, 2003-02-14 20:40:42+01:00, matthias.andree@gmx.de
  Vitezslav Samel has figured out another 31 address-to-name mappings.


 shortlog |   54 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 53 insertions(+), 1 deletion(-)


diff -Nru a/shortlog b/shortlog
--- a/shortlog	Fri Feb 14 20:44:06 2003
+++ b/shortlog	Fri Feb 14 20:44:06 2003
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
## Wrapped with gzip_uu ##


begin 600 bkpatch29772
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
$A@T`````
`
end
