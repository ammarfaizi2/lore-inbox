Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265816AbUBKOZq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 09:25:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265886AbUBKOZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 09:25:46 -0500
Received: from mail.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:12465 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S265816AbUBKOZ3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 09:25:29 -0500
MIME-Version: 1.0
To: torvalds@osdl.org, marcelo.tosatti@cyclades.com.br
Subject: lk-changelog.pl 0.232
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Wed_Feb_11_14_25_24_UTC_2004_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20040211142524.C51A0AB163@merlin.emma.line.org>
Date: Wed, 11 Feb 2004 15:25:24 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a semi-automatic announcement.

lk-changelog.pl aka. shortlog version 0.232 has been released.

This script is used by Linus and Marcelo to rearrange and reformat BK
ChangeSet logs into a more human-readable format, and the official
repository is Parent repository is http://bktools.bkbits.net/bktools

As the script has grown large, this mail only contains a diff against
the last released version.

You can always download the full script and GPG signatures from
http://home.pages.de/~mandree/linux/kernel/

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
revision 0.232
date: 2004/02/11 14:17:23;  author: vita;  state: Exp;  lines: +12 -1
merge Linus' additions; add few more addresses
----------------------------
revision 0.231
date: 2004/02/07 12:03:29;  author: vita;  state: Exp;  lines: +5 -1
4 new addresses
----------------------------
revision 0.230
date: 2004/02/05 15:06:05;  author: vita;  state: Exp;  lines: +2 -1
added Robert Love's address
----------------------------
revision 0.229
date: 2004/02/02 11:11:36;  author: vita;  state: Exp;  lines: +3 -1
2 new addresses
----------------------------
revision 0.228
date: 2004/01/31 15:33:47;  author: emma;  state: Exp;  lines: +2 -1
Add new address for Dominik Brodowski.
----------------------------
revision 0.227
date: 2004/01/30 11:36:34;  author: vita;  state: Exp;  lines: +10 -1
add 9 new addresses
----------------------------
revision 0.226
date: 2004/01/29 11:17:19;  author: vita;  state: Exp;  lines: +2 -1
add Steve Hill's address
----------------------------
revision 0.225
date: 2004/01/28 12:22:18;  author: vita;  state: Exp;  lines: +2 -1
add Yoichi Yuasa's address
----------------------------
revision 0.224
date: 2004/01/27 14:40:49;  author: emma;  state: Exp;  lines: +5 -1
New EXAMPLE added, 'What am I about to pull?'.
=============================================================================
Index: lk-changelog.pl
===================================================================
RCS file: /var/CVS/lk-changelog/lk-changelog.pl,v
retrieving revision 0.224
retrieving revision 0.232
diff -u -r0.224 -r0.232
--- lk-changelog.pl	27 Jan 2004 14:40:49 -0000	0.224
+++ lk-changelog.pl	11 Feb 2004 14:17:23 -0000	0.232
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.224 2004/01/27 14:40:49 emma Exp $
+# $Id: lk-changelog.pl,v 0.232 2004/02/11 14:17:23 vita Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -307,6 +307,7 @@
 'borisitk:fortunet.com' => 'Boris Itkis', # by Kristian Peters
 'boutcher:us.ibm.com' => 'Dave Boutcher',
 'braam:clusterfs.com' => 'Peter Braam',
+'brad:wasp.net.au' => 'Brad Campbell',
 'brett:bad-sports.com' => 'Brett Pemberton',
 'brihall:pcisys.net' => 'Brian Hall', # google
 'brm:murphy.dk' => 'Brian Murphy',
@@ -324,6 +325,7 @@
 'c-d.hailfinger.kernel.2002-07:gmx.net' => 'Carl-Daniel Hailfinger',
 'c-d.hailfinger.kernel.2002-q4:gmx.net' => 'Carl-Daniel Hailfinger', # himself
 'c-d.hailfinger.kernel.2003:gmx.net' => 'Carl-Daniel Hailfinger', # himself
+'c-d.hailfinger.kernel.2004:gmx.net' => 'Carl-Daniel Hailfinger',
 'cagle:mindspring.com' => 'John Cagle', # Alan
 'calum.mackay:cdmnet.org' => 'Calum Mackay', # lbdb
 'cananian:lesser-magoo.lcs.mit.edu' => 'C. Scott Ananian',
@@ -417,8 +419,10 @@
 'davej:redhat.com' => 'Dave Jones', # lbdb
 'davej:suse.de' => 'Dave Jones',
 'davej:tetrachloride.(none)' => 'Dave Jones',
