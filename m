Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263632AbUA0OqL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 09:46:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263653AbUA0OqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 09:46:11 -0500
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:58767 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S263632AbUA0OqE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 09:46:04 -0500
MIME-Version: 1.0
To: torvalds@osdl.org, marcelo.tosatti@cyclades.com.br
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Tue_Jan_27_14_46_01_UTC_2004_0@merlin.emma.line.org>
Content-Type: text/plain; charset=US-ASCII
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 7BIT
Message-Id: <20040127144601.5F92819E3@merlin.emma.line.org>
Date: Tue, 27 Jan 2004 15:46:01 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use "bk receive" to patch with this mail,
or you can
Pull from: bk://krusty.dt.e-technik.uni-dortmund.de/BK-kernel-tools
or in cases of dire need, you can apply the patch below.

BK: Parent repository is http://bktools.bkbits.net/bktools

Patch description:
ChangeSet@1.120, 2004-01-27 15:45:18+01:00, matthias.andree@gmx.de
  Remove 3 duplicate lines from hash.
  Add address mapping for Francis Wiran.
  Add new "What am I about to pull?" EXAMPLE.

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
# shortlog |   10 ++++++----
# 1 files changed, 6 insertions(+), 4 deletions(-)

##### GNUPATCH #####
# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/01/27 15:45:18+01:00 matthias.andree@gmx.de 
#   Remove 3 duplicate lines from hash.
#   Add address mapping for Francis Wiran.
#   Add new "What am I about to pull?" EXAMPLE.
# 
# shortlog
#   2004/01/27 15:45:17+01:00 matthias.andree@gmx.de +6 -4
#   Remove 3 duplicate lines from hash.
#   Add address mapping for Francis Wiran.
#   Add new "What am I about to pull?" EXAMPLE.
# 
diff -Nru a/shortlog b/shortlog
--- a/shortlog	Tue Jan 27 15:46:01 2004
+++ b/shortlog	Tue Jan 27 15:46:01 2004
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.221 2004/01/23 10:24:51 vita Exp $
+# $Id: lk-changelog.pl,v 0.224 2004/01/27 14:40:49 emma Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -471,7 +471,6 @@
 'dmccr:us.ibm.com' => 'Dave McCracken',
 'dmo:osdl.org' => 'Dave Olien',
 'doj:cubic.org' => 'Dirk Jagdmann',
-'doj:cubic.org' => 'Dirk Jagdmann',
 'dok:directfb.org' => 'Denis Oliver Kropp',
 'dougg:torque.net' => 'Douglas Gilbert',
 'drb:med.co.nz' => 'Ross Boswell',
@@ -550,6 +549,7 @@
 'fnm:fusion.ukrsat.com' => 'Nick Fedchik',
 'focht:ess.nec.de' => 'Erich Focht',
 'fokkensr:fokkensr.vertis.nl' => 'Rolf Fokkens',
+'francis.wiran:hp.com' => 'Francis Wiran',
 'franz.sirl-kernel:lauterbach.com' => 'Franz Sirl',
 'franz.sirl:lauterbach.com' => 'Franz Sirl',
 'frival:zk3.dec.com' => 'Peter Rival',
@@ -583,7 +583,6 @@
 'gl:dsa-ac.de' => 'Guennadi Liakhovetski',
 'glee:gnupilgrims.org' => 'Geoffrey Lee', # lbdb
 'glenn:aoi-industries.com' => 'Glenn Burkhardt',
-'glenn:aoi-industries.com' => 'Glenn Burkhardt',
 'gnb:alphalink.com.au' => 'Greg Banks',
 'go:turbolinux.co.jp' => 'Go Taniguchi',
 'gone:us.ibm.com' => 'Patricia Gaughen',
@@ -1138,7 +1137,6 @@
 'pdelaney:lsil.com' => 'Pam Delaney',
 'pe1rxq:amsat.org' => 'Jeroen Vreeken',
 'pebl:math.ku.dk' => 'Peter Berg Larsen',
-'pebl:math.ku.dk' => 'Peter Berg Larsen',
 'pee:erkkila.org' => 'Paul E. Erkkila',
 'pekon:informatics.muni.cz' => 'Petr Konecny',
 'per.winkvist:telia.com' => 'Per Winkvist',
@@ -2327,6 +2325,10 @@
 =head1 EXAMPLES
 
 =over
+
+=item "What am I about to pull?"
+
+bk changes -R -m | lk-changelog.pl | less
 
 =item Reformat ChangeLog-2.5.17, displaying all changes grouped by
   their author (that is the default mode, but we specify it anyways),

##### BKPATCH #####
This BitKeeper patch contains the following changesets:
1.120
## Wrapped with gzip_uu ##


M'XL( *EY%D   ]U46V^;,!A]CG_%I[92'EJ(;6P(2'2])-VJ=EJ5J>H>]N* 
M$U  (^Q<)O'C9Q*E53IUTRY/ PMLZ^-POG..? R/6C91KQ3&9+G0KJC21DIT
M#!^4-E%O7F[<M%M.E+++@5YJ.5C(II+%X.K.#F>W<(Q2A4:V\$&8)(.5;'34
M(Z[WO&.^U3+J3<;O'^\O)PC%,5QGHIK+S]) '".CFI4H4GU1RVJ^S"O7-*+2
MI33"3539/M>V%&-J;T(][/.PI:'/>2NIY#QA1$R#82 3^@*7J5*Z2J>%JYKY
M(0RS(#ZFS"/#UDZYAT9 7$(Q8#; 9$ #(#QB/"+#4TPBC.&52A<[=>"4@(/1
M%?SC'JY1 A-9JI4$#])E7>2),!**O)(:9HTJ(1,Z<VW599J"2"TEK2W'NLZK
M.<Q4 S?V_TFNX2FWDWUA)==P])0) Z*$6Q!3M326.M3+HGAW!.,OEQ\?[L<N
MN@-""4</+SXAYS<OA+# Z!P.W3A416>J,86:[T3A9(@#%EA'/!*$O)W)4,R2
M (<"RU1,TS<L.$#I? T(8YP$K4]PZ&_3MJ\X"-M?\WDK:*_Y['/FDP#C;<Y"
M[X>8!;^(F0\.^P]CMO/H$SC->M,-9V-#MQ?P#S(W(@0(NMT^C^'D-HV@6#C)
M5A:+Z-;%V0JP2RF#SIV]!RQB.&(AR+(4,-[4<()&+& =%.?4OOJS79_NNNLS
MRNI.[C[$Y] _4*!_AD9\Z-LO+!.VY4(]&@)#7U&<&UG^1!=;,EW CJL&9P).
A">UK^MV.]>#EM$TRF2STLHQ]D81A.DO0=RWV_4/8!0  
 

