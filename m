Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261704AbUCFUnx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Mar 2004 15:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261711AbUCFUnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Mar 2004 15:43:52 -0500
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:15541 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261704AbUCFUnq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Mar 2004 15:43:46 -0500
MIME-Version: 1.0
To: torvalds@osdl.org, marcelo.tosatti@cyclades.com.br
Subject: lk-changelog.pl 0.241
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Sat_Mar__6_20_43_42_UTC_2004_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20040306204343.164D21009@merlin.emma.line.org>
Date: Sat,  6 Mar 2004 21:43:43 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a semi-automatic announcement.

lk-changelog.pl aka. shortlog version 0.241 has been released.

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
revision 0.241
date: 2004/03/06 20:43:17;  author: emma;  state: Exp;  lines: +2 -1
Add one address mapping for Igmar Palsenberg.
----------------------------
revision 0.240
date: 2004/03/06 20:41:42;  author: emma;  state: Exp;  lines: +2 -1
Add broken address for Harald Welte.
----------------------------
revision 0.239
date: 2004/03/05 13:28:47;  author: vita;  state: Exp;  lines: +3 -1
2 new addresses
----------------------------
revision 0.238
date: 2004/03/04 16:53:25;  author: vita;  state: Exp;  lines: +4 -1
3 new addresses
----------------------------
revision 0.237
date: 2004/03/01 11:24:21;  author: vita;  state: Exp;  lines: +7 -3
4 new addresses and 2 corrections
----------------------------
revision 0.236
date: 2004/02/29 21:49:46;  author: emma;  state: Exp;  lines: +2 -2
Revert spelling change.
----------------------------
revision 0.235
date: 2004/02/29 21:42:46;  author: emma;  state: Exp;  lines: +15 -2
Merge BK <-> CVS changes.
=============================================================================
Index: lk-changelog.pl
===================================================================
RCS file: /var/CVS/lk-changelog/lk-changelog.pl,v
retrieving revision 0.235
retrieving revision 0.241
diff -u -r0.235 -r0.241
--- lk-changelog.pl	29 Feb 2004 21:42:46 -0000	0.235
+++ lk-changelog.pl	6 Mar 2004 20:43:17 -0000	0.241
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.235 2004/02/29 21:42:46 emma Exp $
+# $Id: lk-changelog.pl,v 0.241 2004/03/06 20:43:17 emma Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -236,7 +236,7 @@
 'aris:cathedrallabs.org' => 'Aristeu Sergio Rozanski Filho',
 'arjan:redhat.com' => 'Arjan van de Ven',
 'arjanv:redhat.com' => 'Arjan van de Ven',
-'armcc2000:com.rmk.(none)' => 'Andre',
+'armcc2000:com.rmk.(none)' => 'Andre McCurdy',
 'armin:melware.de' => 'Armin Schindler',
 'arnaud.quette:mgeups.com' => 'Arnaud Quette',
 'arnd:arndb.de' => 'Arnd Bergmann',
@@ -280,6 +280,7 @@
 'bdschuym:pandora.be' => 'Bart De Schuymer',
 'beattie:beattie-home.net' => 'Brian Beattie', # from david.nelson
 'bellucda:tiscali.it' => 'Daniele Bellucci',
+'bengen:hilluzination.de' => 'Hilko Bengen',
 'benh:kernel.crashing.org' => 'Benjamin Herrenschmidt',
 'benh:zion.wanadoo.fr' => 'Benjamin Herrenschmidt',
 'berentsen:sent5.uni-duisburg.de' => 'Martin Berentsen',
@@ -671,6 +672,7 @@
 'ian.abbott:mev.co.uk' => 'Ian Abbott',
 'ianw:gelato.unsw.edu.au' => 'Ian Wienand', # lbdb
 'ica2_ts:csv.ica.uni-stuttgart.de' => 'Thiemo Seufer', # google
+'icampbell:com.rmk.(none)' => 'Ian Campbell',
 'ilmari:ilmari.org' => 'Dagfinn Ilmari Mannsåker',
 'inaky.perez-gonzalez:intel.com' => 'Iñaky Pérez-González', # LK 20030829
 'info:usblcd.de' => 'Adams IT Services',
@@ -681,6 +683,7 @@
 'ionut:badula.org' => 'Ion Badulescu',
 'ionut:cs.columbia.edu' => 'Ion Badulescu',
 'ioshadij:hotmail.com' => 'Ishan O. Jayawardena',
+'i.palsenberg:jdirmedia.nl' => 'Igmar Palsenberg', # lbdb
 'irohlfs:irohlfs.de' => 'Ingo Rohlfs',
 'ishikawa:linux.or.jp' => 'Mutsumi Ishikawa',
 'ivangurdiev:linuxfreemail.com' => 'Ivan Gyurdiev',
@@ -797,6 +800,7 @@
 'johnpol:2ka.mipt.ru' => 'Evgeniy Polyakov',
 'johnrose:austin.ibm.com' => 'John Rose',
 'johnstul:us.ibm.com' => 'John Stultz',
+'jon:focalhost.com' => 'Jon Oberheide',
 'jones:ingate.com' => 'Jones Desougi',
 'jonsmirl:yahoo.com' => 'Jon Smirl',
 'joris:struyve.be' => 'Joris Struyve',
