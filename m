Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264545AbTKNQs0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 11:48:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264544AbTKNQs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 11:48:26 -0500
Received: from mail.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:4776 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S264545AbTKNQsR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 11:48:17 -0500
MIME-Version: 1.0
To: torvalds@osdl.org, marcelo.tosatti@cyclades.com.br
Subject: lk-changelog.pl 0.194
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Fri_Nov_14_16_48_11_UTC_2003_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20031114164812.BF252999AD@merlin.emma.line.org>
Date: Fri, 14 Nov 2003 17:48:12 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a semi-automatic announcement.

lk-changelog.pl aka. shortlog version 0.194 has been released.

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
revision 0.194
date: 2003/11/11 09:21:00;  author: vita;  state: Exp;  lines: +14 -1
10 new addresses
----------------------------
revision 0.193
date: 2003/10/27 12:04:27;  author: emma;  state: Exp;  lines: +6 -1
Merge upstream changes.
----------------------------
revision 0.192
date: 2003/10/24 08:13:10;  author: vita;  state: Exp;  lines: +9 -1
5 new addresses
----------------------------
revision 0.191
date: 2003/10/21 12:20:32;  author: vita;  state: Exp;  lines: +6 -1
2 new addresses
----------------------------
revision 0.190
date: 2003/10/16 12:33:28;  author: vita;  state: Exp;  lines: +7 -1
3 new addresses
=============================================================================
Index: lk-changelog.pl
===================================================================
RCS file: /var/CVS/lk-changelog/lk-changelog.pl,v
retrieving revision 0.190
retrieving revision 0.194
diff -u -r0.190 -r0.194
--- lk-changelog.pl	16 Oct 2003 12:33:28 -0000	0.190
+++ lk-changelog.pl	11 Nov 2003 09:21:00 -0000	0.194
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.190 2003/10/16 12:33:28 vita Exp $
+# $Id: lk-changelog.pl,v 0.194 2003/11/11 09:21:00 vita Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -163,6 +163,7 @@
 'aia21:cantab.net' => 'Anton Altaparmakov',
 'aia21:cus.cam.ac.uk' => 'Anton Altaparmakov',
 'aia21:drop.stormcorp.org' => 'Anton Altaparmakov', # guessed
+'ajm:sgi.com' => 'Alan Mayer',
 'ajoshi:kernel.crashing.org' => 'Ani Joshi',
 'ajoshi:shell.unixbox.com' => 'Ani Joshi',
 'ak:colin.muc.de' => 'Andi Kleen',
@@ -182,6 +183,7 @@
 'albertogli:telpin.com.ar' => 'Alberto Bertogli',
 'alborchers:steinerpoint.com' => 'Al Borchers',
 'alex.williamson:hp.com' => 'Alex Williamson',
+'alex:de.rmk.(none)' => 'Alexander Schulz',
 'alex:ssi.bg' => 'Alexander Atanasov',
 'alex_williamson:attbi.com' => 'Alex Williamson', # lbdb
 'alex_williamson:com.rmk.(none)' => 'Alex Williamson',
@@ -302,6 +304,7 @@
 'cagle:mindspring.com' => 'John Cagle', # Alan
 'calum.mackay:cdmnet.org' => 'Calum Mackay', # lbdb
 'cananian:lesser-magoo.lcs.mit.edu' => 'C. Scott Ananian',
+'car.busse:gmx.de' => 'Carsten Busse',	# verified by Greg KH
 'cat:zip.com.au' => 'CaT',
 'cattelan:sgi.com' => 'Russell Cattelan', # google
 'ccaputo:alt.net' => 'Chris Caputo',
@@ -378,6 +381,7 @@
 'daniel:osdl.org' => 'Daniel McNeil',
 'dank:kegel.com' => 'Dan Kegel',
 'dario:emc.com' => 'Dario Ballabio', # Alan Cox
