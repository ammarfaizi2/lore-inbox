Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262093AbTGKMhu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 08:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269932AbTGKMht
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 08:37:49 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:32531 "EHLO
	krusty.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262093AbTGKMhj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 08:37:39 -0400
MIME-Version: 1.0
To: torvalds@transmeta.com, marcelo@conectiva.com.br
Subject: lk-changelog.pl 0.145
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Fri_Jul_11_12_52_18_UTC_2003_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20030711125218.2FF178AEC9@merlin.emma.line.org>
Date: Fri, 11 Jul 2003 14:52:18 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a semi-automatic announcement.

lk-changelog.pl aka. shortlog version 0.145 has been released.

This script is used by Linus and Marcelo to rearrange and reformat BK
ChangeSet logs into a more human-readable format, and the official
repository is bk://kernel.bkbits.net/torvalds/tools/

As the script has grown large, this mail only contains a diff against
the last released version.

You can always download the full script and GPG signatures from
http://mandree.home.pages.de/linux/kernel/

My thanks go to Vitezslav Samel who has spent a lot of time on digging
out the real names for addresses sending in BK ChangeSets.

Note that your mailer must be MIME-capable to save this mail properly,
because it is in the "quoted-printable" encoding.

= <- if you see just an equality sign, but no "3D", your mailer is fine.
= <- if you see 3D on this line, then upgrade your mailer or pipe this mail
= <- into metamail.

-- 
A sh script on behalf of Matthias Andree
-------------------------------------------------------------------------
Changes since last release:

----------------------------
revision 0.145
date: 2003/07/11 08:37:05;  author: vita;  state: Exp;  lines: +9 -2
add 4 names for new addresses; resort address->name hash
----------------------------
revision 0.144
date: 2003/07/10 12:27:51;  author: vita;  state: Exp;  lines: +6 -1
2 new addresses
----------------------------
revision 0.143
date: 2003/07/08 10:05:55;  author: vita;  state: Exp;  lines: +6 -1
2 new addresses
----------------------------
revision 0.142
date: 2003/07/03 12:29:27;  author: vita;  state: Exp;  lines: +7 -1
3 new addresses
----------------------------
revision 0.141
date: 2003/07/01 09:11:52;  author: vita;  state: Exp;  lines: +6 -1
2 new addresses
----------------------------
revision 0.140
date: 2003/06/30 08:22:08;  author: vita;  state: Exp;  lines: +7 -1
3 new addresses
----------------------------
revision 0.139
date: 2003/06/27 08:22:15;  author: vita;  state: Exp;  lines: +14 -1
10 new addresses
----------------------------
revision 0.138
date: 2003/06/25 08:55:55;  author: vita;  state: Exp;  lines: +6 -1
2 new addresses
----------------------------
revision 0.137
date: 2003/06/24 08:59:08;  author: vita;  state: Exp;  lines: +7 -1
3 new addresses
----------------------------
revision 0.136
date: 2003/06/23 09:13:06;  author: vita;  state: Exp;  lines: +7 -1
merge Linus' additions
----------------------------
revision 0.135
date: 2003/06/21 00:56:01;  author: emma;  state: Exp;  lines: +8 -2
3 new addresses.
----------------------------
revision 0.134
date: 2003/06/20 09:15:01;  author: vita;  state: Exp;  lines: +9 -1
add 5 names for new addresses
=============================================================================
Index: lk-changelog.pl
===================================================================
RCS file: /var/CVS/lk-changelog/lk-changelog.pl,v
retrieving revision 0.134
retrieving revision 0.145
diff -u -r0.134 -r0.145
--- lk-changelog.pl	20 Jun 2003 09:15:01 -0000	0.134
+++ lk-changelog.pl	11 Jul 2003 08:37:05 -0000	0.145
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.134 2003/06/20 09:15:01 vita Exp $
+# $Id: lk-changelog.pl,v 0.145 2003/07/11 08:37:05 vita Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -70,6 +70,7 @@
 [ 'alan@[^.]+\.swansea\.linux\.org\.uk' => 'Alan Cox', ],
 [ 'kuznet@[^.]+\.inr.ac.ru' => 'Alexey Kuznetsov', ],
 [ 'torvalds@([^.]+\.)?transmeta\.com' => 'Linus Torvalds', ],