@@ -892,6 +896,7 @@
 'ladis:psi.cz' => 'Ladislav Michl',
 'laforge:gnumonks.org' => 'Harald Welte',
 'laforge:netfilter.org' => 'Harald Welte',
+'laforge:org.rmk.(none)' => 'Harald Welte', # guessed
 'latten:austin.ibm.com' => 'Joy Latten',
 'laurent:latil.nom.fr' => 'Laurent Latil',
 'lavarre:iomega.com' => 'Pat LaVarre',
@@ -950,6 +955,7 @@
 'lucasvr:terra.com.br' => 'Lucas Correia Villa Real', # google
 'lunz:falooley.org' => 'Jason Lunz',
 'lxiep:linux.ibm.com' => 'Linda Xie',
+'lxiep:ltcfwd.linux.ibm.com' => 'Linda Xie',
 'lxiep:us.ibm.com' => 'Linda Xie',
 'm.c.p:wolk-project.de' => 'Marc-Christian Petersen',
 'm:mbsks.franken.de' => 'Matthias Bruestle',
@@ -957,7 +963,7 @@
 'mac:melware.de' => 'Armin Schindler',
 'macro:ds2.pg.dga.pl' => 'Maciej W. Rozycki',
 'macro:ds2.pg.gda.pl' => 'Maciej W. Rozycki',
-'maeda.naoaki:jp.fujitsu.com' => 'MAEDA Naoaki',
+'maeda.naoaki:jp.fujitsu.com' => 'Maeda Naoaki',
 'mail:de.rmk.(none)' => 'Peter Teichmann',
 'makisara:abies.metla.fi' => 'Kai Mäkisara',
 'maloi:phota.to' => 'Andy Molloy',
@@ -999,6 +1005,7 @@
 'martin:meltin.net' => 'Martin Schwenke',
 'martine.silbermann:hp.com' => 'Martine Silbermann',
 'masanari.iida:hp.com' => 'Masanari Iida', # lbdb
+'masbock:us.ibm.com' => 'Max Asbock',
 'mashirle:us.ibm.com' => 'Shirley Ma',
 'mason:suse.com' => 'Chris Mason',
 'mathieu:newview.com' => 'Mathieu Chouquet-Stringer',
@@ -1283,6 +1290,7 @@
 'rl:hellgate.ch' => 'Roger Luethi',
 'rlievin:free.fr' => 'Romain Lievin',
 'rmk+lkml:arm.linux.org.uk' => 'Russell King',
+'rmk-pci:arm.linux.org.uk' => 'Russell King',
 'rmk:arm.linux.org.uk' => 'Russell King',
 'rmk:flint.arm.linux.org.uk' => 'Russell King',
 'rml:tech9.net' => 'Robert Love',
@@ -1343,6 +1351,7 @@
 'sarolaht:cs.helsinki.fi' => 'Pasi Sarolahti',
 'sawa:yamamoto.gr.jp' => 'sawa',
 'scameron:quandary.cca.cpqcorp.net' => 'Steve Cameron',
+'scd:broked.org' => 'Steven Dake',
 'schierlm:gmx.de' => 'Michael Schierl',
 'schlicht:uni-mannheim.de' => 'Thomas Schlichter',
 'schlicht:uni-mannheimn.de' => 'Thomas Schlichter',	# it's typo IMHO
@@ -1479,7 +1488,7 @@
 'timw:splhi.com' => 'Tim Wright',
 'tinglett:vnet.ibm.com' => 'Todd Inglett',
 'tiwai:suse.de' => 'Takashi Iwai',
-'tlnguyen:snoqualmie.dp.intel.com' => 'long (tlnguyen)',
+'tlnguyen:snoqualmie.dp.intel.com' => 'Tom L. Nguyen',
 'tmcreynolds:nvidia.com' => 'Tom McReynolds',
 'tmolina:cablespeed.com' => 'Thomas Molina',
 'tmolina:cox.net' => 'Thomas Molina',
@@ -1554,6 +1563,7 @@
 'webvenza:libero.it' => 'Daniele Venzano',
 'wei_ni:ali.com.tw' => 'Wei Ni',			# Guessed
 'weigand:immd1.informatik.uni-erlangen.de' => 'Ulrich Weigand',
+'weihs:linux1394.org' => 'Manfred Weihs',
 'wensong:linux-vs.org' => 'Wensong Zhang',
 'wes:infosink.com' => 'Wes Schreiner',
 'wesolows:foobazco.org' => 'Keith M. Wesolowski',
@@ -1592,6 +1602,7 @@
 'yoshfuji:linux-ipv6.org' => 'Hideaki Yoshifuji', # lbdb
 'yoshfuji:nuts.ninka.net' => 'Hideaki Yoshifuji',
 'ysato:users.sourceforge.jp' => 'Yoshinori Sato', # lbdb
+'ysauyuki.kozakai:toshiba.co.jp' => 'Yasuyuki Kozakai', # typo
 'yuasa:hh.iij4u.or.jp' => 'Yoichi Yuasa',
 'yuri:acronis.com' => 'Yuri Per', # lbdb
 'zaitcev:redhat.com' => 'Pete Zaitcev',

