Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261801AbTJHWAM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 18:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbTJHWAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 18:00:11 -0400
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:18390 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261801AbTJHV75 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 17:59:57 -0400
MIME-Version: 1.0
To: torvalds@osdl.org, marcelo.tosatti@cyclades.com.br
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Wed_Oct__8_21_59_53_UTC_2003_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20031008215953.7DC338D6AF@merlin.emma.line.org>
Date: Wed,  8 Oct 2003 23:59:53 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use "bk receive" to patch with this mail,
or you can pull from bk://krusty.dt.e-technik.uni-dortmund.de  (NOTE: no
trailing slash) or in cases of dire need, you can apply the patch below.

BK: Parent repository is bk://kernel.bkbits.net/torvalds/tools/

Patch description:
ChangeSet@1.91, 2003-10-08 23:58:48+02:00, matthias.andree@gmx.de
  Update to upstream version 0.187, reconciling differences between downstream
  and upstream updates.

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
# shortlog |   47 +++++++++++++++++++++++++++++++++----------
# 1 files changed, 37 insertions(+), 10 deletions(-)

##### GNUPATCH #####
# This is a BitKeeper generated patch for the following project:
# Project Name: BK kernel tools
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.90    -> 1.91   
#	            shortlog	1.63    -> 1.64   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/10/08	matthias.andree@gmx.de	1.91
# Update to upstream version 0.187, reconciling differences between downstream
# and upstream updates.
# --------------------------------------------
#
diff -Nru a/shortlog b/shortlog
--- a/shortlog	Wed Oct  8 23:59:53 2003
+++ b/shortlog	Wed Oct  8 23:59:53 2003
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.180 2003/09/22 14:13:31 vita Exp $
+# $Id: lk-changelog.pl,v 0.187 2003/10/08 21:56:22 emma Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -130,7 +130,7 @@
 'ac9410:attbi.com' => 'Albert Cranford',
 'ac9410:bellsouth.net' => 'Albert Cranford',
 'acher:in.tum.de' => 'Georg Acher',
-'achim_leubner:adaptec.com' => 'Achim Laubner',
+'achim_leubner:adaptec.com' => 'Achim Leubner',
 'achirica:telefonica.net' => 'Javier Achirica',
 'achirica:ttd.net' => 'Javier Achirica',
 'acme:allegro.kerneljanitors.org' => 'Arnaldo Carvalho de Melo',
@@ -166,9 +166,9 @@
 'ajoshi:kernel.crashing.org' => 'Ani Joshi',
 'ajoshi:shell.unixbox.com' => 'Ani Joshi',
 'ak:colin.muc.de' => 'Andi Kleen',
+'ak:colin2.muc.de' => 'Andi Kleen',
 'ak:muc.de' => 'Andi Kleen',
 'ak:suse.de' => 'Andi Kleen',
-'ak:colin2.muc.de' => 'Andi Kleen',
 'akpm:digeo.com' => 'Andrew Morton',
 'akpm:org.rmk.(none)' => 'Andrew Morton',
 'akpm:osdl.org' => 'Andrew Morton', # guessed
@@ -196,7 +196,7 @@
 'ambx1:com.rmk.(none)' => 'Adam Belay',
 'ambx1:neo.rr.com' => 'Adam Belay',
 'amir.noam:intel.com' => 'Amir Noam',
-'amn3s1a:ono.com' => 'Amn3S1A',
+'amn3s1a:ono.com' => 'Miguel A. Fosas',
 'amunoz:vmware.com' => 'Alberto Munoz',
 'andersen:codepoet.org' => 'Erik Andersen',
 'andersg:0x63.nu' => 'Anders Gustafsson',
@@ -224,7 +224,7 @@
 'arndb:de.ibm.com' => 'Arnd Bergmann',
 'arndt:lin02384n012.mc.schoenewald.de' => 'Arndt Schoenewald',
 'arun.sharma:intel.com' => 'Arun Sharma',
-'arvidjaar:mail.ru' => 'Andrej Borsenkow',
+'arvidjaar:mail.ru' => 'Andrey Borzenkov',
 'arzie:dds.nl' => 'Robert Zwerus',
 'aschultz:warp10.net' => 'Andreas Schultz',
 'asit.k.mallick:intel.com' => 'Asit K. Mallick', # by Kristian Peters
@@ -270,8 +270,8 @@
 'bhavesh:avaya.com' => 'Bhavesh P. Davda',
 'bheilbrun:paypal.com' => 'Brad Heilbrun', # by himself
 'bjorn.andersson:erc.ericsson.se' => 'Björn Andersson', # google, guessed ö
-'bjorn.helgaas:hp.com' => 'Bjorn Helgaas',
 'bjorn.helgaas:com.rmk.(none)' => 'Bjorn Helgaas',
+'bjorn.helgaas:hp.com' => 'Bjorn Helgaas',
 'bjorn.wesen:axis.com' => 'Bjorn Wesen',
 'bjorn_helgaas:hp.com' => 'Bjorn Helgaas',
 'bk:suse.de' => 'Bernhard Kaindl',
