Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbTD1W4a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 18:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261387AbTD1W4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 18:56:30 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:5393 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261375AbTD1W40 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 18:56:26 -0400
MIME-Version: 1.0
To: torvalds@transmeta.com
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Mon_Apr_28_23_08_41_UTC_2003_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20030428230841.75202834C5@merlin.emma.line.org>
Date: Tue, 29 Apr 2003 01:08:41 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use bk receive to patch this mail, you can pull from
bk://krusty.dt.e-technik.uni-dortmund.de  (NOTE: no trailing slash)
or you can apply the patch below.

Patch description:
One correction (we misattributed Vincent Legoll's changes to somebody
else) and five new addresses.
Please merge ASAP.

Matthias
##### DIFFSTAT #####
# shortlog |   16 ++++++++++++++--
# 1 files changed, 14 insertions(+), 2 deletions(-)

##### GNUPATCH #####
# This is a BitKeeper generated patch for the following project:
# Project Name: BK kernel tools
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.50    -> 1.51   
#	            shortlog	1.24    -> 1.25   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/04/29	matthias.andree@gmx.de	1.51
# Update to upstream version 0.106.
# 5 new addresses and one correction.
# --------------------------------------------
#
diff -Nru a/shortlog b/shortlog
--- a/shortlog	Tue Apr 29 01:08:40 2003
+++ b/shortlog	Tue Apr 29 01:08:40 2003
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.104 2003/04/27 13:18:46 emma Exp $
+# $Id: lk-changelog.pl,v 0.106 2003/04/28 23:00:49 emma Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -184,6 +184,7 @@
 'axboe:hera.kernel.org' => 'Jens Axboe',
 'axboe:suse.de' => 'Jens Axboe',
 'azarah:gentoo.org' => 'Martin Schlemmer',
+'b.zolnierkiewicz:elka.pw.edu.pl' => 'Bartlomiej Zolnierkiewicz',
 'baccala:vger.freesoft.org' => 'Brent Baccala',
 'baldrick:wanadoo.fr' => 'Duncan Sands',
 'ballabio_dario:emc.com' => 'Dario Ballabio',
@@ -390,6 +391,7 @@
 'fletch:aracnet.com' => 'Martin J. Bligh',
 'flo:rfc822.org' => 'Florian Lohoff',
 'florian.thiel:gmx.net' => 'Florian Thiel', # from shortlog
+'florin:iucha.net' => 'Florin Iucha',
 'fnm:fusion.ukrsat.com' => 'Nick Fedchik',
 'focht:ess.nec.de' => 'Erich Focht',
 'fokkensr:fokkensr.vertis.nl' => 'Rolf Fokkens',
@@ -463,6 +465,7 @@
 'hpa:transmeta.com' => 'H. Peter Anvin',
 'hpa:zytor.com' => 'H. Peter Anvin',
 'hugh:veritas.com' => 'Hugh Dickins',
+'hunold:convergence.de' => 'Michael Hunold',
 'ica2_ts:csv.ica.uni-stuttgart.de' => 'Thiemo Seufer', # google
 'info:usblcd.de' => 'Adams IT Services',
 'ink:jurassic.park.msu.ru' => 'Ivan Kokshaysky',
@@ -622,7 +625,7 @@
 'ldb:ldb.ods.org' => 'Luca Barbieri',
 'ldm:flatcap.org' => 'Richard Russon',
 'lee:compucrew.com' => 'Lee Nash', # lbdb
-'legoll:free.fr' => 'Vince Hodges',
+'legoll:free.fr' => 'Vincent Legoll', # correction sent by himself
 'leigh:solinno.co.uk' => 'Leigh Brown', # lbdb
 'levon:movementarian.org' => 'John Levon',
 'lfo:polyad.org' => 'Luis F. Ortiz',
@@ -632,6 +635,7 @@
 'lionel.bouton:inet6.fr' => 'Lionel Bouton',
 'lists:mdiehl.de' => 'Martin Diehl',
 'liyang:nerv.cx' => 'Liyang Hu',
+'lkml:shemesh.biz' => 'Shachar Shemesh',
 'lm:bitmover.com' => 'Larry McVoy',
 'lm:work.bitmover.com' => 'Larry McVoy',
 'lopezp:grupocp.es' => 'Jose A. Lopez',