+'dave.jiang:com.rmk.(none)' => 'Dave Jiang',
 'dave:qix.net' => 'Dave Maietta',
 'dave:thedillows.org' => 'David Dillow',
 'davej:codemonkey.or' => 'Dave Jones',
@@ -405,6 +409,7 @@
 'davidm:wailua.hpl.hp.com' => 'David Mosberger',
 'davids:youknow.youwant.to' => 'David Schwartz', # google
 'davidvh:cox.net' => 'David van Hoose',
+'davis_g:com.rmk.(none)' => 'George G. Davis',
 'dax:gurulabs.com' => 'Dax Kelson',
 'dbrownell:users.sourceforge.net' => 'David Brownell',
 'ddstreet:ieee.org' => 'Dan Streetman',
@@ -631,6 +636,7 @@
 'james:cobaltmountain.com' => 'James Mayer',
 'james:superbug.demon.co.uk' => 'James Courtier-Dutton',
 'james_mcmechan:hotmail.com' => 'James McMechan',
+'jamesclv:us.ibm.com' => 'James Cleverdon',
 'jamey.hicks:hp.com' => 'Jamey Hicks',
 'jamey:crl.dec.com' => 'Jamey Hicks',
 'jamie:shareable.org' => 'Jamie Lokier',
@@ -780,9 +786,12 @@
 'kkeil:isdn4linux.de' => 'Karsten Keil',
 'kkeil:suse.de' => 'Karsten Keil',
 'klassert:mathematik.ru-chemnitz.de' => 'Steffen Klassert',
+'kml:patheticgeek.net' => 'Kevin Lahey',
 'kmsmith:umich.edu' => 'Kendrick M. Smith',
 'knan:mo.himolde.no' => 'Erik Inge Bolsø',
+'knut_petersen:t-online.de' => 'Knut Petersen',
 'kochi:hpc.bs1.fc.nec.co.jp' => 'Kochi Takayoshi',
+'kolya:mit.edu' => 'Nickolai Zeldovich',
 'komujun:nifty.com' => 'Jun Komuro', # google
 'kpc-usbdev:gelato.uiuc.edu' => 'Kevin Cernekee',
 'kpfleming:cox.net' => 'Kevin P. Fleming',
@@ -917,6 +926,7 @@
 'mgreer:mvista.com' => 'Mark A. Greer', # lbdb
 'mhoffman:lightlink.com' => 'Mark M. Hoffman',
 'mhopf:innominate.com' => 'Mark-André Hopf',
+'michael:metaparadigm.com' => 'Michael Clark',
 'michaelw:foldr.org' => 'Michael Weber', # google
 'michal:harddata.com' => 'Michal Jaegermann',
 'michal:logix.cz' => 'Michal Ludvig',
@@ -1021,6 +1031,7 @@
 'otaylor:redhat.com' => 'Owen Taylor',
 'overby:sgi.com' => 'Glen Overby',
 'p.guehring:futureware.at' => 'Philipp Gühring',
+'p.lavarre:ieee.org' => 'Pat LaVarre',
 'p2:ace.ulyssis.sutdent.kuleuven.ac.be' => 'Peter De Shrijver',
 'p_gortmaker:yahoo.com' => 'Paul Gortmaker',
 'pablo:menichini.com.ar' => 'Pablo Menichini',
@@ -1045,10 +1056,12 @@
 'pavel:janik.cz' => 'Pavel Janík',
 'pavel:suse.cz' => 'Pavel Machek',
 'pavel:ucw.cz' => 'Pavel Machek',
+'pazke:donpac.ru' => 'Andrey Panin',
 'pazke:orbita1.ru' => 'Andrey Panin',
 'pbadari:us.ibm.com' => 'Badari Pulavarty',
 'pdelaney:lsil.com' => 'Pam Delaney',
 'pe1rxq:amsat.org' => 'Jeroen Vreeken',