+[ 'torvalds@([^.]+\.)?osdl\.org' => 'Linus Torvalds', ],
 [ '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~' => '~~~~~~~~' ]);
 
 sub obfuscate(@) {
@@ -112,6 +113,7 @@
 
 my %addresses = (
 'aaron.baranoff:tsc.tdk.com' => 'Aaron Baranoff',
+'abbotti:mev.co.uk' => 'Ian Abbott',
 'abraham:2d3d.co.za' => 'Abraham van der Merwe',
 'abslucio:terra.com.br' => 'Lucio Maciel',
 'ac9410:attbi.com' => 'Albert Cranford',
@@ -148,6 +150,7 @@
 'ak:muc.de' => 'Andi Kleen',
 'ak:suse.de' => 'Andi Kleen',
 'akpm:digeo.com' => 'Andrew Morton',
+'akpm:osdl.org' => 'Andrew Morton', # guessed
 'akpm:reardensteel.com' => 'Andrew Morton',
 'akpm:zip.com.au' => 'Andrew Morton',
 'akropel1:rochester.rr.com' => 'Adam Kropelin', # lbdb
@@ -222,6 +225,7 @@
 'bergner:cannon.rchland.ibm.com' => 'Peter Bergner',
 'bergner:vnet.ibm.com' => 'Peter Bergner',
 'bernhard.kaindl:gmx.de' => 'Bernhard Kaindl',
+'bernie:develer.com' => 'Bernardo Innocenti',
 'berny.f:aon.at' => 'Bernhard Fischer',
 'bero:arklinux.org' => 'Bernhard Rosenkraenzer',
 'bfennema:falcon.csc.calpoly.edu' => 'Ben Fennema',
@@ -265,6 +269,8 @@
 'ch:com.rmk.(none)' => 'Christopher Hoover',
 'ch:hpl.hp.com' => 'Christopher Hoover', # by Kristian Peters
 'ch:murgatroid.com' => 'Christopher Hoover',
+'chad_smith:hp.com' => 'Chad Smith',
+'chadt:sgi.com' => 'Chad Talbott',
 'chan:aleph1.co.uk' => 'Tak-Shing Chan',
 'charles.white:hp.com' => 'Charles White',
 'chas:cmd.nrl.navy.mil' => 'Chas Williams',
@@ -299,6 +305,7 @@
 'ctindel:cup.hp.com' => 'Chad N. Tindel',
 'cubic:miee.ru' => 'Ruslan U. Zakirov',
 'cw:f00f.org' => 'Chris Wedgwood',
+'cweidema:indiana.edu' => 'Christoph Weidemann',
 'cwf:sgi.com' => 'Charles Fumuso',
 'cyeoh:samba.org' => 'Christopher Yeoh',
 'd.mueller:elsoft.ch' => 'David Müller',
@@ -334,6 +341,7 @@
 'david-b:pacbell.net' => 'David Brownell',
 'david-b:packbell.net' => 'David Brownell',
 'david.nelson:pobox.com' => 'David Nelson',
+'david:csse.uwa.edu.au' => 'David Glance',
 'david:gibson.dropbear.id.au' => 'David Gibson',
 'david_jeffery:adaptec.com' => 'David Jeffery',
 'davidel:xmailserver.org' => 'Davide Libenzi',
@@ -352,6 +360,7 @@
 'dent:cosy.sbg.ac.at' => "Thomas 'Dent' Mirlacher",
 'derek:ihtfp.com' => 'Derek Atkins',
 'devel:brodo.de' => 'Dominik Brodowski',
+'devenyga:mcmaster.ca' => 'Gabriel Devenyi',
 'devik:cdi.cz' => 'Martin Devera',
 'dgibson:samba.org' => 'David Gibson',
 'dhinds:sonic.net' => 'David Hinds', # google
@@ -380,6 +389,8 @@
 'dsaxena:com.rmk.(none)' => 'Deepak Saxena',
 'dsaxena:mvista.com' => 'Deepak Saxena',
 'dsteklof:us.ibm.com' => 'Daniel E. F. Stekloff',
+'dtor_core:ameritech.net' => 'Dmitry Torokhov',
+'ducrot:poupinou.org' => 'Bruno Ducrot',
 'duncan.sands:math.u-psud.fr' => 'Duncan Sands',
 'dwmw2:dwmw2.baythorne.internal' => 'David Woodhouse',
 'dwmw2:infradead.org' => 'David Woodhouse',
@@ -400,7 +411,8 @@
 'elenstev:mesatop.com' => 'Steven Cole',
 'eli.carter:com.rmk.(none)' => 'Eli Carter',
 'eli.kupermann:intel.com' => 'Eli Kupermann',
-'engebret:us.ibm.com' => 'Dave Engebretsen',
+'engebret:brule.rchland.ibm.com' => 'David Engebretsen',
+'engebret:us.ibm.com' => 'David Engebretsen',
 'eranian:frankl.hpl.hp.com' => 'Stéphane Eranian',
 'eranian:hpl.hp.com' => 'Stéphane Eranian',
 'eric.piel:bull.net' => 'Eric Piel',
@@ -466,6 +478,7 @@
 'greg:kroah.com' => 'Greg Kroah-Hartman',
 'greg:soap.kroah.net' => 'Greg Kroah-Hartman',
 'gregkh:kernel.bkbits.net' => 'Greg Kroah-Hartman',
+'grigouze:noos.fr' => 'Mickaël Grigouze',
 'gronkin:nerdvana.com' => 'George Ronkin',
 'grundler:cup.hp.com' => 'Grant Grundler',
 'grundym:us.ibm.com' => 'Michael Grundy',
@@ -473,6 +486,8 @@
 'gtoumi:laposte.net' => 'Ghozlane Toumi',
 'gwehrman:sgi.com' => 'Geoffrey Wehrman',
 'hadi:cyberus.ca' => 'Jamal Hadi Salim',
+'hadi:shell.cyberus.ca' => 'Jamal Hadi Salim',
+'hall:vdata.com' => 'Jeff Hall',
 'hannal:us.ibm.com' => 'Hanna V. Linder',
 'hanno:gmx.de' => 'Hanno Böck',
 'harald:gnumonks.org' => 'Harald Welte',
@@ -491,6 +506,7 @@
 'hch:sgi.com' => 'Christoph Hellwig',
 'heiko.carstens:de.ibm.com' => 'Heiko Carstens',
 'helgaas:fc.hp.com' => 'Bjorn Helgaas', # doesn't want ø/å
+'henk:god.dyndns.org' => 'Henk Vergonet',
 'henning:meier-geinitz.de' => 'Henning Meier-Geinitz',
 'henrique2.gobbi:cyclades.com' => 'Henrique Gobbi',
 'henrique:cyclades.com' => 'Henrique Gobbi',
@@ -505,6 +521,7 @@
 'hunold:convergence.de' => 'Michael Hunold',
 'hwahl:hwahl.de' => 'Hartmut Wahl',
 'ica2_ts:csv.ica.uni-stuttgart.de' => 'Thiemo Seufer', # google
+'ilmari:ilmari.org' => 'Dagfinn Ilmari Mannsåker',
 'info:usblcd.de' => 'Adams IT Services',
 'ink:jurassic.park.msu.ru' => 'Ivan Kokshaysky',
 'ink:ru.rmk.(none)' => 'Ivan Kokshaysky',
@@ -548,10 +565,12 @@
 'jdike:uml.karaya.com' => 'Jeff Dike',
 'jdr:farfalle.com' => 'David Ruggiero',
 'jdthood:yahoo.co.uk' => 'Thomas Hood',
+'jean-luc.richier:imag.fr' => 'Jean-Luc Richier',
 'jeb.j.cramer:intel.com' => 'Jeb J. Cramer',
 'jef:linuxbe.org' => 'Jean-Francois Dive',
 'jeff.wiedemeier:hp.com' => 'Jeff Wiedemeier',
 'jeffs:accelent.com' => 'Jeff Sutherland', # lbdb
+'jejb:jet.(none)' => 'James Bottomley', # wild guess
 'jejb:malley.(none)' => 'James Bottomley',
 'jejb:mulgrave.(none)' => 'James Bottomley', # from shortlog
 'jejb:raven.il.steeleye.com' => 'James Bottomley',
@@ -613,6 +632,7 @@
 'jt:bougret.hpl.hp.com' => 'Jean Tourrilhes',
 'jt:hpl.hp.com' => 'Jean Tourrilhes',
 'jtyner:cs.ucr.edu' => 'John Tyner',
+'judd:jpilot.org' => 'Judd Montgomery',
 'jun.nakajima:intel.com' => 'Jun Nakajima',
 'jung-ik.lee:intel.com' => 'Jung-Ik Lee',
 'jwoithe:physics.adelaide.edu.au' => 'Jonathan Woithe',
@@ -654,6 +674,7 @@
 'knan:mo.himolde.no' => 'Erik Inge Bolsø',
 'kochi:hpc.bs1.fc.nec.co.jp' => 'Kochi Takayoshi',
 'komujun:nifty.com' => 'Jun Komuro', # google
+'kpc-usbdev:gelato.uiuc.edu' => 'Kevin Cernekee',
 'kraxel:bytesex.org' => 'Gerd Knorr',
 'kraxel:suse.de' => 'Gerd Knorr',
 'krkumar:us.ibm.com' => 'Krishna Kumar',
@@ -671,6 +692,7 @@
 'laurent:latil.nom.fr' => 'Laurent Latil',
 'lawrence:the-penguin.otak.com' => 'Lawrence Walton',
 'ldb:ldb.ods.org' => 'Luca Barbieri',
+'ldl:aros.net' => 'Lou Langholtz',
 'ldm:flatcap.org' => 'Richard Russon',
 'lee:compucrew.com' => 'Lee Nash', # lbdb
 'legoll:free.fr' => 'Vincent Legoll', # correction sent by himself
@@ -690,7 +712,9 @@
 'lkml:shemesh.biz' => 'Shachar Shemesh',
 'lm:bitmover.com' => 'Larry McVoy',
 'lm:work.bitmover.com' => 'Larry McVoy',
+'lode_leroy:hotmail.com' => 'Lode Leroy',
 'lopezp:grupocp.es' => 'Jose A. Lopez',
+'lord:jen.americas.sgi.com' => 'Stephen Lord',
 'lord:sgi.com' => 'Stephen Lord',
 'louis.zhuang:linux.co.intel.com' => 'Louis Zhuang',
 'louisk:cse.unsw.edu.au' => 'Louis Yu-Kiu Kwan',
@@ -746,6 +770,7 @@
 'mdiehl:mdiehl.de' => 'Martin Diehl',
 'mec:shout.net' => 'Michael Elizabeth Chastain',
 'meissner:suse.de' => 'Marcus Meissner',
+'mgreer:mivsta.com' => 'Mark A. Greer', # typo
 'mgreer:mvista.com' => 'Mark A. Greer', # lbdb
 'mhoffman:lightlink.com' => 'Mark M. Hoffman',
 'mhopf:innominate.com' => 'Mark-André Hopf',
@@ -781,6 +806,7 @@
 'mochel:osdl.org' => 'Patrick Mochel',
 'mochel:segfault.osdl.org' => 'Patrick Mochel',
 'mochel:segfault.osdlab.org' => 'Patrick Mochel',
+'mort:green.i.bork.org' => 'Martin Hicks',
 'mort:wildopensource.com' => 'Martin Hicks',
 'mostrows:speakeasy.net' => 'Michal Ostrowski',
 'mostrows:watson.ibm.com' => 'Michal Ostrowski',
@@ -877,6 +903,7 @@
 'petkan:rakia.hell.org' => 'Petko Manolov',
 'petkan:tequila.dce.bg' => 'Petko Manolov',
 'petkan:users.sourceforge.net' => 'Petko Manolov',
+'petr:scssoft.com' => 'Petr Sebor',
 'petr:vandrovec.name' => 'Petr Vandrovec',
 'petri.koistinen:iki.fi' => 'Petri Koistinen',
 'petrides:redhat.com' => 'Ernie Petrides',
@@ -895,6 +922,7 @@
 'proski:gnu.org' => 'Pavel Roskin',
 'proski:org.rmk.(none)' => 'Pavel Roskin',
 'pwaechtler:mac.com' => 'Peter Wächtler',
+'qboosh:pld.org.pl' => 'Jakub Bogusz',
 'quinlan:transmeta.com' => 'Daniel Quinlan',
 'quintela:mandrakesoft.com' => 'Juan Quintela',
 'r.a.mercer:blueyonder.co.uk' => 'Adam Mercer',
@@ -923,6 +951,7 @@
 'rhirst:linuxcare.com' => 'Richard Hirst',
 'rhw:infradead.org' => 'Riley Williams',
 'richard.brunner:amd.com' => 'Richard Brunner',
+'richard.curnow:superh.com' => 'Richard Curnow',
 'riel:conectiva.com.br' => 'Rik van Riel',
 'riel:imladris.surriel.com' => 'Rik van Riel',
 'riel:redhat.com' => 'Rik van Riel',
@@ -990,6 +1019,7 @@
 'sebastian.droege:gmx.de' => 'Sebastian Dröge',
 'sfbest:us.ibm.com' => 'Steve Best',
 'sfr:canb.auug.org.au' => 'Stephen Rothwell',
+'sfrost:snowman.net' => 'Stephen Frost',
 'shaggy:austin.ibm.com' => 'Dave Kleikamp',
 'shaggy:kleikamp.austin.ibm.com' => 'Dave Kleikamp',
 'shaggy:shaggy.austin.ibm.com' => 'Dave Kleikamp', # lbdb
@@ -1006,6 +1036,7 @@
 'smurf:osdl.org' => 'Nathan Dabney',
 'snailtalk:linux-mandrake.com' => 'Geoffrey Lee', # by himself
 'solar:openwall.com' => 'Solar Designer',
+'solt:dns.toxicfilms.tv' => 'Maciej Soltysiak',
 'soruk:eridani.co.uk' => 'Michael McConnell',
 'sparker:sun.com' => 'Steven Parker', # by Duncan Laurie
 'sprite:sprite.fr.eu.org' => 'Jeremie Koenig',
@@ -1032,7 +1063,9 @@
 'steve:chygwyn.com' => 'Steven Whitehouse',
 'steve:gw.chygwyn.com' => 'Steven Whitehouse',
 'steve:kbuxd.necst.nec.co.jp' => 'Steve Baur',
+'stevef:linux.local' => 'Steve French', # guessed
 'stevef:smfhome1.austin.rr.com' => 'Steve French',
+'stevef:stevef95.austin.ibm.com' => 'Steve French',
 'stevef:steveft21.austin.ibm.com' => 'Steve French',
 'stevef:steveft21.ltcsamba' => 'Steve French',
 'stewart:inverse.wetlogic.net' => 'Paul Stewart',
@@ -1055,6 +1088,7 @@
 'tausq:debian.org' => 'Randolph Chung',
 'tcallawa:redhat.com' => "Tom 'spot' Callaway",
 'tetapi:utu.fi' => 'Tero Pirkkanen', # by Kristian Peters
+'tgraf:suug.ch' => 'Thomas Graf',
 'th122948:scl1.sfbay.sun.com' => 'Tim Hockin', # by Duncan Laurie
 'th122948:scl3.sfbay.sun.com' => 'Tim Hockin', # by Duncan Laurie
 'thiel:ksan.de' => 'Florian Thiel', # lbdb
@@ -1076,6 +1110,7 @@
 'tomlins:cam.org' => 'Ed Tomlinson',
 'tony.luck:intel.com' => 'Tony Luck',
 'tony:cantech.net.au' => 'Anthony J. Breeds-Taurima',
+'tonyb:cybernetics.com' => 'Tony Battersby',
 'torben.mathiasen:hp.com' => 'Torben Mathiasen',
 'torvalds:linux.local' => 'Linus Torvalds',
 'trevor.pering:intel.com' => 'Trevor Pering',
@@ -1104,6 +1139,7 @@
 'viro:www.linux.org.uk' => 'Alexander Viro',
 'vnuorval:tcs.hut.fi' => 'Ville Nuorvala',
 'vojta:math.berkeley.edu' => 'Paul Vojta',
+'vojtech:kernel.bkbits.net' => 'Vojtech Pavlik',
 'vojtech:suse.cz' => 'Vojtech Pavlik',
 'vojtech:twilight.ucw.cz' => 'Vojtech Pavlik',
 'vojtech:ucw.cz' => 'Vojtech Pavlik', # added by himself
@@ -1126,6 +1162,7 @@
 'willschm:us.ibm.com' => 'Will Schmidt',
 'willy:debian.org' => 'Matthew Wilcox',
 'willy:fc.hp.com' => 'Matthew Wilcox',
+'willy:org.rmk.(none)' => 'Matthew Wilcox',
 'willy:w.ods.org' => 'Willy Tarreau',
 'wilsonc:abocom.com.tw' => 'Wilson Chen', # google
 'wim:iguana.be' => 'Wim Van Sebroeck',
@@ -1740,6 +1777,39 @@
 __END__
 # --------------------------------------------------------------------
 # $Log: lk-changelog.pl,v $
+# Revision 0.145  2003/07/11 08:37:05  vita
+# add 4 names for new addresses; resort address->name hash
+#
+# Revision 0.144  2003/07/10 12:27:51  vita
+# 2 new addresses
+#
+# Revision 0.143  2003/07/08 10:05:55  vita
+# 2 new addresses
+#
+# Revision 0.142  2003/07/03 12:29:27  vita
+# 3 new addresses
+#
+# Revision 0.141  2003/07/01 09:11:52  vita
+# 2 new addresses
+#
+# Revision 0.140  2003/06/30 08:22:08  vita
+# 3 new addresses
+#
+# Revision 0.139  2003/06/27 08:22:15  vita
+# 10 new addresses
+#
+# Revision 0.138  2003/06/25 08:55:55  vita
+# 2 new addresses
+#
+# Revision 0.137  2003/06/24 08:59:08  vita
+# 3 new addresses
+#
+# Revision 0.136  2003/06/23 09:13:06  vita
+# merge Linus' additions
+#
+# Revision 0.135  2003/06/21 00:56:01  emma
+# 3 new addresses.
+#
 # Revision 0.134  2003/06/20 09:15:01  vita
 # add 5 names for new addresses
 #

