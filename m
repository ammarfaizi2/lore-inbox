Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261874AbTFXKrU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 06:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261936AbTFXKrU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 06:47:20 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:50444 "EHLO
	krusty.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261874AbTFXKqx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 06:46:53 -0400
MIME-Version: 1.0
To: torvalds@transmeta.com
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Tue_Jun_24_11_00_58_UTC_2003_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20030624110058.9D1F5868E2@merlin.emma.line.org>
Date: Tue, 24 Jun 2003 13:00:58 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use bk receive to patch this mail, you can pull from
bk://krusty.dt.e-technik.uni-dortmund.de  (NOTE: no trailing slash)
or you can apply the patch below.

BK: Parent repository is bk://kernel.bkbits.net/torvalds/tools/

Patch description:
6 new address->name mappings

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
# shortlog |   19 +++++++++++++++++--
# 1 files changed, 17 insertions(+), 2 deletions(-)

##### GNUPATCH #####
# This is a BitKeeper generated patch for the following project:
# Project Name: BK kernel tools
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.63    -> 1.64   
#	            shortlog	1.37    -> 1.38   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/06/24	matthias.andree@gmx.de	1.64
# 6 new addresses (resync upstream version 0.137)
# --------------------------------------------
#
diff -Nru a/shortlog b/shortlog
--- a/shortlog	Tue Jun 24 13:00:57 2003
+++ b/shortlog	Tue Jun 24 13:00:57 2003
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.134 2003/06/20 09:15:01 vita Exp $
+# $Id: lk-changelog.pl,v 0.137 2003/06/24 08:59:08 vita Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -299,6 +299,7 @@
 'ctindel:cup.hp.com' => 'Chad N. Tindel',
 'cubic:miee.ru' => 'Ruslan U. Zakirov',
 'cw:f00f.org' => 'Chris Wedgwood',
+'cweidema:indiana.edu' => 'Christoph Weidemann',
 'cwf:sgi.com' => 'Charles Fumuso',
 'cyeoh:samba.org' => 'Christopher Yeoh',
 'd.mueller:elsoft.ch' => 'David Müller',
@@ -401,7 +402,8 @@
 'elenstev:mesatop.com' => 'Steven Cole',
 'eli.carter:com.rmk.(none)' => 'Eli Carter',
 'eli.kupermann:intel.com' => 'Eli Kupermann',
-'engebret:us.ibm.com' => 'Dave Engebretsen',
+'engebret:brule.rchland.ibm.com' => 'David Engebretsen',
+'engebret:us.ibm.com' => 'David Engebretsen',
 'eranian:frankl.hpl.hp.com' => 'Stéphane Eranian',
 'eranian:hpl.hp.com' => 'Stéphane Eranian',
 'eric.piel:bull.net' => 'Eric Piel',
@@ -474,6 +476,7 @@
 'gtoumi:laposte.net' => 'Ghozlane Toumi',
 'gwehrman:sgi.com' => 'Geoffrey Wehrman',
 'hadi:cyberus.ca' => 'Jamal Hadi Salim',
+'hadi:shell.cyberus.ca' => 'Jamal Hadi Salim',
 'hannal:us.ibm.com' => 'Hanna V. Linder',
 'hanno:gmx.de' => 'Hanno Böck',
 'harald:gnumonks.org' => 'Harald Welte',
@@ -672,6 +675,7 @@
 'laurent:latil.nom.fr' => 'Laurent Latil',
 'lawrence:the-penguin.otak.com' => 'Lawrence Walton',
 'ldb:ldb.ods.org' => 'Luca Barbieri',
+'ldl:aros.net' => 'Lou Langholtz',
 'ldm:flatcap.org' => 'Richard Russon',
 'lee:compucrew.com' => 'Lee Nash', # lbdb
 'legoll:free.fr' => 'Vincent Legoll', # correction sent by himself
