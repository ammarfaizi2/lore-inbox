Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262974AbTJPO12 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 10:27:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262987AbTJPO12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 10:27:28 -0400
Received: from mail.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:52915 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262974AbTJPO1K convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 10:27:10 -0400
MIME-Version: 1.0
To: torvalds@osdl.org, marcelo.tosatti@cyclades.com.br
Subject: lk-changelog.pl 0.190
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Thu_Oct_16_14_27_07_UTC_2003_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20031016142707.5E0D296DB2@merlin.emma.line.org>
Date: Thu, 16 Oct 2003 16:27:07 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a semi-automatic announcement.

lk-changelog.pl aka. shortlog version 0.190 has been released.

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
revision 0.190
date: 2003/10/16 12:33:28;  author: vita;  state: Exp;  lines: +7 -1
3 new addresses
----------------------------
revision 0.189
date: 2003/10/13 09:14:23;  author: vita;  state: Exp;  lines: +10 -1
6 new addresses
----------------------------
revision 0.188
date: 2003/10/10 08:49:34;  author: vita;  state: Exp;  lines: +6 -1
2 new addresses
----------------------------
revision 0.187
date: 2003/10/08 21:56:22;  author: emma;  state: Exp;  lines: +6 -1
Merge Linus' changes.
----------------------------
revision 0.186
date: 2003/10/08 11:11:02;  author: vita;  state: Exp;  lines: +13 -1
9 new addresses
=============================================================================
Index: lk-changelog.pl
===================================================================
RCS file: /var/CVS/lk-changelog/lk-changelog.pl,v
retrieving revision 0.186
retrieving revision 0.190
diff -u -r0.186 -r0.190
--- lk-changelog.pl	8 Oct 2003 11:11:02 -0000	0.186
+++ lk-changelog.pl	16 Oct 2003 12:33:28 -0000	0.190
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.186 2003/10/08 11:11:02 vita Exp $
+# $Id: lk-changelog.pl,v 0.190 2003/10/16 12:33:28 vita Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -193,6 +193,7 @@
 'alext:fc.hp.com' => 'Alex Tsariounov',
 'alfre:ibd.es' => 'Alfredo Sanjuán',
 'aliakc:web.de' => 'Ali Akcaagac', # lbdb
+'amalysh:web.de' => 'Alexander Malysh',
 'ambx1:com.rmk.(none)' => 'Adam Belay',
 'ambx1:neo.rr.com' => 'Adam Belay',
 'amir.noam:intel.com' => 'Amir Noam',
@@ -301,6 +302,7 @@
 'cagle:mindspring.com' => 'John Cagle', # Alan
 'calum.mackay:cdmnet.org' => 'Calum Mackay', # lbdb
 'cananian:lesser-magoo.lcs.mit.edu' => 'C. Scott Ananian',
+'cat:zip.com.au' => 'CaT',
 'cattelan:sgi.com' => 'Russell Cattelan', # google
 'ccaputo:alt.net' => 'Chris Caputo',
 'ccheney:cheney.cx' => 'Christopher L. Cheney',
@@ -403,6 +405,7 @@
 'davidm:wailua.hpl.hp.com' => 'David Mosberger',
 'davids:youknow.youwant.to' => 'David Schwartz', # google
 'davidvh:cox.net' => 'David van Hoose',
+'dax:gurulabs.com' => 'Dax Kelson',
 'dbrownell:users.sourceforge.net' => 'David Brownell',
 'ddstreet:ieee.org' => 'Dan Streetman',
 'ddstreet:us.ibm.com' => 'Dan Streetman',
@@ -476,6 +479,7 @@
 'eric.piel:bull.net' => 'Eric Piel',
 'eric:lammerts.org' => 'Eric Lammerts',
 'erik:aarg.net' => 'Erik Arneson',
+'erik:harddisk-recovery.nl' => 'Erik Mouw',
 'erik_habbinga:hp.com' => 'Erik Habbinga',
 'erikj:subway.americas.sgi.com' => 'Erik Jacobson',
 'erlend-a:us.his.no' => 'Erlend Aasland',
@@ -632,6 +636,7 @@
 'jamie:shareable.org' => 'Jamie Lokier',
 'jan.oravec:6com.sk' => 'Jan Oravec',
 'jan:zuchhold.com' => 'Jan Zuchhold',
+'janetmor:us.ibm.com' => 'Janet Morgan',
 'jani:astechnix.ro' => 'Jani Monoses',
 'jani:iv.ro' => 'Jani Monoses',
 'janiceg:us.ibm.com' => 'Janice M. Girouard',
@@ -768,6 +773,7 @@
 'khali:linux-fr.org' => 'Jean Delvare', # lbdb
 'khalid:fc.hp.com' => 'Khalid Aziz',
 'khalid_aziz:hp.com' => 'Khalid Aziz',
