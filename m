Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbTLTXgh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 18:36:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261827AbTLTXgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 18:36:37 -0500
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:3246 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261784AbTLTXg1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 18:36:27 -0500
MIME-Version: 1.0
To: torvalds@osdl.org, marcelo.tosatti@cyclades.com.br
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Sat_Dec_20_23_36_17_UTC_2003_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20031220233618.1DB83975DC@merlin.emma.line.org>
Date: Sun, 21 Dec 2003 00:36:18 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use "bk receive" to patch with this mail,
or you can
Pull from: bk://krusty.dt.e-technik.uni-dortmund.de/BK-kernel-tools
or in cases of dire need, you can apply the patch below.

BK: Parent repository is http://bktools.bkbits.net/bktools

Patch description:
ChangeSet@1.104, 2003-12-21 00:30:47+01:00, matthias.andree@gmx.de
  Drop our version of Pavlin Radoslavov's address, use Linus'.
  Resolves merge conflict.

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
# shortlog |   25 +++++++++++++++++++++----
# 1 files changed, 21 insertions(+), 4 deletions(-)

##### GNUPATCH #####
# This is a BitKeeper generated patch for the following project:
# Project Name: BK kernel tools
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.104   -> 1.105  
#	            shortlog	1.77    -> 1.78   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/12/21	matthias.andree@gmx.de	1.105
# Marcus Alanen: Fix Kai Mäkisara's name spelling.
# Vitezslav Samel: Eight new mappings.
# --------------------------------------------
#
diff -Nru a/shortlog b/shortlog
--- a/shortlog	Sun Dec 21 00:36:17 2003
+++ b/shortlog	Sun Dec 21 00:36:17 2003
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

##### BKPATCH #####
This BitKeeper patch contains the following changesets:
1.104
## Wrapped with gzip_uu ##


M'XL( /'<Y#\  ]V4SV[;, S&S]%3$.BAA\X.)?^1;2!#UV;8@'98D:(/H-J*
M;=2V DGQ,L //R59$R1M-JS;:;8N-$CJX\<?? 8/1NILU IKJUH87W2%EI*<
MP6=E;#8JVY5?K,.94BX<FZ61XR>I.]F,KV[<\;:!9Y5J#'&)=\+F%?12FVQ$
M_6#WQ7Y?R&PT^_CIX?;#C)#)!*XKT97R7EJ83(A5NA=-82X7LBN7=>=;+3K3
M2BO\7+7#+G=@B,R]E 481^G TCB*!LED%.4A%8\\X3)GY&B>R^T<AVT"RC"F
M<8@A'UP_RL@4J$\Q! S&E(T9!<0LP"SD%T@S1'B]*UQ0\)!<P3^>X9KD,-5J
M 6JI-X;6J@,U=W[V3=W!3!3*-*)7_;D!43A!QKP#MQ^XK;NE.?==^4P:U?32
M0"MU*2%7W;RI<^N3>B^V4JWTE2D:7^GRA4,T04I3QM8.13&Y@;5IY,L;R^_V
M2R?>'SZ$H$#R_NCF0XM-I;1M5+EU.'*W\Y#39 @H3Z-A+E,QSSFF F4A'HL3
M^SSHXF9PJPH"#./!D9+P#;K/&0?D_K6>4]0>Z?D)[5I/FN(&6LY?,!O_AED$
MC_XGS![YLV..84*Y0W:[MY/,_KK\*WCZVVI]O)7C]SGY#?A.*7($NO])YI7,
4G\RRG00)ABDK8O(#J+4%HH\%    
 

