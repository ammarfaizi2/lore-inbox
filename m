Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265894AbSKOIDT>; Fri, 15 Nov 2002 03:03:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265898AbSKOIDT>; Fri, 15 Nov 2002 03:03:19 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:43137 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S265894AbSKOICg>;
	Fri, 15 Nov 2002 03:02:36 -0500
Date: Fri, 15 Nov 2002 09:09:22 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [patch] Input - Add a missing \n [2/13]
Message-ID: <20021115090922.A16779@ucw.cz>
References: <20021115090818.A16761@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021115090818.A16761@ucw.cz>; from vojtech@suse.cz on Fri, Nov 15, 2002 at 09:08:18AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.
'bk pull bk://linux-input.bkbits.net/linux-input' should work as well.

===================================================================

ChangeSet@1.781.10.3, 2002-10-13 14:53:42+02:00, kronos@kronoz.cjb.net
  I found a missing '\n' in serio.c:118. This prevents the next printk to
  be interpreted correctly.


 serio.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

===================================================================

diff -Nru a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
--- a/drivers/input/serio/serio.c	Fri Nov 15 08:32:00 2002
+++ b/drivers/input/serio/serio.c	Fri Nov 15 08:32:00 2002
@@ -115,7 +115,7 @@
 			refrigerator(PF_IOTHREAD);
 	} while (!signal_pending(current));
 
-	printk(KERN_DEBUG "serio: kseriod exiting");
+	printk(KERN_DEBUG "serio: kseriod exiting\n");
 
 	unlock_kernel();
 	complete_and_exit(&serio_exited, 0);

===================================================================

This BitKeeper patch contains the following changesets:
1.781.10.3
## Wrapped with gzip_uu ##


begin 664 bkpatch16554
M'XL(`/"BU#T``]5474_;,!1]KG_%%3RP">'XQDF:9NK4\2&&F#;4C3>DR74,
M"6EL9+OE0_GQ,VD%&YI@7R]+(EW9N3XZQ^?8FW#JE"T&2W/IE:S()KPWSA<#
MMW"*RKLPGAH3QE%E6A6MNZ)9$]7Z:N%)^'\BO*Q@J:PK!DCYPXR_O5+%8'IP
M>/KAW920\1CV*J$OU&?E83PFWMBEF)=N(GPU-YIZ*[1KE1=4FK9[:.UBQN+P
MICCD+,TZS%@R["26B")!5;(XR;.$V+:9"-O2>:T7-]38"[IHGH`@0\YRGB+K
MTCC-4K(/2(<Y4F24`XLC9!%RP*1(>9'$VRPN&(/&&FW<I"]W5%[.J`[\MQ%V
M&-F%?RMBCT@X@G.ST"4(:&OG:GT!6V=Z"VH-P:;:4%D@YA2^5+6#*ZN62GL'
MOE*@U8T/,[7V3:`5D&8JK/+*ABZO2I#&6B7]_):28TAY8$).'ATA.[_Y$,($
M(V]?V('2UO?!B&0E;'1I;IVO91.ME7RW*PEC:<>2;)1U2HIT-E+G93Y$I<3/
M#7@`[E.X`OP!]MYLC%/.AQWGF.1]_IY9]'(B_UX*69^>R?IL_8H([(&QX_$H
MR?K$8OPTJWSX8E;Q/\[JRK]/L&.O^R]D[^0Y*_\@RON!)R`Y6I7!BMFKXX/I
MQZ_[![NGA[#18Q?0]+4$=5/[H/=,;[Q^\W@'RDK)QBW:L8I3D8_*&?D&\]9Z
%-EX%````
`
end