+'davem:cheetah.(none)' => 'David S. Miller',
 'davem:hera.kernel.org' => 'David S. Miller',
 'davem:kernel.bkbits.net' => 'David S. Miller',
+'davem:nuts.davemloft.net' => 'David S. Miller',
 'davem:redhat.com' => 'David S. Miller',
 'david-b:net.rmk.(none)' => 'David Brownell',
 'david-b:pacbell.com' => 'David Brownell',
@@ -468,10 +472,12 @@
 'dledford:flossy.devel.redhat.com' => 'Doug Ledford',
 'dledford:redhat.com' => 'Doug Ledford',
 'dlstevens:us.ibm.com' => 'David Stevens',
+'dlsy:snoqualmie.dp.intel.com' => 'Dely Sy',
 'dmccr:us.ibm.com' => 'Dave McCracken',
 'dmo:osdl.org' => 'Dave Olien',
 'doj:cubic.org' => 'Dirk Jagdmann',
 'dok:directfb.org' => 'Denis Oliver Kropp',
+'domen:coderock.org' => 'Domen Puncer',
 'dougg:torque.net' => 'Douglas Gilbert',
 'drb:med.co.nz' => 'Ross Boswell',
 'drepper:redhat.com' => 'Ulrich Drepper',
@@ -481,6 +487,7 @@
 'dsaxena:com.rmk' => 'Deepak Saxena',
 'dsaxena:com.rmk.(none)' => 'Deepak Saxena',
 'dsaxena:mvista.com' => 'Deepak Saxena',
+'dsaxena:plexity.net' => 'Deepak Saxena',
 'dsteklof:us.ibm.com' => 'Daniel E. F. Stekloff',
 'dth:dth.net' => 'Danny ter Haar', # guessed
 'dtor_core:ameritech.net' => 'Dmitry Torokhov',
@@ -500,6 +507,7 @@
 'edward_peng:dlink.com.tw' => 'Edward Peng',
 'efocht:ess.nec.de' => 'Erich Focht',
 'ehabkost:conectiva.com.br' => 'Eduardo Pereira Habkost',
+'eike-hotplug:sf-tec.de' => 'Rolf Eike Beer',
 'eike-kernel:sf-tec.de' => 'Rolf Eike Beer', # sent by himself
 'eike:bilbo.math.uni-mannheim.de' => 'Rolf Eike Beer',
 'elenstev:com.rmk.(none)' => 'Steven Cole',
@@ -510,6 +518,7 @@
 'emann:mrv.com' => 'Eran Mann',
 'emcnabb:cs.byu.edu' => 'Evan N. McNabb',
 'emoore:lsil.com' => 'Eric Dean Moore',
+'ender:debian.org' => 'David Martínez Moreno',
 'engebret:au1.ibm.com' => 'David Engebretsen',
 'engebret:brule.rchland.ibm.com' => 'David Engebretsen',
 'engebret:us.ibm.com' => 'David Engebretsen',
@@ -525,6 +534,7 @@
 'erlend-a:us.his.no' => 'Erlend Aasland',
 'erlend-a:ux.his.no' => 'Erlend Aasland',
 'ernstp:mac.com' => 'Ernst Persson', # lbdb
+'eugene.teo:eugeneteo.net' => 'Eugene Teo',
 'eugeneteo:eugeneteo.net' => 'Eugene Teo',
 'eyal:eyal.emu.id.au' => 'Eyal Lebedinsky', # lbdb
 'faikuygur:ttnet.net.tr' => 'Faik Uygur',
@@ -747,6 +757,7 @@
 'jim.houston:attbi.com' => 'Jim Houston',
 'jkenisto:us.ibm.com' => 'James Keniston',
 'jkt:helius.com' => 'Jack Thomasson',
+'jlcooke:certainkey.com' => 'Jean-Luc Cooke',
 'jmcmullan:linuxcare.com' => 'Jason McMullan',
 'jmm:informatik.uni-bremen.de' => 'Moritz Mühlenhoff',
 'jmorris:intercode.com.au' => 'James Morris',
@@ -769,10 +780,13 @@
 'john:deater.net' => 'John Clemens',
 'john:grabjohn.com' => 'John Bradford',
 'john:larvalstage.com' => 'John Kim',
+'john:neggie.net' => 'John Belmonte',
 'johnf:whitsunday.net.au' => 'John W. Fort',
 'johnpol:2ka.mipt.ru' => 'Evgeniy Polyakov',
