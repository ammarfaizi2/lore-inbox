Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbTLTXi5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 18:38:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbTLTXi5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 18:38:57 -0500
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:4526 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261825AbTLTXhk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 18:37:40 -0500
MIME-Version: 1.0
To: torvalds@osdl.org, marcelo.tosatti@cyclades.com.br
Subject: lk-changelog.pl 0.206
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Sat_Dec_20_23_37_30_UTC_2003_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20031220233730.D1A20975DC@merlin.emma.line.org>
Date: Sun, 21 Dec 2003 00:37:30 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a semi-automatic announcement.

lk-changelog.pl aka. shortlog version 0.206 has been released.

This script is used by Linus and Marcelo to rearrange and reformat BK
ChangeSet logs into a more human-readable format, and the official
repository is Parent repository is http://bktools.bkbits.net/bktools

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
revision 0.206
date: 2003/12/20 23:32:45;  author: emma;  state: Exp;  lines: +5 -2
Resolve conflict with Linus' version.
----------------------------
revision 0.205
date: 2003/12/11 14:08:38;  author: vita;  state: Exp;  lines: +13 -2
new translations to cover 2.4.24-pre1
----------------------------
revision 0.204
date: 2003/12/07 18:30:25;  author: emma;  state: Exp;  lines: +6 -3
Fix Kai Mäkisara's name. Patch by Marcus Alanen.
----------------------------
revision 0.203
date: 2003/12/06 16:40:13;  author: emma;  state: Exp;  lines: +6 -1
Add two addresses, three still nknown since 2.4.23.
=============================================================================
Index: lk-changelog.pl
===================================================================
RCS file: /var/CVS/lk-changelog/lk-changelog.pl,v
retrieving revision 0.203
retrieving revision 0.206
diff -u -r0.203 -r0.206
--- lk-changelog.pl	6 Dec 2003 16:40:13 -0000	0.203
+++ lk-changelog.pl	20 Dec 2003 23:32:45 -0000	0.206
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.203 2003/12/06 16:40:13 emma Exp $
+# $Id: lk-changelog.pl,v 0.206 2003/12/20 23:32:45 emma Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -234,6 +234,7 @@
 'aschultz:warp10.net' => 'Andreas Schultz',
 'asit.k.mallick:intel.com' => 'Asit K. Mallick', # by Kristian Peters
 'asl:launay.org' => 'Arnaud S. Launay',
+'aspicht:arkeia.com' => 'Arnaud Spicht',
 'atulm:lsil.com' => 'Atul Mukker',
 'atul.mukker:lsil.com' => 'Atul Mukker',
 'axboe:burns.home.kernel.dk' => 'Jens Axboe', # guessed
@@ -309,6 +310,9 @@
 'cananian:lesser-magoo.lcs.mit.edu' => 'C. Scott Ananian',
 'car.busse:gmx.de' => 'Carsten Busse',	# verified by Greg KH
 'cat:zip.com.au' => 'CaT',
+'cattelan:lupo.thebarn.com' => 'Russell Cattelan',
+'cattelan:naboo.americas.sgi.com' => 'Russell Cattelan',
+'cattelan:naboo.eagan' => 'Russell Cattelan',
 'cattelan:sgi.com' => 'Russell Cattelan', # google
 'ccaputo:alt.net' => 'Chris Caputo',
 'ccheney:cheney.cx' => 'Christopher L. Cheney',
@@ -740,7 +744,8 @@
 'jsimmons:kozmo.(none)' => 'James Simmons',
 'jsimmons:maxwell.earthlink.net' => 'James Simmons',
 'jsimmons:transvirtual.com' => 'James Simmons',
-'jsm:udlkern.fc.hp.com' => 'John Marvin',
+'jsm:fc.hp.com' => 'John S. Marvin',
+'jsm:udlkern.fc.hp.com' => 'John S. Marvin',
 'jsun:mvista.com' => 'Jun Sun',
 'jt:bougret.hpl.hp.com' => 'Jean Tourrilhes',
 'jt:hpl.hp.com' => 'Jean Tourrilhes',
