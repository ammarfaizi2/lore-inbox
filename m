Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267563AbSKQTeg>; Sun, 17 Nov 2002 14:34:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267564AbSKQTeg>; Sun, 17 Nov 2002 14:34:36 -0500
Received: from 2-023.ctame701-2.telepar.net.br ([200.181.170.23]:42767 "EHLO
	brinquendo.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S267563AbSKQTef>; Sun, 17 Nov 2002 14:34:35 -0500
Date: Sun, 17 Nov 2002 17:41:17 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] tp3870i: fixup after header files cleanups: add include <linux/interrupt.h>
Message-ID: <20021117194117.GR28227@conectiva.com.br>
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

	Now there are two outstanding changesets.

- Arnaldo

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.858, 2002-11-17 17:34:21-02:00, acme@conectiva.com.br
  o tp3870i: fixup after header files cleanups: add include <linux/interrupt.h>
  
    request_irq/free_irq are now in linux/interrupt.h


 tp3780i.c |    1 +
 1 files changed, 1 insertion(+)


diff -Nru a/drivers/char/mwave/tp3780i.c b/drivers/char/mwave/tp3780i.c
--- a/drivers/char/mwave/tp3780i.c	Sun Nov 17 17:35:10 2002
+++ b/drivers/char/mwave/tp3780i.c	Sun Nov 17 17:35:10 2002
@@ -47,6 +47,7 @@
 */
 
 #include <linux/version.h>
+#include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/ptrace.h>
 #include <linux/ioport.h>

===================================================================


This BitKeeper patch contains the following changesets:
1.858
## Wrapped with gzip_uu ##


begin 664 bkpatch23775
M'XL(`&[OUST``^6476O;,!2&KZ-?<2"7([:._"';+*5K-[;1P4)&KX<F'\]F
M_JHLIQWXQU=.1P99R-CHKF8+V_CHO/:K]T%+N!W(9`NE&V)+>-<--EOHKB5M
MJYWR=-=X7XPK;+O.%?RR:\B_NO&K5M=C3L-*>!%SY8VRNH0=F2%;H!<<WMCO
M/66+[9NWMQ]>;1E;K^&Z5.U7^D06UFMF.[-3=3Y<*EO67>M9H]JA(;O_\'28
M.@G.A3LCE`&/X@EC'LI)8XZH0J2<BS")0S9[N#S^]R,51)28BD2(B4=!*-AK
M0"^)$N#"1_11`LHL"#.!*RXRSN&D*+Q`6'%V!<]KX)IIZ,#V02)YE4%1/8P]
MJ,*2@9)4[FY%5=,`NB;5COV0@<IS^)$%O*RK=GQPT;CY9NRM5UXX/3<`#-V-
M--C/E;GS"T,T/X`R!&UW[_KAETYV`Z&4"=O\S(NM_O!@C"O.+J"?23B]0+FI
M9F9\72KC-_=J1[YS+Q->>?JP9O.%)Q,/XE1,.D*%J-,DY6$NB_1T/K\7?N(@
M"%&X,&*9[MD\US7C^D^=/(]Z.F&0NN!FK,4QU"C^=ZB?LOX(*W._'X[2S=G8
C_X+Z]V$*R);G'!SV1UV2_C:,S3H2193&1.P1N75EN)$%````
`
end
