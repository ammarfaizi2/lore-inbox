Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265315AbUASRBu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 12:01:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265331AbUASRBu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 12:01:50 -0500
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:5327 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S265315AbUASRBq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 12:01:46 -0500
MIME-Version: 1.0
To: torvalds@osdl.org, marcelo.tosatti@cyclades.com.br
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Mon_Jan_19_17_01_43_UTC_2004_0@merlin.emma.line.org>
Content-Type: text/plain; charset=US-ASCII
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 7BIT
Message-Id: <20040119170143.307B1A0FB3@merlin.emma.line.org>
Date: Mon, 19 Jan 2004 18:01:43 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use "bk receive" to patch with this mail,
or you can
Pull from: bk://krusty.dt.e-technik.uni-dortmund.de/BK-kernel-tools
or in cases of dire need, you can apply the patch below.

BK: Parent repository is http://bktools.bkbits.net/bktools

Patch description:
ChangeSet@1.115, 2004-01-19 18:01:19+01:00, matthias.andree@gmx.de
  Three new addresses. (vita)
  Convert Chas Williams' addresses to a regexp. (vita)

Previous unpulled changeset information omitted.

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
# shortlog |   14 +++++++++-----
# 1 files changed, 9 insertions(+), 5 deletions(-)

##### GNUPATCH #####
# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/01/19 18:01:19+01:00 matthias.andree@gmx.de 
#   Three new addresses. (vita)
#   Convert Chas Williams' addresses to a regexp. (vita)
# 
# shortlog
#   2004/01/19 18:01:18+01:00 matthias.andree@gmx.de +9 -5
#   Three new addresses. (vita)
#   Convert Chas Williams' addresses to a regexp. (vita)
# 
diff -Nru a/shortlog b/shortlog
--- a/shortlog	Mon Jan 19 18:01:42 2004
+++ b/shortlog	Mon Jan 19 18:01:42 2004
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.216 2004/01/16 14:37:56 emma Exp $
+# $Id: lk-changelog.pl,v 0.217 2004/01/19 12:15:23 vita Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -72,6 +72,7 @@
 my @addrregexps = (
 [ 'alan@[^.]+\.swansea\.linux\.org\.uk' => 'Alan Cox', ],
 [ 'bos@([^.]+\.)?serpentine\.com' => 'Bryan O\'Sullivan', ],
+[ 'chas@([^.]+\.)*nrl\.navy\.mil' => 'Chas Williams', ],
 [ 'davem@[^.]+\.ninka\.net' => 'David S. Miller', ],
 [ 'kuznet@[^.]+\.inr\.ac\.ru' => 'Alexey Kuznetsov', ],
 [ 'torvalds@([^.]+\.)?transmeta\.com' => 'Linus Torvalds', ],
@@ -100,6 +101,11 @@
 'alan:irongate.swansea.linux.org.uk' => 'Alan Cox',
 'bos:camp4.serpentine.com' => 'Bryan O\'Sullivan',
 'bos:serpentine.com' => 'Bryan O\'Sullivan',
+'chas:cmd.nrl.navy.mil' => 'Chas Williams',
+'chas:cmf.nrl.navy.mil' => 'Chas Williams',
+'chas:locutus.cmf.nrl.navy.mil' => 'Chas Williams',
+'chas:nrl.navy.mil' => 'Chas Williams',
+'chas:relax.cmf.nrl.navy.mil' => 'Chas Williams',
 'davem:cheetah.ninka.net' => 'David S. Miller',
 'davem:nuts.ninka.net' => 'David S. Miller',
 'davem:pizda.ninka.net' => 'David S. Miller', # guessed
@@ -333,10 +339,6 @@
 'chan:aleph1.co.uk' => 'Tak-Shing Chan',
 'char:cmf.nrl.navy.mil' => 'Chas Williams', # typo ???
 'charles.white:hp.com' => 'Charles White',
-'chas:cmd.nrl.navy.mil' => 'Chas Williams',
-'chas:cmf.nrl.navy.mil' => 'Chas Williams',
-'chas:locutus.cmf.nrl.navy.mil' => 'Chas Williams',
-'chas:nrl.navy.mil' => 'Chas Williams',
 'chessman:tux.org' => 'Samuel S. Chessman',
 'chip:pobox.com' => 'Chip Salzenberg', # lbdb
 'chris:qwirx.com' => 'Chris Wilson',
@@ -496,6 +498,7 @@
 'eli.carter:com.rmk.(none)' => 'Eli Carter',
 'eli.kupermann:intel.com' => 'Eli Kupermann',
 'emann:mrv.com' => 'Eran Mann',
+'emcnabb:cs.byu.edu' => 'Evan N. McNabb',
 'engebret:au1.ibm.com' => 'David Engebretsen',
 'engebret:brule.rchland.ibm.com' => 'David Engebretsen',
 'engebret:us.ibm.com' => 'David Engebretsen',
@@ -1087,6 +1090,7 @@
 'paschal:rcsis.com' => 'David Paschal',
 'pasky:ucw.cz' => 'Petr Baudis',
 'patch:luckynet.dynu.com' => '"Lightweight Patch Manager"', # lbdb
+'patmans:ibm.com' => 'Patrick Mansfield',
 'patmans:us.ibm.com' => 'Patrick Mansfield',
 'patrick:dreker.de' => 'Patrick Dreker', # lbdb
 'paubert:iram.es' => 'Gabriel Paubert',

##### BKPATCH #####
This BitKeeper patch contains the following changesets:
1.115
## Wrapped with gzip_uu ##


M'XL( '8-#$   ]556T_;,!A]KG_%)Q6I,(AKY]+$D8H8%VT5@R$VM =@DNNX
M3=1<JM@I1<J/GY.J165#@VTO2R)'CL_Y_)V3HZ0+-TJ682?C6L<)5YCG42DE
MZL+'0NFP,\V6.&JFUT5AIGU5*=F?R3*7:?_XW%S6:F+IHD@5,L KKD4,"UFJ
ML$.QLWFB'^<R[%R??;CY]/X:H>$03F*>3^47J6$X1+HH%SR-U-%<YM,JR;$N
M>:XRJ3D6159OL+5-B&U.:CMDX+':9@//JZ4M/4^XE(_]P)?"1L_T'*UT;)=Q
M":4#ZCK,9K6I1P;H%"BFU /B]@GM4P8T" D-*=LW(R'PZZJP3\$BZ!C^L883
M).!K;/:!7#X C\R62DF%87>1:+YG5D^*W!BM&R<5?$O2-.&9ZCU!34? H913
MN9QO:.?0:KUZ\A]9;SP0(IR@PR?!<9')9VI57)0Z+:8KL1X-B._Z-*@=ZC.O
MGDC&)\(GC!,9\7'T@K5;59KWQ:AOQJ!N;GZ;HC5B*T1_W<]+ 7K>SRH_@<F/
M9]MM?H+@I_@$OXD/ \O[G^+3>O\9K/)AV5S6TH1I;<P?9.F44J!HU(Y=V!E%
M(:0S2[1R344\3P\60+!-?6A<7WMKA]0+;0>:MN!L.8<=-/)=4^,6>H:LCG9O
MO^/[_3N\]RXOTSN<\\7C'<Z2M ?#0^AMBSZ ^P/3 K'!0RT[%%F$#:^EO<C:
M8">OQJ:%J'2E\%LXK\65,N7+5U8^=9P!N&CDLL!XUI.9R/EX' J%QX\5EE&U
MHITM> Z7&"[$I5GNM28%K&',N<Y,/L-DG#7Y7,'-M[Y,Q PNS,HDD6ED&)M?
7@(BEF*DJ&TZ8B"*S,?H![>WZW'\&    
 

