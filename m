Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262426AbTH1Q3r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 12:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262449AbTH1Q3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 12:29:46 -0400
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:28602 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262426AbTH1Q3l convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 12:29:41 -0400
MIME-Version: 1.0
To: torvalds@osdl.org
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Thu_Aug_28_16_29_38_UTC_2003_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20030828162939.21F75927CE@merlin.emma.line.org>
Date: Thu, 28 Aug 2003 18:29:39 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use "bk receive" to patch with this mail,
or you can pull from bk://krusty.dt.e-technik.uni-dortmund.de  (NOTE: no
trailing slash) or in cases of dire need, you can apply the patch below.

BK: Parent repository is bk://kernel.bkbits.net/torvalds/tools/

Patch description:
8 new mappings

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
# shortlog |   27 +++++++++++++++++++++++++--
# 1 files changed, 25 insertions(+), 2 deletions(-)

##### GNUPATCH #####
# This is a BitKeeper generated patch for the following project:
# Project Name: BK kernel tools
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.79    -> 1.80   
#	            shortlog	1.52    -> 1.53   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/08/28	matthias.andree@gmx.de	1.80
# 7 new addresses and 1 new regexp.
# --------------------------------------------
#
diff -Nru a/shortlog b/shortlog
--- a/shortlog	Thu Aug 28 18:29:38 2003
+++ b/shortlog	Thu Aug 28 18:29:38 2003
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.159 2003/08/22 08:11:41 vita Exp $
+# $Id: lk-changelog.pl,v 0.164 2003/08/27 13:34:29 vita Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -68,6 +68,7 @@
 # Perl syntax magic here, "=>" is equivalent to ","
 my @addrregexps = (
 [ 'alan@[^.]+\.swansea\.linux\.org\.uk' => 'Alan Cox', ],
+[ 'bos@([^.]+\.)?serpentine\.com' => 'Bryan O\'Sullivan', ],
 [ 'davem@[^.]+\.ninka\.net' => 'David S. Miller', ],
 [ 'kuznet@[^.]+\.inr\.ac\.ru' => 'Alexey Kuznetsov', ],
 [ 'torvalds@([^.]+\.)?transmeta\.com' => 'Linus Torvalds', ],
@@ -94,6 +95,8 @@
 my @addresses_handled_in_regexp = (
 'alan:hraefn.swansea.linux.org.uk' => 'Alan Cox',
 'alan:irongate.swansea.linux.org.uk' => 'Alan Cox',
+'bos:camp4.serpentine.com' => 'Bryan O\'Sullivan',
+'bos:serpentine.com' => 'Bryan O\'Sullivan',
 'davem:cheetah.ninka.net' => 'David S. Miller',
 'davem:nuts.ninka.net' => 'David S. Miller',
 'davem:pizda.ninka.net' => 'David S. Miller', # guessed
@@ -178,6 +181,7 @@
 'alfre:ibd.es' => 'Alfredo Sanjuán',
 'ambx1:com.rmk.(none)' => 'Adam Belay',
 'ambx1:neo.rr.com' => 'Adam Belay',
+'amir.noam:intel.com' => 'Amir Noam',
 'amunoz:vmware.com' => 'Alberto Munoz',
 'andersen:codepoet.org' => 'Erik Andersen',
 'andersg:0x63.nu' => 'Anders Gustafsson',
@@ -255,7 +259,6 @@
 'bmatheny:purdue.edu' => 'Blake Matheny', # google
 'bombe:informatik.tu-muenchen.de' => 'Andreas Bombe',
 'borisitk:fortunet.com' => 'Boris Itkis', # by Kristian Peters
-'bos:camp4.serpentine.com' => 'Bryan O\'Sullivan',
 'braam:clusterfs.com' => 'Peter Braam',
 'brett:bad-sports.com' => 'Brett Pemberton',
 'brihall:pcisys.net' => 'Brian Hall', # google
@@ -593,6 +596,7 @@
 'jbourne:hardrock.org' => 'James Bourne',
 'jcdutton:users.sourceforge.net' => 'James Courtier-Dutton',
 'jdavid:farfalle.com' => 'David Ruggiero',
+'jdewand:redhat.com' => 'Julie DeWandel',
 'jdike:jdike.wstearns.org' => 'Jeff Dike',
 'jdike:karaya.com' => 'Jeff Dike',
 'jdike:uml.karaya.com' => 'Jeff Dike',
@@ -862,6 +866,7 @@
 'mlang:delysid.org' => 'Mario Lang', # google
 'mlindner:syskonnect.de' => 'Mirko Lindner',
 'mlocke:mvista.com' => 'Montavista Software, Inc.',
+'mmagallo:debian.org' => 'Marcelo E. Magallon',
 'mmcclell:bigfoot.com' => 'Mark McClelland',
 'mochel:geena.pdx.osdl.net' => 'Patrick Mochel',
 'mochel:osdl.org' => 'Patrick Mochel',
@@ -1103,6 +1108,7 @@
 'shmulik.hen:intel.com' => 'Shmulik Hen',
 'silicon:falcon.sch.bme.hu' => 'Szilárd Pásztor', # google
 'simonb:lipsyncpost.co.uk' => 'Simon Burley',
+'skewer:terra.com.br' => 'Marcelo Abreu',
 'skip.ford:verizon.net' => 'Skip Ford',
 'skyrelighten:yahoo.co.kr' => 'Donggyoo Lee',
 'sl:lineo.com' => 'Stuart Lynne',
@@ -1140,6 +1146,7 @@
 'steve:chygwyn.com' => 'Steven Whitehouse',
 'steve:gw.chygwyn.com' => 'Steven Whitehouse',
 'steve:kbuxd.necst.nec.co.jp' => 'Steve Baur',
+'steved:redhat.com' => 'Steve Dickson',
 'stevef:linux.local' => 'Steve French', # guessed
 'stevef:smfhome1.austin.rr.com' => 'Steve French',
 'stevef:stevef95.austin.ibm.com' => 'Steve French',
@@ -1220,6 +1227,7 @@
 'viro:parcelfarce.linux.theplanet.co.uk' => 'Alexander Viro',
 'viro:www.linux.org.uk' => 'Alexander Viro',
 'vnourval:tcs.hut.fi' => 'Ville Nuorvala',		# Can't spell his own login?
+'vnourval:tcs.hut.fi' => 'Ville Nuorvala',		# Can't spell his own login?
 'vnuorval:tcs.hut.fi' => 'Ville Nuorvala',
 'vojta:math.berkeley.edu' => 'Paul Vojta',
 'vojtech:kernel.bkbits.net' => 'Vojtech Pavlik',
@@ -1869,6 +1877,21 @@
 __END__
 # --------------------------------------------------------------------
 # $Log: lk-changelog.pl,v $
+# Revision 0.164  2003/08/27 13:34:29  vita
+# 1 new address
+#
+# Revision 0.163  2003/08/26 10:09:13  vita
+# 4 new addresses; fix Bryan O'Sullivan's regexp
+#
+# Revision 0.162  2003/08/26 00:01:23  emma
+# Fix typo in @addresses_handled_in_regexp, Bryan O'Sullivan's address got hosed.
+#
+# Revision 0.161  2003/08/25 23:56:43  emma
+# Bryan O'Sullivan sent a notice about the other addresses he might be using.
+#
+# Revision 0.160  2003/08/24 10:47:13  emma
+# Merge one mapping from Linus.
+#
 # Revision 0.159  2003/08/22 08:11:41  vita
 # 8 new addresses
 #

##### BKPATCH #####
This BitKeeper patch contains the following changesets:
1.80
## Wrapped with gzip_uu ##


M'XL( /(M3C\  \55:V_;-A3];/V*"Z2 -R162$JR9 UI\]R6M6F+!-T^-%U 
M2]<6%XDT1,IQ ?_X7<EN'"?IWL!L00"I>\ZY/#P2=^"#Q3KM5=*Y0DGK2YW7
MB-X._&BL2WO3:N'G[?#2&!KNV\;B_BW6&LO]X]=T#5:#@3.FM!X5OI<N*V".
MM4U[W _N9]SG&::]R[,?/KPYNO2\@P,X*:2>XA4Z.#CPG*GGLLSMX0SUM%':
M=[74MD(G_<Q4R_O:I6!,T)^+@ VCT5*,AE&T1(%1E(5<CN,DQDQXC]9SN%K'
M-DW $A%R%HUXN"0^SKU3X'["@ 7[+-D7"? D%4D:1;M,I(S!\Z2PRV' O&/X
MCY=PXF40@\8[D#G)68L62!AX-U?C%!<SWWL-U/G(>[]QTQO\S9_G,<F\EYO^
M"U/AH^9M86I7FNFJ]X@G+ YCGBP#'H^BY01'<I+%;"09YG*<?\6I+9;6_80/
M11*%RX"%0=1EXDO%5B3^=3]?B\/C?B@-81(,ER*F6'1IB((G:0C_) TB@H'X
M_^*P\O(=#.J[17L-%A2.+PO]!]DXY1RX=][==^#%>9Y">3O(NNZ)T9^5>W-@
M/A^&T+K8>14##](@3,4(YLI).%O,X(5W'C/B^ C]L;&'WWS\U?^T>^U_^XJ^
M/^204QJO6V/Z</ 2^L?U9ZGAW77_JBE+-9>ZOP>?]KSST1"$UQ*DF:QFH;\!
M_R%V!?FKQ><4)^JT+RM5^]K(*E7:8;D!'=$#>$L/J/A41$EK4#2*6LQO.=[1
MMJ0UYH5T&\A/3:D03O$7>HAE*Y*08P2H*CF596G2',=*:M_4TQ7B0M89.0QG
M/ERL2E:]431;G+W%._IR.ZSK+E#^N-[&'8UK;%:(4'0(AW-\VME5.PVG*KNU
M:P4ANOJY-DT;X=1EUB\:YT_4"O&S*DN$MTT7<-G?Z_5VX(2<<V!G6)90* OF
M3@/%0^E7K9TQI2=J3Q&<*ZN,7@?FV<1TD:%:_C#LWLYC=/  /03.4C9*>7"/
M#K=?E>]@HA:PWNS-7MOUB_.47FS1,Z+GJ2!ZI/VBVN^)C4XT TK#X;W*#;T5
M>8GYC=(W*^*]YS37]3 U#@IC,?>?ZO,'^A&(((V&:;C1?\P*EH(-$K1Q*D.0
M8],X< 6"H5O]X)-!4Y6:%@[&"(U5>OJ,-GN@';;6AG%G[5K[ NLI$6MBDK,9
D4<"D-A6\4;JQ+=O]D9\52*%JJH. 3?)H(G/O=[8'\T%O"   
 