@@ -415,6 +415,7 @@
 'devel:brodo.de' => 'Dominik Brodowski',
 'devenyga:mcmaster.ca' => 'Gabriel Devenyi',
 'devik:cdi.cz' => 'Martin Devera',
+'dfages:arkoon.net' => 'Daniel Fages',
 'dgibson:samba.org' => 'David Gibson',
 'dhinds:sonic.net' => 'David Hinds', # google
 'dhollis:davehollis.com' => 'David T. Hollis',
@@ -862,6 +863,8 @@
 'marcel:holtmann.org' => 'Marcel Holtmann', # sent by himself
 'marcelo.tosatti:cyclades.com.br' => 'Marcelo Tosatti',
 'marcelo:conectiva.com.br' => 'Marcelo Tosatti',
+'marcelo:dhcp-103.cyclades.de' => 'Marcelo Tosatti',
+'marcelo:dmt.cyclades' => 'Marcelo Tosatti',
 'marcelo:freak.distro.conectiva' => 'Marcelo Tosatti', # guessed
 'marcelo:logos.cnet' => 'Marcelo Tosatti', # guessed
 'marcelo:plucky.distro.conectiva' => 'Marcelo Tosatti',
@@ -902,7 +905,7 @@
 'mdharm:one-eyed-alien.net' => 'Matthew Dharm',
 'mdiehl:mdiehl.de' => 'Martin Diehl',
 'mdomsch:dell.com' => 'Matt Domsch', # lbdb
-'mds:paradyne.com' => 'Mark Studebaker',
+'mds:paradyne.com' => 'Mark D. Studebaker',
 'mec:shout.net' => 'Michael Elizabeth Chastain',
 'meissner:suse.de' => 'Marcus Meissner',
 'mgreer:mivsta.com' => 'Mark A. Greer', # typo
@@ -945,9 +948,11 @@
 'mochel:bambi.(none)' => 'Patrick Mochel',
 'mochel:geena.pdx.osdl.net' => 'Patrick Mochel',
 'mochel:hera.kernel.org' => 'Patrick Mochel',
+'mochel:kernel.bkbits.net' => 'Patrick Mochel',
 'mochel:osdl.org' => 'Patrick Mochel',
 'mochel:segfault.osdl.org' => 'Patrick Mochel',
 'mochel:segfault.osdlab.org' => 'Patrick Mochel',
+'moilanen:austin.ibm.com' => 'Jake Moilanen',
 'mort:green.i.bork.org' => 'Martin Hicks',
 'mort:wildopensource.com' => 'Martin Hicks',
 'mostrows:speakeasy.net' => 'Michal Ostrowski',
@@ -1061,6 +1066,7 @@
 'petr:vandrovec.name' => 'Petr Vandrovec',
 'petri.koistinen:iki.fi' => 'Petri Koistinen',
 'petrides:redhat.com' => 'Ernie Petrides',
+'pfg:sgi.com' => 'Pat Gefre',
 'philipp:void.at' => 'Philipp Friedrich',
 'phillim2:comcast.net' => 'Mike Phillips',
 'piggin:cyberone.com.au' => 'Nick Piggin',
@@ -1155,7 +1161,7 @@
 'rth:tigger.twiddle.net' => 'Richard Henderson',
 'rth:twiddle.net' => 'Richard Henderson',
 'rth:vsop.sfbay.redhat.com' => 'Richard Henderson',
-'rtjohnso:eecs.berkeley.edu' => 'Robert Johnson',
+'rtjohnso:eecs.berkeley.edu' => 'Robert T. Johnson',
 'rui.sousa:laposte.net' => 'Rui Sousa',
 'russell_d_cagle:mindspring.com' => 'Russell Cagle', # google
 'rusty:linux.co.intel.com' => 'Rusty Lynch',
@@ -1201,7 +1207,7 @@
 'shaggy:austin.ibm.com' => 'Dave Kleikamp',
 'shaggy:kleikamp.austin.ibm.com' => 'Dave Kleikamp',
 'shaggy:shaggy.austin.ibm.com' => 'Dave Kleikamp', # lbdb
-'sheilds:msrl.com' => 'Michael Shields',
+'sheilds:msrl.com' => 'Michael Shields', # typo
 'shemminger:osdl.org' => 'Stephen Hemminger',
 'shields:msrl.com' => 'Michael Shields',
 'shingchuang:via.com.tw' => 'Shing Chuang',
@@ -1338,7 +1344,7 @@
 'vherva:niksula.hut.fi' => 'Ville Herva',
 'vinay-rc:naturesoft.net' => 'Vinay K. Nallamothu',
 'vinay.nallamothu:gsecone.com' => 'Vinay K. Nallamothu',
