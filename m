Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263158AbSJHNnG>; Tue, 8 Oct 2002 09:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263161AbSJHNnG>; Tue, 8 Oct 2002 09:43:06 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:47764 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S263158AbSJHNmu>;
	Tue, 8 Oct 2002 09:42:50 -0400
Date: Tue, 8 Oct 2002 15:48:24 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [patch] Input - add #include <lists.h> to input.h [10/23]
Message-ID: <20021008154824.I18546@ucw.cz>
References: <20021008153813.A18515@ucw.cz> <20021008153926.A18546@ucw.cz> <20021008154029.B18546@ucw.cz> <20021008154132.C18546@ucw.cz> <20021008154246.D18546@ucw.cz> <20021008154415.E18546@ucw.cz> <20021008154549.F18546@ucw.cz> <20021008154631.G18546@ucw.cz> <20021008154733.H18546@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021008154733.H18546@ucw.cz>; from vojtech@suse.cz on Tue, Oct 08, 2002 at 03:47:33PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.
'bk pull bk://linux-input.bkbits.net/linux-input' should work as well.

===================================================================

ChangeSet@1.573.1.39, 2002-09-25 12:05:25+02:00, vojtech@suse.cz
  Add #include <list.h> to input.h


 input.h |   27 +++++----------------------
 1 files changed, 5 insertions(+), 22 deletions(-)

===================================================================

diff -Nru a/include/linux/input.h b/include/linux/input.h
--- a/include/linux/input.h	Tue Oct  8 15:26:35 2002
+++ b/include/linux/input.h	Tue Oct  8 15:26:35 2002
@@ -2,33 +2,16 @@
 #define _INPUT_H
 
 /*
- * $Id: input.h,v 1.68 2002/05/31 10:35:49 fsirl Exp $
+ * Copyright (c) 1999-2002 Vojtech Pavlik
  *
- *  Copyright (c) 1999-2001 Vojtech Pavlik
- */
-
-/*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- *
- * Should you need to contact me, the author, you can do so either by
- * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
- * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
  */
 
 #ifdef __KERNEL__
 #include <linux/time.h>
+#include <linux/list.h>
 #else
 #include <sys/time.h>
 #include <sys/ioctl.h>

===================================================================

This BitKeeper patch contains the following changesets:
1.573.1.39
## Wrapped with gzip_uu ##


begin 664 bkpatch18212
M'XL(``O=HCT``[U46T_;,!1^KG_%D7C9AIK8SKU;$0P&0T-;!6/OKG/:9"1Q
M93MEG?+CYX2.(<9`NVA)%/G8Y_*=SY_.#EP:U)/16GVV*`NR`V^5L9.1:0UZ
M\JNSSY5RME^H&OVMES^_\LMFU5KBSF?"R@+6J,UDQ+S@=L=N5C@9G;\YN3P[
M."=D.H7#0C1+O$`+TRFQ2J]%E9M]88M*-9[5HC$U6N%)57>WKAVGE+LW8DE`
MH[AC,0V33K*<,1$RS"D/TS@D6V#[6]CWXS,>,4I#'G5QF+",'`'SHB3P'-X,
M*/=IYO,(&)_0:,*C7>H6%.[EA%T&8TI>P[]%?D@D'.0Y[)2-K-H<X555&NL5
M>ZX.#"1[!7D'#C=G9/:#0S+^S8<0*BC9>P+^%H5?E4W[Q=_6O]M*%C)'8LC2
M;A'P><J#.%X@14'3^X0]ENOF0B+N<O&`AH,\'G1_6BI_@9C42A98[2N35Y[2
MR\=RI3RA-,AXUD5I%@2#A#C_23SL5^*)8,SY_U-/+YF!V0\PUM?#YR0P>YCD
M/]#2D>N8G/8_>`&':K71Y;*P\$P^!Y9EV;B'#Y]N2'`#85V55^0H`:?A4YY`
MT$=]+$H#*ZV66M3@E@N-"$8M[+70^!(VJ@4I&M"8NY9T.6\M0FE!-+FO--0J
M+Q<;M]&G:IL<-=@"P:*N#:C%8)R\OX03;%"+"F;MO"HEG)42&X/#O"I5`QR$
M`]&?F0)SF&_Z='WL<8_F8HL&CI4K(:R+\,AIP%S;=QGOJ?S.^^W\<\J25Z:M
1IU*F61KE,?D&FM2+E6P%````
`
end
