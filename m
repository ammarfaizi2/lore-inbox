Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319569AbSIMJGs>; Fri, 13 Sep 2002 05:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319570AbSIMJGs>; Fri, 13 Sep 2002 05:06:48 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:26257 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S319569AbSIMJGG>;
	Fri, 13 Sep 2002 05:06:06 -0400
Date: Fri, 13 Sep 2002 11:10:51 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Minor input fixes [5/7]
Message-ID: <20020913111051.A28479@ucw.cz>
References: <20020913110453.A28145@ucw.cz> <20020913110600.B28378@ucw.cz> <20020913110641.C28378@ucw.cz> <20020913111014.A28426@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020913111014.A28426@ucw.cz>; from vojtech@suse.cz on Fri, Sep 13, 2002 at 11:10:14AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.
'bk pull bk://linux-input.bkbits.net/linux-input' should work as well.

===================================================================

ChangeSet@1.593, 2002-09-12 09:05:03+02:00, adam@yggdrasil.com
  The following patch shaves a six bytes from the loaded size
  of pcspkr.o and another 90 elsewhere in the .o file.


 pcspkr.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

===================================================================

diff -Nru a/drivers/input/misc/pcspkr.c b/drivers/input/misc/pcspkr.c
--- a/drivers/input/misc/pcspkr.c	Thu Sep 12 23:38:50 2002
+++ b/drivers/input/misc/pcspkr.c	Thu Sep 12 23:38:50 2002
@@ -22,8 +22,8 @@
 MODULE_DESCRIPTION("PC Speaker beeper driver");
 MODULE_LICENSE("GPL");
 
-static char *pcspkr_name = "PC Speaker";
-static char *pcspkr_phys = "isa0061/input0";
+static char pcspkr_name[] = "PC Speaker";
+static char pcspkr_phys[] = "isa0061/input0";
 static struct input_dev pcspkr_dev;
 
 spinlock_t i8253_beep_lock = SPIN_LOCK_UNLOCKED;

===================================================================

This BitKeeper patch contains the following changesets:
1.593
## Wrapped with gzip_uu ##


begin 664 bkpatch25335
M'XL(`&H)@3T``]V476O;,!2&KZ-?<6@O2^PC^2.V1T:V=&QE@X5TO1IC*+(<
M>[$M(REI4_SCIWR0P58R5GHURS:2]9ZCEW,>?`EW1NILL%$_K!0EN80/RMAL
M8-9&>N+1K>=*N;5?JD;Z1Y6_6/E5VZTM<?LS;D4)&ZE--J!></IBMYW,!O-W
M[^\^O9D3,A[#M.3M4MY*"^,QL4IO>)V;";=EK5K/:MZ:1EKN"=7T)VG/$)D;
M$1T%&,4]C3$<]8+FE/*0RAQ9F,0AT8^3NFK7#\,F3E:>TLO?,Z34Y0ACC/HH
M33$@UT"]*`T`F8^I3QE@FF&487"%+$,$GO-FLETN<\U-5>\\P16%(9*W\++.
MIT3`EU)"H>I:W5?M$KI]^4S)-](`!U,]P&)KW;S0SH5UVEKQ7.9NYU&Z:%5`
M)TRWTIX"WN;N44ZD(460M9'W;BZA:O>13E)4M?3(1XB1NN-GO[I"AO]X$8(<
MR6LX4C$Y,M/GNMKA<$#$;RHC_*-!<2A*PB(:,$J3G@9I&/<1=PTJZ(*.BIS1
M@CY1_;\GW75XA!%B'](DCO;$G0G:,?CBQI^?,76NHX3NN61_4(EGJ&0P9/\/
ME8?>?8:AOC_>#M$S57P&M-<L`D9N6.S>QG);"1`EUT>[WUO>R*_?8`P7LRG<
M=I*OI+YX]92R*[?FH*P,1XSIP2`Z]>DO*$HI5F;=C#%)12)'`?D)`/),9W(%
"````
`
end

-- 
Vojtech Pavlik
SuSE Labs