-'vinsci:floss.(none)' => 'Leonard Norrgard',  # ????
+'vinsci:floss.(none)' => 'Leonard Norrgard',
 'viro:math.psu.edu' => 'Alexander Viro',
 'viro:parcelfarce.linux.theplanet.co.uk' => 'Alexander Viro',
 'viro:www.linux.org.uk' => 'Alexander Viro',
@@ -2091,6 +2097,27 @@
 __END__
 # --------------------------------------------------------------------
 # $Log: lk-changelog.pl,v $
+# Revision 0.187  2003/10/08 21:56:22  emma
+# Merge Linus' changes.
+#
+# Revision 0.186  2003/10/08 11:11:02  vita
+# 9 new addresses
+#
+# Revision 0.185  2003/10/02 12:22:33  vita
+# 7 new addresses
+#
+# Revision 0.184  2003/09/30 10:10:31  vita
+# 4 new addresses
+#
+# Revision 0.183  2003/09/29 12:26:43  vita
+# Merge Linus' changes
+#
+# Revision 0.182  2003/09/24 11:08:03  vita
+# 1 new address
+#
+# Revision 0.181  2003/09/23 13:09:36  vita
+# 2 new addresses
+#
 # Revision 0.180  2003/09/22 14:13:31  vita
 # 8 new addresses
 #

##### BKPATCH #####
This BitKeeper patch contains the following changesets:
1.91
## Wrapped with gzip_uu ##


M'XL( -F(A#\  ]56;6_;-A#^'/V* U+ *QHK)"59$H$4;>J^)UN1-I\'6CK;
MJB72(&4G&?SC=Z(2*VE:%-WV9;9@6N(]S_'NGB-U")<.K3QH5-LN*^5"I4N+
M&!S".^-:>;!HKL.RN[TPAFZ/W<;A\0JMQOKX]"-=X_YFW!I3NX ,/ZFV6,(6
MK9,'/(SV3]J;-<J#B]=O+\]>7@3!R0F\6BJ]P,_8PLE)T!J[577I7JQ1+S:5
M#ENKM&NP56%AFMW>=B<8$_3E(F*3)-^)?)(D.Q28)$7,U2S-4BS$0+<T#8;&
ME75H[.(A3<09RWC.<\%VQ#?)@RGP,.? HF/.CED&(I)))N/L&1.2,?@F22_Z
MY, S#F,6G,)_',*KH(#+=:E:)&;8K%UK434^LY71P$*>I4=@L3"ZJ.I*+Z"L
MYG.TJ MT,,/V"E%#::YTCR0Z6O= M/'<+@P^ A<B#CX-!0G&O_@) J98\!P>
MIOUA_&YI;%N;11]^PC.6QBG/=A%/\V0WQUS-BY3EBF&I9N4/DOV Q1=0\"2+
MLUV<3G+N975G\4!5_WH]/U+4H_7<"BK)TRCR@IK$ORRH*(4Q_W]+JJ_''S"V
M5]?=-;XF@=TEZQ_H:\HY\."]_SV$)^]+"?5J7/@$$&.XKH^V?0#05>(NWUPF
M$RD$8-,H>'V]AB?$%$6>R@\C52RKYL\:-S--&Z$JU;K%HLON"$Z>P^AE-PUG
M_?3HB&"3S,-6LC"4(A$VFX**=FNMRPH^UI0E,IWRM%OME.>Y]^>'D6ITY+B2
M1IO!RWFUV& -+T-X8YQR'5B(M$/UPTC9;55^5<K*1E5U:#=[?Q9OX-38OU"O
MS-8#4Q^>2.,../MJK Z76"^4<G*Y'GR>=C/PKI_I(HNY=U7.U0*=5'9EC XU
MMKWY5.F*EOBFF^RL,]*U"$:-L@450);+8DV:C<+BIJA522*XR\EY;P%?*+*V
MK0@[@)IV;_\CXVG.DBZ>?A@UI9-K955YH_%>_FBU, WA<[LI<:96?:GRV ?4
MF(+BE_U!%<Y6LZIU0UQT.MFJ6,&YM_*PA/6PJE8:M50;UU+K5;-F</B!?!"D
MM_"R8!,OI_5\(=VB&BR)'][BW*)7!&U6O8S].++M5[/4SDC$PH4SM"NL\2;$
M\K:^%X:>M? EA _>KI>58+$GZ<>16V)%>X1LG*WO2XJ:@PKV>4EE*ZED<-B=
MP:;3?]SW4C^.MI5V127GM7$N_$T;C4][BC,T6MD2?C?6+NA/%Z=@>41MU;T1
MX+8:M@WX;MOYOB/;<[0+A+-*;ZC.?=/2+G'X+<OD 0OGDBY&+-NJ[5ART'@%
MJB3-.X?N,3ZYAQ=TJM$2)'7Y'3[]&3Z^Q;/\."(-,$E7Q/?X^&?X:,"+W/N?
MR'CP_[TL/"81]TCB+@DLDVP@X?<7\1C-[Z%)D)%DN8PF>[1X%,+^!8WD7ZS<
2ICD1>81E$HO@;Y4\=:<="@  
 