+'pee:erkkila.org' => 'Paul E. Erkkila',
 'pekon:informatics.muni.cz' => 'Petr Konecny',
 'per.winkvist:telia.com' => 'Per Winkvist',
 'perex:perex.cz' => 'Jaroslav Kysela',
@@ -1074,6 +1087,7 @@
 'petri.koistinen:iki.fi' => 'Petri Koistinen',
 'petrides:redhat.com' => 'Ernie Petrides',
 'pfg:sgi.com' => 'Pat Gefre',
+'philipc:snapgear.com' => 'Philip Craig',
 'philipp:void.at' => 'Philipp Friedrich',
 'phillim2:comcast.net' => 'Mike Phillips',
 'piggin:cyberone.com.au' => 'Nick Piggin',
@@ -1218,6 +1232,7 @@
 'shaggy:shaggy.austin.ibm.com' => 'Dave Kleikamp', # lbdb
 'sheilds:msrl.com' => 'Michael Shields', # typo
 'shemminger:osdl.org' => 'Stephen Hemminger',
+'shep:alum.mit.edu' => 'Tim Shepard',
 'shields:msrl.com' => 'Michael Shields',
 'shingchuang:via.com.tw' => 'Shing Chuang',
 'shmulik.hen:intel.com' => 'Shmulik Hen',
@@ -1321,6 +1336,7 @@
 'toml:us.ibm.com' => 'Tom Lendacky',
 'tomlins:cam.org' => 'Ed Tomlinson',
 'tommy.christensen:tpack.net' => 'Tommy Christensen',
+'tommy:home.tig-grr.com' => 'Tom Marshall',
 'tony.luck:intel.com' => 'Tony Luck',
 'tony:cantech.net.au' => 'Anthony J. Breeds-Taurima',
 'tonyb:cybernetics.com' => 'Tony Battersby',
@@ -1333,6 +1349,7 @@
 'trini:org.rmk.(none)' => 'Tom Rini',
 'trivial:rustcorp.com.au' => 'Rusty Russell',
 'trond.myklebust:fys.uio.no' => 'Trond Myklebust',
+'tsk:ibakou.com' => 'Kawazoe Tomonori',
 'tv:debian.org' => 'Tommi Virtanen',
 'tvignaud:mandrakesoft.com' => 'Thierry Vignaud',
 'tvrtko:net4u.hr' => 'Tvrtko A. Ursulin',
@@ -1419,11 +1436,13 @@
 'zippel:linux-m68k.org' => 'Roman Zippel',
 'zubarev:us.ibm.com' => 'Irene Zubarev', # google
 'zw:superlucidity.net' => 'Zach Welch',
+'zwane:arm.linux.org.uk' => 'Zwane Mwaikambo',
 'zwane:commfireservices.com' => 'Zwane Mwaikambo',
 'zwane:holomorphy.com' => 'Zwane Mwaikambo',
 'zwane:linux.realnet.co.sz' => 'Zwane Mwaikambo',
 'zwane:linuxpower.ca' => 'Zwane Mwaikambo',
 'zwane:mwaikambo.name' => 'Zwane Mwaikambo',
+'zzz:anda.ru' => 'Denis Zaitsev',
 '~~~~~~thisentrylast:forconvenience~~~~~' => 'Cesar Brutus Anonymous'
 );
 
@@ -2108,6 +2127,18 @@
 __END__
 # --------------------------------------------------------------------
 # $Log: lk-changelog.pl,v $
+# Revision 0.194  2003/11/11 09:21:00  vita
+# 10 new addresses
+#
+# Revision 0.193  2003/10/27 12:04:27  emma
+# Merge upstream changes.
+#
+# Revision 0.192  2003/10/24 08:13:10  vita
+# 5 new addresses
+#
+# Revision 0.191  2003/10/21 12:20:32  vita
+# 2 new addresses
+#
 # Revision 0.190  2003/10/16 12:33:28  vita
 # 3 new addresses
 #

