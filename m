Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265207AbTLFQlJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 11:41:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265209AbTLFQlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 11:41:09 -0500
Received: from mail.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:40585 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S265207AbTLFQlD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 11:41:03 -0500
MIME-Version: 1.0
To: torvalds@osdl.org, marcelo.tosatti@cyclades.com.br
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Sat_Dec__6_16_41_00_UTC_2003_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20031206164100.52709A1550@merlin.emma.line.org>
Date: Sat,  6 Dec 2003 17:41:00 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use "bk receive" to patch with this mail,
or you can
Pull from: bk://krusty.dt.e-technik.uni-dortmund.de/BK-kernel-tools
or in cases of dire need, you can apply the patch below.

BK: Parent repository is http://bktools.bkbits.net/bktools

Patch description:
ChangeSet@1.103, 2003-12-06 17:40:47+01:00, matthias.andree@gmx.de
  Add two addresses.
  Support parsing the output of bk changes -L and bk changes -R.

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
# shortlog |   12 ++++++++++--
# 1 files changed, 10 insertions(+), 2 deletions(-)

##### GNUPATCH #####
# This is a BitKeeper generated patch for the following project:
# Project Name: BK kernel tools
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.102   -> 1.103  
#	            shortlog	1.75    -> 1.76   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/12/06	matthias.andree@gmx.de	1.103
# Add two addresses.
# Support parsing the output of bk changes -L and bk changes -R.
# --------------------------------------------
#
diff -Nru a/shortlog b/shortlog
--- a/shortlog	Sat Dec  6 17:40:59 2003
+++ b/shortlog	Sat Dec  6 17:41:00 2003
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.201 2003/11/27 10:59:51 vita Exp $
+# $Id: lk-changelog.pl,v 0.203 2003/12/06 16:40:13 emma Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -618,6 +618,7 @@
 'ink:jurassic.park.msu.ru' => 'Ivan Kokshaysky',
 'ink:ru.rmk.(none)' => 'Ivan Kokshaysky',
 'ink:undisclosed.(none)' => 'Ivan Kokshaysky',
+'iod00d:hp.com' => 'Grant Grundler', # lbdb
 'ionut:badula.org' => 'Ion Badulescu',
 'ionut:cs.columbia.edu' => 'Ion Badulescu',
 'ioshadij:hotmail.com' => 'Ishan O. Jayawardena',
@@ -1065,6 +1066,7 @@
 'pavel:janik.cz' => 'Pavel Janík',
 'pavel:suse.cz' => 'Pavel Machek',
 'pavel:ucw.cz' => 'Pavel Machek',
+'pavlin:icir.org' => 'Pavlin Radoslavov', # lbdb
 'pazke:donpac.ru' => 'Andrey Panin',
 'pazke:orbita1.ru' => 'Andrey Panin',
 'pbadari:us.ibm.com' => 'Badari Pulavarty',
@@ -1884,7 +1886,7 @@
       @prolog = ($_);
       undef %$log;
       undef $address;
-    } elsif (m{^<([^>]+)>} or m{^ChangeSet@[0-9.]+,\s*[-0-9:+ ]+,\s*(.*)}) {
+    } elsif (m{^<([^>]+)>} or m{^ChangeSet@[0-9.]+,\s*[-0-9:+ ]+,\s*(\S+)}) {
       # go figure if a line starts with an address, if so, take it
       # resolve the address to a name if possible
       append_item(%$log, @cur); @cur = ();
@@ -2140,6 +2142,12 @@
 __END__
 # --------------------------------------------------------------------
 # $Log: lk-changelog.pl,v $
+# Revision 0.203  2003/12/06 16:40:13  emma
+# Add two addresses, three still nknown since 2.4.23.
+#
+# Revision 0.202  2003/12/06 16:34:30  emma
+# Support bk changes {-L|-R} output format (with +17 -0 after address).
+#
 # Revision 0.201  2003/11/27 10:59:51  vita
 # 3 new addresses (1 new and 2 old from `bk changes` since 2.5.0)
 #

##### BKPATCH #####
This BitKeeper patch contains the following changesets:
1.103
## Wrapped with gzip_uu ##


M'XL( )P&TC\  ]55VV[B,!!]KK]B)"H!"PFV<X-H0;VJBUII*ZH^]2*9Q)"(
M)(YB<UDU_/L:6.A"6ZWV\K*.E<2C\9R9,R=.!>XE+_RCE"D5Q4R:+ L+SE$%
MO@BI_*-QNC##U7(@A%ZVY%3RUH07&4]:9]=Z&IN%H81()-*.MTP%$<QX(?TC
M8EH[B_J6<_]H<'EU?W,Z0*C;A?.(96-^QQ5TNTB)8L:24)[D/!M/X\Q4!<MD
MRA4S Y&6.]^28DSU1:B%7:=3TH[K."6GW'$"F["AU_9X0-%!/2>;.O;#6(10
MCQ!,;:?4\3!!%T!,@BW 5HO0%G:!>+Z-?=MK8.)C#.]'A08! Z,S^,<UG*, 
M3L,0U%P "S6@E%R:VG@WS7-1*,A9(>-L#"KB(*8JGRH0(QA.(%@C23!N0&>Z
M9QF8Z!H()13=OC8 &;\Y$,(,H]YKQ9%(^4&Y,M(Y)F*\J=8A;>S9'FF7%O$Z
M3CGB'38*/-QAF(=L&'[ [5X42S?)):Z-;;>T<:>#US+:>NRIZ*_S^4A!^_EL
M!627Q*.XO1:0Y[[1C_LK_6 PZ/\DH W[7\$HYHO5-!9:3EMJ_D!-%X0 0?WU
MO0+'_="'9&)L,'5$,T^:,\ FU=_FBO<MN^Z*76(!3U,&EXL<CE'?I5@'J<8B
MQ#CTHWS%7!6Z/:A>:3(57!73+$QX46U"!9)A.-2PV/56>W(V2^+,CX.X,$4Q
MWNRZ71MAP$(A$S83L]>-%Z3=]M9Y;YZ@QQ)X(N,1U-*7Y\^UA^?>4Z/>6X(H
M0!MV#3QYP$;'?&HT'^6G!T._^PW8K&J/=XWZL@XOJ$^)3<%=G;U\%LM89#\8
M>)>"-0?:]TV_F[J[6FL@59PDD$TR,<] =SW@0$W;I):)*H<8]!##LGT+[S"V
M\OE)%B_&36D,EEL5C42AM0ZU>:PB+6]/GX_ 1HH7V[SJ*]3=OR&(>#"1T[3+
/G9"'!#/T'1#_P["8!@  
 

