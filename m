Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261742AbSKUBPI>; Wed, 20 Nov 2002 20:15:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261721AbSKUBPI>; Wed, 20 Nov 2002 20:15:08 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:37135 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S261742AbSKUBPG>; Wed, 20 Nov 2002 20:15:06 -0500
Date: Wed, 20 Nov 2002 23:22:05 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] i20: fix up header cleanups: add include <linux/interrupt.h>
Message-ID: <20021121012205.GG28717@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

	Please pull from:

master.kernel.org:/home/acme/BK/includes-2.5

	Now there are three outstanding changesets.

- Arnaldo

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.924, 2002-11-20 23:15:34-02:00, acme@conectiva.com.br
  i2o: fix up header cleanups: add include <linux/interrupt.h>
  
  and also makes a var go to .bss...


 i2o_pci.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)


diff -Nru a/drivers/message/i2o/i2o_pci.c b/drivers/message/i2o/i2o_pci.c
--- a/drivers/message/i2o/i2o_pci.c	Wed Nov 20 23:19:32 2002
+++ b/drivers/message/i2o/i2o_pci.c	Wed Nov 20 23:19:32 2002
@@ -27,14 +27,16 @@
 #include <linux/i2o.h>
 #include <linux/errno.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/slab.h>
+
 #include <asm/io.h>
 
 #ifdef CONFIG_MTRR
 #include <asm/mtrr.h>
 #endif // CONFIG_MTRR
 
-static int dpt = 0;
+static int dpt;
 
 
 /**

===================================================================


This BitKeeper patch contains the following changesets:
1.924
## Wrapped with gzip_uu ##


begin 664 bkpatch4168
M'XL(`*0TW#T``]6476O;,!2&KZ-?<:"7(\HY\E?B+25K.[;0P4I'[P9#D=78
MU+:,)*<M^,=734<ZMI#NZV:6+(./='S.^S[X"*Z<MOE(JD:S(_A@G,]'RK1:
M^6HCN3(-7]D0N#0F!":E:?3DY'Q2M:KN"^W&@B<LA"^D5R5LM'7YB'BT>^/O
M.YV/+M^]O_KX]I*Q^1Q.2]FN]6?M83YGWMB-K`NWD+ZL3<N]E:UKM-]^>-AM
M'02B"".A+,(D'2C%.!L4%40R)EV@B*=IS&[K:E&:VC3&=N7]GA1$@I`PCFD0
M,<XB=@;$9R(&%!.BB4`044Y)'L5C%#DB/*JR^%$->$4P1G8"_[;Z4Z:@$B:'
MZ^H.^@Y*+0MM0=5:MGWG<I!%`=]TAS=UU?9WP0:OK>T[S\OC<#Q,V18@:V>@
MD3?:@82-M+`VH5;@*^<XY^P<A,A$RBZ>O6#CW[P80XGL^`4)"EL](C$);3W>
M7SM5<?6='#'2=,`,LW10XII6@E(EQ"JEV?5^Z7<9&^V<7.L]F9\\IB2B(<(X
MB;?0'3SV,HA_T0>3M6P7E37M6GK-W6W(JR7?VL>-7?/^YA>:PDPDE(@LF@XB
MFU&Z!9?P)V[I,+<1C.E_YO;)T$\PMK?;&3B\..SM'X"]%#,@=G2HXF6$8<L7
J=A9EX;G<KLY+7P4E6@]%YU\__Q15J=6-ZYOYC`BG68'L`7],P]AT!0``
`
end