@@ -1011,6 +1015,8 @@
 'vberon:mecano.gme.usherb.ca' => 'Vincent Béron',
 'venkatesh.pallipadi:intel.com' => 'Venkatesh Pallipadi',
 'viro:math.psu.edu' => 'Alexander Viro',
+'viro:parcelfarce.linux.theplanet.co.uk' => 'Alexander Viro',
+'viro:www.linux.org.uk' => 'Alexander Viro',
 'vojta:math.berkeley.edu' => 'Paul Vojta',
 'vojtech:suse.cz' => 'Vojtech Pavlik',
 'vojtech:twilight.ucw.cz' => 'Vojtech Pavlik',
@@ -1642,6 +1648,12 @@
 __END__
 # --------------------------------------------------------------------
 # $Log: lk-changelog.pl,v $
+# Revision 0.106  2003/04/28 23:00:49  emma
+# Correct Vincent Legoll's name (was confused with somebody else).
+#
+# Revision 0.105  2003/04/28 12:20:56  vita
+# added 5 names for new addresses
+#
 # Revision 0.104  2003/04/27 13:18:46  emma
 # Add two more addresses.
 #

##### BKPATCH #####
This BitKeeper patch contains the following changesets:
1.51
## Wrapped with gzip_uu ##


begin 600 bkpatch3906
M'XL(`'BTK3X``\U576_;-A1]#G_%!5S`&QK3I#XL2X"+-DFW&NVP(D'ZL#=:
MNK8T4Z)!TA\)_.-W):W)[#48]O$P29!`\MS#>\\]`@=P[]!F%[7ROJR4XZHI
M+"(;P`?C?':QJ@^\:(>WQM!P[+8.QVNT#>KQU4=Z1OU@Y(W1CA'PL_)Y"3NT
M+KN0/'R:\0\;S"YNW_]X_^G=+6.S&5R7JEGA'7J8S9@W=J=TX=YNL%EMJX9[
MJQI7HU<\-_7Q"7L,A`CHED$H)G%Z#-))'!\QP#C.(ZD6R33!/&!G];SMZSBE
M"444)#(D+G&,8SD5[`8DCR6(<"RB<9""D)E(,A&\%D$F!'R;%%Y+&`EV!?]Q
M"=<LA_M-H3P2,VPWSEM4=:=L91H07(H))TP,#>Y!%922<^B`D@/3(.3&6LP]
M83G["%1@DK+/SZ*ST=^\&!-*L#?/99:FQK,:76FLUV;5E]AJFD2)G!Y#VCP^
M+C%5RSP1J1)8J$7Q@J`G+&V3IB14(N11!)-DVEGG*^+$.?\ZGY=<<YY/9QI!
MC8O21':F">(_F4;^E6DB&`7_=]=T@O\,([L_M,_H0`[ZJL8_,-"-E"#9O'L/
MX-6\R$"O1WE7(C'RC;[<]2E"*W4GZ!2"D'3,HA2PKA6\/VS@%7%,)T0R7/!'
MHYL*[;K"?94_9JC7BF_V'(LMT0UA]@:&5ZI-N*[P5_CE!#V\9/,P#5JBI3:V
M:K)J2]GP!GT?^4,W"_-VM@5'D[@%E]O&Z"++34.ZKK#)D5K:1_Q4$10U?.@@
M%',S"=J8>?\9:EP9K;,E68$O;1_SI2*&QL.G;FUX"8,_M`%<N[1X@+*J'>HE
M,851Q[2N=>9*K-&5?%$]]EQWI:($+-SU"VW24L@0`C;<5=9D&V5S8FG?7%?-
M]L!]B1NMJ&3R&]^N>YIW&@]D";3PA:*(I8_>[_>_1QF[>AD\EY,H@DE[;."N
M>C8>?+.M75\)>]W7#&=R.&A4C?#=7CF2I5G2"53`OO(E./KA%Z9X`-0.O^=L
M<+YA?+*A#+)`9#%EL:M\NR&YGZCBCM_!TMC3?X+XGDZOO,1\[;;U+%PJ*8HT
+9;\!"<I.QCH'````
`
end