@@ -754,7 +759,7 @@
 'kaber:trash.net' => 'Patrick McHardy',
 'kadlec:blackhole.kfki.hu' => 'Jozsef Kadlecsik',
 'kai-germaschewski:uiowa.edu' => 'Kai Germaschewski',
-'kai.makisara:kolumbus.fi' => 'Kai Makisara',
+'kai.makisara:kolumbus.fi' => 'Kai Mäkisara',
 'kai.reichert:udo.edu' => 'Kai Reichert',
 'kai:chaos.tp1.ruhr-uni-bochum.de' => 'Kai Germaschewski',
 'kai:germaschewski.name' => 'Kai Germaschewski',
@@ -813,6 +818,7 @@
 'kunihiro:ipinfusion.com' => 'Kunihiro Ishiguro',
 'kurt.robideau:comtrol.com' => 'Kurt Robideau',	# wild guess
 'kyle:debian.org' => 'Kyle McMartin',
+'kyle:engsoc.carleton.ca' => 'Kyle McMartin',
 'l.s.r:web.de' => 'René Scharfe',
 'ladis:psi.cz' => 'Ladislav Michl',
 'laforge:gnumonks.org' => 'Harald Welte',
@@ -873,7 +879,7 @@
 'maalanen:ra.abo.fi' => 'Marcus Alanen',
 'mac:melware.de' => 'Armin Schindler',
 'macro:ds2.pg.gda.pl' => 'Maciej W. Rozycki',
-'makisara:abies.metla.fi' => 'Kai Makisara',
+'makisara:abies.metla.fi' => 'Kai Mäkisara',
 'maloi:phota.to' => 'Andy Molloy',
 'malte.d:gmx.net' => 'Malte Doersam', # google
 'manand:us.ibm.com' => 'Mala Anand',
@@ -998,6 +1004,7 @@
 'mzyngier:freesurf.fr' => 'Marc Zyngier',
 'n0ano:n0ano.com' => 'Don Dugger',
 'nahshon:actcom.co.il' => 'Itai Nahshon',
+'nathans:bruce.melbourne.sgi.com' => 'Nathan Scott',
 'nathans:sgi.com' => 'Nathan Scott',
 'neilb:cse.unsw.edu.au' => 'Neil Brown',
 'neilt:slimy.greenend.org.uk' => 'Neil Turton',
@@ -1066,7 +1073,7 @@
 'pavel:janik.cz' => 'Pavel Janík',
 'pavel:suse.cz' => 'Pavel Machek',
 'pavel:ucw.cz' => 'Pavel Machek',
-'pavlin:icir.org' => 'Pavlin Radoslavov', # lbdb
+'pavlin:icir.org' => 'Pavlin Radoslavov',
 'pazke:donpac.ru' => 'Andrey Panin',
 'pazke:orbita1.ru' => 'Andrey Panin',
 'pbadari:us.ibm.com' => 'Badari Pulavarty',
@@ -1412,6 +1419,7 @@
 'wensong:linux-vs.org' => 'Wensong Zhang',
 'wes:infosink.com' => 'Wes Schreiner',
 'wesolows:foobazco.org' => 'Keith M. Wesolowski',
+'wessmith:sgi.com' => 'Wesley Smith',
 'wg:malloc.de' => 'Wolfram Gloger', # lbdb
 'whitney:math.berkeley.edu' => 'Wayne Whitney',
 'whydoubt:yahoo.com' => 'Jeff Smith',
@@ -2142,6 +2150,15 @@
 __END__
 # --------------------------------------------------------------------
 # $Log: lk-changelog.pl,v $
+# Revision 0.206  2003/12/20 23:32:45  emma
+# Resolve conflict with Linus' version.
+#
+# Revision 0.205  2003/12/11 14:08:38  vita
+# new translations to cover 2.4.24-pre1
+#
+# Revision 0.204  2003/12/07 18:30:25  emma
+# Fix Kai Mäkisara's name. Patch by Marcus Alanen.
+#
 # Revision 0.203  2003/12/06 16:40:13  emma
 # Add two addresses, three still nknown since 2.4.23.
 #

