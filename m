Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261524AbSJIK4S>; Wed, 9 Oct 2002 06:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261523AbSJIK4S>; Wed, 9 Oct 2002 06:56:18 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:8320 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S261524AbSJIK4P>;
	Wed, 9 Oct 2002 06:56:15 -0400
Date: Wed, 9 Oct 2002 13:01:52 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Input - Extra escaped semicolon [3/3]
Message-ID: <20021009130152.C367@ucw.cz>
References: <20021009101256.A10748@ucw.cz> <20021009130035.A367@ucw.cz> <20021009130123.B367@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021009130123.B367@ucw.cz>; from vojtech@suse.cz on Wed, Oct 09, 2002 at 01:01:23PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.
'bk pull bk://linux-input.bkbits.net/linux-input' should work as well.

===================================================================

ChangeSet@1.720, 2002-10-09 12:56:57+02:00, vojtech@suse.cz
  Fix a ; in atkbd.c that somehow got into the last cset.


 atkbd.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

===================================================================

diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c	Wed Oct  9 13:00:35 2002
+++ b/drivers/input/keyboard/atkbd.c	Wed Oct  9 13:00:35 2002
@@ -280,7 +280,7 @@
 				param[1] = (test_bit(LED_COMPOSE, dev->led) ? 0x01 : 0)
 					 | (test_bit(LED_SLEEP,   dev->led) ? 0x02 : 0)
 					 | (test_bit(LED_SUSPEND, dev->led) ? 0x04 : 0)
-				         | (test_bit(LED_MISC,    dev->led) ? 0x10 : 0);
+				         | (test_bit(LED_MISC,    dev->led) ? 0x10 : 0)
 				         | (test_bit(LED_MUTE,    dev->led) ? 0x20 : 0);
 				atkbd_command(atkbd, param, ATKBD_CMD_EX_SETLEDS);
 			}

===================================================================

This BitKeeper patch contains the following changesets:
1.720
## Wrapped with gzip_uu ##


begin 664 bkpatch516
M'XL(`%,,I#T``[64;6O;,!#'7T>?XJ!O6KK8=_*#;(]TW=)N*^M82.GK(LM:
M[.5!P5*2=OC#SWE8"BETW5A/`B.=).[_OQ\^@ENKZZRS-#^<5B4[@L_&NJQC
M%U9[ZF>['AK3KOW23+6_.^7G8[^:S1>.M?F!=*J$I:YMUB$OV.^XA[G..L/+
M3[?7[X>,]7K0+^5LI&^T@UZ/.5,OY:2PY]*5$S/S7"UG=JJ=])29-ONC#4?D
M[8A(!!C%#<48BD91021#T@7R,(E#MBOL?%?VP7U"3`G#%.,&190(=@'D"8Z`
MW"?T,07B611GD3A%GB'"P7-P2M!%]@'^;]%]IN!C=0\2WD(U`^G&>>$I<*5T
M8%N[2[."D7%MSIEV5\-$6@?*:N>Q+R"B-&"#1U-9]R^#,93(SO9BW:J:5*/2
M>0NU6GM8U-6ZJ]M.^V/]D!M9%_ZNS*U&@0$%F(384)H0-7E>I)JC+BB(4Q$<
M&OF2-[?-BN((FY`H"3;H/']OS=,KJGA"UXM5M,A1JX*'?(,<#Y\0A\\01Z]*
MW`8S;96<ZV+-T];L;]"M5YO9`C+X@^__@-P%3P(@=K7]=-J`W]'`L=/6W>65
M.[Z^O+C[>G73?[-.%'K9/9OHX@3>`=X30@9X\OCK4:568[N8]H2@(*+D._L%
(+'O6U]4$````
`
end