+'johnrose:austin.ibm.com' => 'John Rose',
 'johnstul:us.ibm.com' => 'John Stultz',
 'jones:ingate.com' => 'Jones Desougi',
+'jonsmirl:yahoo.com' => 'Jon Smirl',
 'joris:struyve.be' => 'Joris Struyve',
 'josh:joshisanerd.com' => 'Josh Myer',
 'jsiemes:web.de' => 'Josef Siemes',
@@ -785,6 +799,7 @@
 'jsm:udlkern.fc.hp.com' => 'John S. Marvin',
 'jsun:mvista.com' => 'Jun Sun',
 'jt:bougret.hpl.hp.com' => 'Jean Tourrilhes',
+'jt:bougret.jpl.hp.com' => 'Jean Tourrilhes',	# jpl? Whaa? hpl!
 'jt:hpl.hp.com' => 'Jean Tourrilhes',
 'jtyner:cs.ucr.edu' => 'John Tyner',
 'judd:jpilot.org' => 'Judd Montgomery',
@@ -829,6 +844,7 @@
 'khalid_aziz:hp.com' => 'Khalid Aziz',
 'khc:pc.waw.pl' => 'Krzysztof Halasa',
 'khc:pm.waw.pl' => 'Krzysztof Halasa',
+'kieran:mgpenguin.net' => 'Kieran Morrissey',
 'kiran:in.ibm.com' => 'Ravikiran G. Thirumalai',
 'kisza:sch.bme.hu' => 'Andras Kis-Szabo', # google (netfilter-ext HOWTO)
 'kkeil:isdn4linux.de' => 'Karsten Keil',
@@ -857,6 +873,7 @@
 'kyle:debian.org' => 'Kyle McMartin',
 'kyle:engsoc.carleton.ca' => 'Kyle McMartin',
 'l.s.r:web.de' => 'René Scharfe',
+'ladis:linux-mips.org' => 'Ladislav Michl',
 'ladis:psi.cz' => 'Ladislav Michl',
 'laforge:gnumonks.org' => 'Harald Welte',
 'laforge:netfilter.org' => 'Harald Welte',
@@ -886,6 +903,7 @@
 'linux-usb:gemeinhardt.info' => 'Lars Gemeinhardt',
 'linux:brodo.de' => 'Dominik Brodowski',
 'linux:de.rmk.(none)' => 'Dominik Brodowski',
+'linux:dominikbrodowski.de' => 'Dominik Brodowski',
 'linux:hazard.jcu.cz' => 'Jan Marek',
 'linux:thorsten-knabe.de' => 'Thorsten Knabe',
 'lionel.bouton:inet6.fr' => 'Lionel Bouton',
@@ -988,6 +1006,7 @@
 'mgreer:mvista.com' => 'Mark A. Greer', # lbdb
 'mhoffman:lightlink.com' => 'Mark M. Hoffman',
 'mhopf:innominate.com' => 'Mark-André Hopf',
+'michael.krauth:web.de' => 'Michael Krauth',
 'michael:metaparadigm.com' => 'Michael Clark',
 'michael_e_brown:dell.com' => 'Michael E. Brown', # lbdb
 'michaelw:foldr.org' => 'Michael Weber', # google
@@ -1084,6 +1103,7 @@
 'ntfs:flatcap.org' => 'Richard Russon', # lbdb
 'nuno:itsari.org' => 'Nuno Monteiro',
 'obelix123:toughguy.net' => 'Raj',		# Hmm..
+'ogasawara:osdl.org' => 'Leann Ogasawara',
 'okir:suse.de' => 'Olaf Kirch', # lbdb
 'okurth:gmx.net' => 'Oliver Kurth',
 'olaf.dietsche#list.linux-kernel:t-online.de' => 'Olaf Dietsche',
@@ -1134,6 +1154,7 @@
 'pazke:donpac.ru' => 'Andrey Panin',
 'pazke:orbita1.ru' => 'Andrey Panin',
 'pbadari:us.ibm.com' => 'Badari Pulavarty',
+'pcaulfie:redhat.com' => 'Patrick Caulfield',
 'pdelaney:lsil.com' => 'Pam Delaney',
 'pe1rxq:amsat.org' => 'Jeroen Vreeken',
 'pebl:math.ku.dk' => 'Peter Berg Larsen',
@@ -1237,6 +1258,7 @@
 'rmk:arm.linux.org.uk' => 'Russell King',
 'rmk:flint.arm.linux.org.uk' => 'Russell King',
 'rml:tech9.net' => 'Robert Love',