+'khc:pc.waw.pl' => 'Krzysztof Halasa',
 'khc:pm.waw.pl' => 'Krzysztof Halasa',
 'kiran:in.ibm.com' => 'Ravikiran G. Thirumalai',
 'kisza:sch.bme.hu' => 'Andras Kis-Szabo', # google (netfilter-ext HOWTO)
@@ -992,6 +998,7 @@
 'nkiesel:tbdnetworks.com' => 'Norbert Kiesel',
 'nlaredo:transmeta.com' => 'Nathan Laredo',
 'nmiell:attbi.com' => 'Nicholas Miell',
+'noah:caltech.edu' => 'Noah J. Misch',
 'nobita:t-online.de' => 'Andreas Busch',
 'nstraz:sgi.com' => 'Nathan Straz',
 'ntfs:flatcap.org' => 'Richard Russon', # lbdb
@@ -1050,6 +1057,7 @@
 'peter:bergner.org' => 'Peter Bergner',
 'peter:cadcamlab.org' => 'Peter Samuelson',
 'peter:chubb.wattle.id.au' => 'Peter Chubb',
+'peterc:chubb.wattle.id.au' => 'Peter Chubb',
 'peterc:gelato.unsw.edu.au' => 'Peter Chubb',
 'peterm:remware.demon.co.uk' => 'Peter Milne',
 'peterm:uk.rmk.(none)' => 'Peter Milne',
@@ -1078,6 +1086,7 @@
 'pmanolov:lnxw.com' => 'Petko Manolov',
 'pmenage:ensim.com' => 'Paul Menage',
 'porter:cox.net' => 'Matt Porter',
+'pp:ee.oulu.fi' => 'Pekka Pietikäinen',
 'pp:netppl.fi' => 'Pekka Pietikäinen',
 'ppc64:brule.rchland.ibm.com' => 'Peter Bergner',
 'prom:berlin.ccc.de' => 'Ingo Albrecht',
@@ -1127,6 +1136,7 @@
 'rjweryk:uwo.ca' => 'Rob Weryk',
 'rl:hellgate.ch' => 'Roger Luethi',
 'rlievin:free.fr' => 'Romain Lievin',
+'rmk+lkml:arm.linux.org.uk' => 'Russell King',
 'rmk:arm.linux.org.uk' => 'Russell King',
 'rmk:flint.arm.linux.org.uk' => 'Russell King',
 'rml:tech9.net' => 'Robert Love',
@@ -1299,6 +1309,7 @@
 'thornber:sistina.com' => 'Joe Thornber',
 'thunder:ngforever.de' => 'Thunder From The Hill',
 'tigran:aivazian.name' => 'Tigran Aivazian',
+'tigran:veritas.com' => 'Tigran Aivazian',
 'tim:physik3.uni-rostock.de' => 'Tim Schmielau',
 'timw:splhi.com' => 'Tim Wright',
 'tinglett:vnet.ibm.com' => 'Todd Inglett',
@@ -1309,6 +1320,7 @@
 'tomita:cinet.co.jp' => 'Osamu Tomita',
 'toml:us.ibm.com' => 'Tom Lendacky',
 'tomlins:cam.org' => 'Ed Tomlinson',
+'tommy.christensen:tpack.net' => 'Tommy Christensen',
 'tony.luck:intel.com' => 'Tony Luck',
 'tony:cantech.net.au' => 'Anthony J. Breeds-Taurima',
 'tonyb:cybernetics.com' => 'Tony Battersby',
@@ -1392,6 +1404,7 @@
 'xavier.bru:bull.net' => 'Xavier Bru',
 'xkaspa06:stud.fee.vutbr.cz' => 'Tomas Kasparek',
 'xose:wanadoo.es' => 'Xose Vazquez Perez', # lbdb
+'y.rutschle:com.rmk.(none)' => 'Yves Rutschle',
 'ya:slamail.org' => 'Yaacov Akiba Slama',
 'yinah:couragetech.com.cn' => 'Yin Aihua',
 'yokota:netlab.is.tsukuba.ac.jp' => 'Yokota Hiroshi',
@@ -2095,6 +2108,18 @@
 __END__
 # --------------------------------------------------------------------
 # $Log: lk-changelog.pl,v $
+# Revision 0.190  2003/10/16 12:33:28  vita
+# 3 new addresses
+#
+# Revision 0.189  2003/10/13 09:14:23  vita
+# 6 new addresses
+#
+# Revision 0.188  2003/10/10 08:49:34  vita
+# 2 new addresses
+#
+# Revision 0.187  2003/10/08 21:56:22  emma
+# Merge Linus' changes.
+#
 # Revision 0.186  2003/10/08 11:11:02  vita
 # 9 new addresses
 #