@@ -924,6 +928,7 @@
 'rhirst:linuxcare.com' => 'Richard Hirst',
 'rhw:infradead.org' => 'Riley Williams',
 'richard.brunner:amd.com' => 'Richard Brunner',
+'richard.curnow:superh.com' => 'Richard Curnow',
 'riel:conectiva.com.br' => 'Rik van Riel',
 'riel:imladris.surriel.com' => 'Rik van Riel',
 'riel:redhat.com' => 'Rik van Riel',
@@ -1007,6 +1012,7 @@
 'smurf:osdl.org' => 'Nathan Dabney',
 'snailtalk:linux-mandrake.com' => 'Geoffrey Lee', # by himself
 'solar:openwall.com' => 'Solar Designer',
+'solt:dns.toxicfilms.tv' => 'Maciej Soltysiak',
 'soruk:eridani.co.uk' => 'Michael McConnell',
 'sparker:sun.com' => 'Steven Parker', # by Duncan Laurie
 'sprite:sprite.fr.eu.org' => 'Jeremie Koenig',
@@ -1743,6 +1749,15 @@
 __END__
 # --------------------------------------------------------------------
 # $Log: lk-changelog.pl,v $
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

##### BKPATCH #####
This BitKeeper patch contains the following changesets:
1.64
## Wrapped with gzip_uu ##


begin 600 bkpatch25721
M'XL(`&DO^#X``\U576_;-A1]#G_%!5+`&UK+)/4MP$77)&BSIFB1H-@S3=U8
M7"31("G'&?SC1TIMG'19NZ^'28)$2N<<71X>2L?PR:*ICCKA7*.$C41?&T1R
M#&^U==71NMM%=>A>:NV["SM87-R@Z;%=O'[GC_G4F3NM6TL\\*-PLH$M&EL=
ML2B^O^/N-E@=79Z]^73QTR4ARR6<-*)?XQ4Z6"Z)TV8KVMJ^VF"_'E0?.2-Z
MVZ$3D=3=_AZ[YY1ROS,>TRPM][S,TG2/'--4)DRL\B)'R0]RC>[P6UI>A7-6
M)&62[2F/>49.@459`C1>T&S!$V!Q16D5Q\\I]PWXRJE7DT/PG,&<DM?P'X_C
MA$C(H,=;$+5_G;5HX0=_O>LE#!OK#(IN-%OI'FC$XOQ'\@Y8SF/R\6`PF?_-
MC1`J*'D)W[+1-MJX5J^GD:2LH'F2LV(?L[Q,]]=8BFN9TU)0K,6J_A/?'JF$
MN4@8\PVV3U.696-,OB`>I>1?U_.7I1X&A.4T+L:`Q,4?`L*^%Y`<YOS_DI#)
MW@\P-[>[<,QW/B]?AOT/XG+*&#!R/IZ/X=EY74%[,Y?C6+QBM&E?;*>W0_#T
MLW.TJ-*RH@5LE1-PMMO`,W(>TR`RD[>H:NQ$I?I:B5Y$6`\S6+Z$V4ECE'5Z
MT\`O$Z3O9R_(:4*34$*X<#+SWN+*H*M69F@Q,K)I_7Q$:M4%ER>A4[%5-9Q]
M1EH,,@?B8+^//D_R+!3;B%I5ML&VC>3="HWG2C'1?A:=:.&M!\"5:%476%D>
M2IVU=5L)HVW4HYO`%WJ`"^]9HUOW6T"6?-0WREMIZD@.IM>WE1TV:)I#:9?3
M8S@9'P>>7T1E(%HO5-6]C9S>*7FMVLXWMQ/KO9`*?X4K#[FS2MR,O#Q)H0S?
M>]RJ0V3@R5D;I\UCX\?Q(\=?\[,'_!AH684ED]WS.S1KA`O5#W869)3SQ"=D
KT@<R#/R:2[/*AP6PZYXH(_("]W\?V:"\L4.WY$4=7S,JR>_W+69)^@8`````
`
end