+'rml:ximian.com' => 'Robert Love',
 'rnp:paradise.net.nz' => 'Richard Procter',
 'rob:landley.net' => 'Rob Landley',
 'rob:osinvestor.com' => 'Rob Radez',
@@ -1291,9 +1313,11 @@
 'sarolaht:cs.helsinki.fi' => 'Pasi Sarolahti',
 'sawa:yamamoto.gr.jp' => 'sawa',
 'scameron:quandary.cca.cpqcorp.net' => 'Steve Cameron',
+'schierlm:gmx.de' => 'Michael Schierl',
 'schlicht:uni-mannheim.de' => 'Thomas Schlichter',
 'schlicht:uni-mannheimn.de' => 'Thomas Schlichter',	# it's typo IMHO
 'schoenfr:gaaertner.de' => 'Erik Schoenfelder',
+'scholnik:radar.nrl.navy.mil' => 'Dan Scholnik',
 'schwab:suse.de' => 'Andreas Schwab',
 'schwidefsky:de.ibm.com' => 'Martin Schwidefsky',
 'scole:zianet.com' => 'Steven Cole', # lk, Alan Cox 20030904
@@ -1316,6 +1340,7 @@
 'sfrost:snowman.net' => 'Stephen Frost',
 'shaggy:austin.ibm.com' => 'Dave Kleikamp',
 'shaggy:kleikamp.austin.ibm.com' => 'Dave Kleikamp',
+'shaggy:kleikamp.dyn.webahead.ibm.com' => 'Dave Kleikamp',
 'shaggy:shaggy.austin.ibm.com' => 'Dave Kleikamp', # lbdb
 'sheilds:msrl.com' => 'Michael Shields', # typo
 'shemminger:osdl.org' => 'Stephen Hemminger',
@@ -1366,6 +1391,7 @@
 'steve:chygwyn.com' => 'Steven Whitehouse',
 'steve:gw.chygwyn.com' => 'Steven Whitehouse',
 'steve:kbuxd.necst.nec.co.jp' => 'Steve Baur',
+'steve:navaho.co.uk' => 'Steve Hill',
 'steved:redhat.com' => 'Steve Dickson',
 'stevef:linux.local' => 'Steve French', # guessed
 'stevef:smfhome1.austin.rr.com' => 'Steve French',
@@ -1413,6 +1439,7 @@
 'thomas:stewarts.org.uk' => 'Thomas Stewart',
 'thomas:winischhofer.net' => 'Thomas Winischhofer', # whois
 'thomr9am:ss1000.ms.mff.cuni.cz' => 'Rudo Thomas',
+'thornber:redhat.com' => 'Joe Thornber',
 'thornber:sistina.com' => 'Joe Thornber',
 'thunder:ngforever.de' => 'Thunder From The Hill',
 'tigran:aivazian.name' => 'Tigran Aivazian',
@@ -1430,6 +1457,7 @@
 'tommy.christensen:tpack.net' => 'Tommy Christensen',
 'tommy:home.tig-grr.com' => 'Tom Marshall',
 'tony.luck:intel.com' => 'Tony Luck',
+'tony:atomide.com' => 'Tony Lindgren',
 'tony:cantech.net.au' => 'Anthony J. Breeds-Taurima',
 'tony:com.rmk.(none)' => 'Tony Lindgren',
 'tonyb:cybernetics.com' => 'Tony Battersby',
@@ -1441,6 +1469,7 @@
 'trini:mvista.com' => 'Tom Rini',
 'trini:opus.bloom.county' => 'Tom Rini',
 'trini:org.rmk.(none)' => 'Tom Rini',
+'tritol:trilogic.cz' => 'Lubomír Bláha',
 'trivial:rustcorp.com.au' => 'Rusty Russell',
 'trond.myklebust:fys.uio.no' => 'Trond Myklebust',
 'tsk:ibakou.com' => 'Kawazoe Tomonori',
@@ -1528,6 +1557,7 @@
 'yoshfuji:linux-ipv6.org' => 'Hideaki Yoshifuji', # lbdb
 'yoshfuji:nuts.ninka.net' => 'Hideaki Yoshifuji',
 'ysato:users.sourceforge.jp' => 'Yoshinori Sato', # lbdb
+'yuasa:hh.iij4u.or.jp' => 'Yoichi Yuasa',
 'yuri:acronis.com' => 'Yuri Per', # lbdb
 'zaitcev:redhat.com' => 'Pete Zaitcev',
 'zecke:flint.arm.linux.org.uk' => 'Holger Freyther',

