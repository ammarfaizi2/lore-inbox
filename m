Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932297AbWAUAYu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932297AbWAUAYu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 19:24:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932298AbWAUAYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 19:24:50 -0500
Received: from az33egw02.freescale.net ([192.88.158.103]:62958 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S932297AbWAUAYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 19:24:49 -0500
Message-ID: <43D17F4D.2010003@freescale.com>
Date: Fri, 20 Jan 2006 17:24:45 -0700
From: Matt Waddel <Matt.Waddel@freescale.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-m68k@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Subject: Re: License oddity in some m68k files
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 >> Alan Cox wrote:
 >>
 >>> On Gwe, 2006-01-20 at 07:21 -0500, Ric Wheeler wrote:
 >>>
 >>>> The language in the source files is pretty strong and this looks
 >>>> like
 >>>> Motorola should be asked to rerelease the files with a normal
 >>>> copyright notice in place of the current language...
 >>>>
 >>>
 >>> Its standard boilerplate from the period. Its a perfectly normal and
 >>> clear copyright notice.
 >>>
 >>> Alan
 >>>
 >> Actually, that is the exact language our lawyers still give us to
 >> use today when we have not settled on license terms when we want to
 >> share code in a severely limited fashion.
 >>
 >> I still think it best that they (Freescale) modify their language
 >> to reference the actual license grant in the README.
 >
 >Good luck finding anyone in Freescale that would have any idea about
 >this.
 >
 >- kumar
 >-

I have been given permission to fix the "UNPUBLISHED PROPRIETARY
SOURCE CODE OF MOTOROLA ..." section in the source files of fpsp040/
directory.

One suggestion, so we don't have to revisit this topic in 16 years
from now again, shouldn't we just remove the UNPUBLISHED ... comment
altogether and replace it with Greg Kroah-Hartman's suggested verbiage
as in the patch below?

--Matt

--------------------------------------------------------------------
Subject: Re: [PATCH] Add wording to m68k .S files to help clarify license info.

Signed-off-by: Matt Waddel <matt.waddel@freescale.com>

diff --git a/arch/m68k/fpsp040/bindec.S b/arch/m68k/fpsp040/bindec.S
index 3ba446a..72f1159 100644
--- a/arch/m68k/fpsp040/bindec.S
+++ b/arch/m68k/fpsp040/bindec.S
@@ -131,9 +131,8 @@
  |              Copyright (C) Motorola, Inc. 1990
  |                      All Rights Reserved
  |
-|      THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
-|      The copyright notice above does not evidence any
-|      actual or intended publication of such source code.
+|       For details on the license for this file, please see the
+|       file, README, in this same directory.

  |BINDEC    idnt    2,1 | Motorola 040 Floating Point Software Package

diff --git a/arch/m68k/fpsp040/binstr.S b/arch/m68k/fpsp040/binstr.S
index d53555c..8a05ba9 100644
--- a/arch/m68k/fpsp040/binstr.S
+++ b/arch/m68k/fpsp040/binstr.S
@@ -60,9 +60,8 @@
  |              Copyright (C) Motorola, Inc. 1990
  |                      All Rights Reserved
  |
-|      THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
-|      The copyright notice above does not evidence any
-|      actual or intended publication of such source code.
+|       For details on the license for this file, please see the
+|       file, README, in this same directory.

  |BINSTR    idnt    2,1 | Motorola 040 Floating Point Software Package

diff --git a/arch/m68k/fpsp040/bugfix.S b/arch/m68k/fpsp040/bugfix.S
index 942c4f6..3bb9c84 100644
--- a/arch/m68k/fpsp040/bugfix.S
+++ b/arch/m68k/fpsp040/bugfix.S
@@ -152,9 +152,8 @@
  |              Copyright (C) Motorola, Inc. 1990
  |                      All Rights Reserved
  |
-|      THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
-|      The copyright notice above does not evidence any
-|      actual or intended publication of such source code.
+|       For details on the license for this file, please see the
+|       file, README, in this same directory.

  |BUGFIX    idnt    2,1 | Motorola 040 Floating Point Software Package

diff --git a/arch/m68k/fpsp040/decbin.S b/arch/m68k/fpsp040/decbin.S
index 2160609..16ed796 100644
--- a/arch/m68k/fpsp040/decbin.S
+++ b/arch/m68k/fpsp040/decbin.S
@@ -69,9 +69,8 @@
  |              Copyright (C) Motorola, Inc. 1990
  |                      All Rights Reserved
  |
-|      THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
-|      The copyright notice above does not evidence any
-|      actual or intended publication of such source code.
+|       For details on the license for this file, please see the
+|       file, README, in this same directory.

  |DECBIN    idnt    2,1 | Motorola 040 Floating Point Software Package

diff --git a/arch/m68k/fpsp040/do_func.S b/arch/m68k/fpsp040/do_func.S
index 81f6a98..3eff99a 100644
--- a/arch/m68k/fpsp040/do_func.S
+++ b/arch/m68k/fpsp040/do_func.S
@@ -22,9 +22,8 @@
  |              Copyright (C) Motorola, Inc. 1990
  |                      All Rights Reserved
  |
-|      THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
-|      The copyright notice above does not evidence any
-|      actual or intended publication of such source code.
+|       For details on the license for this file, please see the
+|       file, README, in this same directory.

  DO_FUNC:       |idnt    2,1 | Motorola 040 Floating Point Software Package

diff --git a/arch/m68k/fpsp040/fpsp.h b/arch/m68k/fpsp040/fpsp.h
index 984a4eb..5df4cd7 100644
--- a/arch/m68k/fpsp040/fpsp.h
+++ b/arch/m68k/fpsp040/fpsp.h
@@ -5,9 +5,8 @@
  |              Copyright (C) Motorola, Inc. 1990
  |                      All Rights Reserved
  |
-|      THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
-|      The copyright notice above does not evidence any
-|      actual or intended publication of such source code.
+|       For details on the license for this file, please see the
+|       file, README, in this same directory.

  |      fpsp.h --- stack frame offsets during FPSP exception handling
  |
diff --git a/arch/m68k/fpsp040/gen_except.S b/arch/m68k/fpsp040/gen_except.S
index 401d06f..3642cb7 100644
--- a/arch/m68k/fpsp040/gen_except.S
+++ b/arch/m68k/fpsp040/gen_except.S
@@ -29,9 +29,8 @@
  |              Copyright (C) Motorola, Inc. 1990
  |                      All Rights Reserved
  |
-|      THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
-|      The copyright notice above does not evidence any
-|      actual or intended publication of such source code.
+|       For details on the license for this file, please see the
+|       file, README, in this same directory.

  GEN_EXCEPT:    |idnt    2,1 | Motorola 040 Floating Point Software Package

diff --git a/arch/m68k/fpsp040/get_op.S b/arch/m68k/fpsp040/get_op.S
index c7c2f37..64c36d7 100644
--- a/arch/m68k/fpsp040/get_op.S
+++ b/arch/m68k/fpsp040/get_op.S
@@ -54,9 +54,8 @@
  |              Copyright (C) Motorola, Inc. 1990
  |                      All Rights Reserved
  |
-|      THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
-|      The copyright notice above does not evidence any
-|      actual or intended publication of such source code.
+|       For details on the license for this file, please see the
+|       file, README, in this same directory.

  GET_OP:    |idnt    2,1 | Motorola 040 Floating Point Software Package

diff --git a/arch/m68k/fpsp040/kernel_ex.S b/arch/m68k/fpsp040/kernel_ex.S
index 476b711..45bcf34 100644
--- a/arch/m68k/fpsp040/kernel_ex.S
+++ b/arch/m68k/fpsp040/kernel_ex.S
@@ -12,9 +12,8 @@
  |              Copyright (C) Motorola, Inc. 1990
  |                      All Rights Reserved
  |
-|      THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
-|      The copyright notice above does not evidence any
-|      actual or intended publication of such source code.
+|       For details on the license for this file, please see the
+|       file, README, in this same directory.

  KERNEL_EX:    |idnt    2,1 | Motorola 040 Floating Point Software Package

diff --git a/arch/m68k/fpsp040/res_func.S b/arch/m68k/fpsp040/res_func.S
index 8f6b952..d9cdf43 100644
--- a/arch/m68k/fpsp040/res_func.S
+++ b/arch/m68k/fpsp040/res_func.S
@@ -16,9 +16,8 @@
  |              Copyright (C) Motorola, Inc. 1990
  |                      All Rights Reserved
  |
-|      THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
-|      The copyright notice above does not evidence any
-|      actual or intended publication of such source code.
+|       For details on the license for this file, please see the
+|       file, README, in this same directory.

  RES_FUNC:    |idnt    2,1 | Motorola 040 Floating Point Software Package

diff --git a/arch/m68k/fpsp040/round.S b/arch/m68k/fpsp040/round.S
index 00f9806..f84ae0d 100644
--- a/arch/m68k/fpsp040/round.S
+++ b/arch/m68k/fpsp040/round.S
@@ -8,9 +8,8 @@
  |              Copyright (C) Motorola, Inc. 1990
  |                      All Rights Reserved
  |
-|      THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
-|      The copyright notice above does not evidence any
-|      actual or intended publication of such source code.
+|       For details on the license for this file, please see the
+|       file, README, in this same directory.

  |ROUND idnt    2,1 | Motorola 040 Floating Point Software Package

diff --git a/arch/m68k/fpsp040/sacos.S b/arch/m68k/fpsp040/sacos.S
index 83b00ab..513c7cc 100644
--- a/arch/m68k/fpsp040/sacos.S
+++ b/arch/m68k/fpsp040/sacos.S
@@ -38,9 +38,8 @@
  |              Copyright (C) Motorola, Inc. 1990
  |                      All Rights Reserved
  |
-|      THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
-|      The copyright notice above does not evidence any
-|      actual or intended publication of such source code.
+|       For details on the license for this file, please see the
+|       file, README, in this same directory.

  |SACOS idnt    2,1 | Motorola 040 Floating Point Software Package

diff --git a/arch/m68k/fpsp040/sasin.S b/arch/m68k/fpsp040/sasin.S
index 5647a60..2a269a5 100644
--- a/arch/m68k/fpsp040/sasin.S
+++ b/arch/m68k/fpsp040/sasin.S
@@ -38,9 +38,8 @@
  |              Copyright (C) Motorola, Inc. 1990
  |                      All Rights Reserved
  |
-|      THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
-|      The copyright notice above does not evidence any
-|      actual or intended publication of such source code.
+|       For details on the license for this file, please see the
+|       file, README, in this same directory.

  |SASIN idnt    2,1 | Motorola 040 Floating Point Software Package

diff --git a/arch/m68k/fpsp040/satan.S b/arch/m68k/fpsp040/satan.S
index 20dae22..c8a6649 100644
--- a/arch/m68k/fpsp040/satan.S
+++ b/arch/m68k/fpsp040/satan.S
@@ -43,9 +43,8 @@
  |              Copyright (C) Motorola, Inc. 1990
  |                      All Rights Reserved
  |
-|      THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
-|      The copyright notice above does not evidence any
-|      actual or intended publication of such source code.
+|       For details on the license for this file, please see the
+|       file, README, in this same directory.

  |satan idnt    2,1 | Motorola 040 Floating Point Software Package

diff --git a/arch/m68k/fpsp040/satanh.S b/arch/m68k/fpsp040/satanh.S
index 20f0781..ba91f77 100644
--- a/arch/m68k/fpsp040/satanh.S
+++ b/arch/m68k/fpsp040/satanh.S
@@ -45,9 +45,8 @@
  |              Copyright (C) Motorola, Inc. 1990
  |                      All Rights Reserved
  |
-|      THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
-|      The copyright notice above does not evidence any
-|      actual or intended publication of such source code.
+|       For details on the license for this file, please see the
+|       file, README, in this same directory.

  |satanh        idnt    2,1 | Motorola 040 Floating Point Software Package

diff --git a/arch/m68k/fpsp040/scale.S b/arch/m68k/fpsp040/scale.S
index 5c9b805..04829dd 100644
--- a/arch/m68k/fpsp040/scale.S
+++ b/arch/m68k/fpsp040/scale.S
@@ -21,9 +21,8 @@
  |              Copyright (C) Motorola, Inc. 1990
  |                      All Rights Reserved
  |
-|      THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
-|      The copyright notice above does not evidence any
-|      actual or intended publication of such source code.
+|       For details on the license for this file, please see the
+|       file, README, in this same directory.

  |SCALE    idnt    2,1 | Motorola 040 Floating Point Software Package

diff --git a/arch/m68k/fpsp040/scosh.S b/arch/m68k/fpsp040/scosh.S
index e81edbb..07d3a4d 100644
--- a/arch/m68k/fpsp040/scosh.S
+++ b/arch/m68k/fpsp040/scosh.S
@@ -49,9 +49,8 @@
  |              Copyright (C) Motorola, Inc. 1990
  |                      All Rights Reserved
  |
-|      THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
-|      The copyright notice above does not evidence any
-|      actual or intended publication of such source code.
+|       For details on the license for this file, please see the
+|       file, README, in this same directory.

  |SCOSH idnt    2,1 | Motorola 040 Floating Point Software Package

diff --git a/arch/m68k/fpsp040/setox.S b/arch/m68k/fpsp040/setox.S
index 0aa75f9..145af54 100644
--- a/arch/m68k/fpsp040/setox.S
+++ b/arch/m68k/fpsp040/setox.S
@@ -331,9 +331,8 @@
  |              Copyright (C) Motorola, Inc. 1990
  |                      All Rights Reserved
  |
-|      THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
-|      The copyright notice above does not evidence any
-|      actual or intended publication of such source code.
+|       For details on the license for this file, please see the
+|       file, README, in this same directory.

  |setox idnt    2,1 | Motorola 040 Floating Point Software Package

diff --git a/arch/m68k/fpsp040/sgetem.S b/arch/m68k/fpsp040/sgetem.S
index 0fcbd04..d9234f4 100644
--- a/arch/m68k/fpsp040/sgetem.S
+++ b/arch/m68k/fpsp040/sgetem.S
@@ -24,9 +24,8 @@
  |              Copyright (C) Motorola, Inc. 1990
  |                      All Rights Reserved
  |
-|      THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
-|      The copyright notice above does not evidence any
-|      actual or intended publication of such source code.
+|       For details on the license for this file, please see the
+|       file, README, in this same directory.

  |SGETEM        idnt    2,1 | Motorola 040 Floating Point Software Package

diff --git a/arch/m68k/fpsp040/sint.S b/arch/m68k/fpsp040/sint.S
index 0f9bd28..0e92d4e 100644
--- a/arch/m68k/fpsp040/sint.S
+++ b/arch/m68k/fpsp040/sint.S
@@ -51,9 +51,8 @@
  |              Copyright (C) Motorola, Inc. 1990
  |                      All Rights Reserved
  |
-|      THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
-|      The copyright notice above does not evidence any
-|      actual or intended publication of such source code.
+|       For details on the license for this file, please see the
+|       file, README, in this same directory.

  |SINT    idnt    2,1 | Motorola 040 Floating Point Software Package

diff --git a/arch/m68k/fpsp040/skeleton.S b/arch/m68k/fpsp040/skeleton.S
index a162919..a8f4161 100644
--- a/arch/m68k/fpsp040/skeleton.S
+++ b/arch/m68k/fpsp040/skeleton.S
@@ -30,9 +30,8 @@
  |              Copyright (C) Motorola, Inc. 1990
  |                      All Rights Reserved
  |
-|      THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
-|      The copyright notice above does not evidence any
-|      actual or intended publication of such source code.
+|       For details on the license for this file, please see the
+|       file, README, in this same directory.

  |
  |      Modified for Linux-1.3.x by Jes Sorensen (jds@kom.auc.dk)
diff --git a/arch/m68k/fpsp040/slog2.S b/arch/m68k/fpsp040/slog2.S
index 517fa45..fac2c73 100644
--- a/arch/m68k/fpsp040/slog2.S
+++ b/arch/m68k/fpsp040/slog2.S
@@ -96,9 +96,8 @@
  |              Copyright (C) Motorola, Inc. 1990
  |                      All Rights Reserved
  |
-|      THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
-|      The copyright notice above does not evidence any
-|      actual or intended publication of such source code.
+|       For details on the license for this file, please see the
+|       file, README, in this same directory.

  |SLOG2    idnt    2,1 | Motorola 040 Floating Point Software Package

diff --git a/arch/m68k/fpsp040/slogn.S b/arch/m68k/fpsp040/slogn.S
index 2aaa072..d98eaf6 100644
--- a/arch/m68k/fpsp040/slogn.S
+++ b/arch/m68k/fpsp040/slogn.S
@@ -63,9 +63,8 @@
  |              Copyright (C) Motorola, Inc. 1990
  |                      All Rights Reserved
  |
-|      THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
-|      The copyright notice above does not evidence any
-|      actual or intended publication of such source code.
+|       For details on the license for this file, please see the
+|       file, README, in this same directory.

  |slogn idnt    2,1 | Motorola 040 Floating Point Software Package

diff --git a/arch/m68k/fpsp040/smovecr.S b/arch/m68k/fpsp040/smovecr.S
index a0127fa..73c3651 100644
--- a/arch/m68k/fpsp040/smovecr.S
+++ b/arch/m68k/fpsp040/smovecr.S
@@ -15,9 +15,8 @@
  |              Copyright (C) Motorola, Inc. 1990
  |                      All Rights Reserved
  |
-|      THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
-|      The copyright notice above does not evidence any
-|      actual or intended publication of such source code.
+|       For details on the license for this file, please see the
+|       file, README, in this same directory.

  |SMOVECR       idnt    2,1 | Motorola 040 Floating Point Software Package

diff --git a/arch/m68k/fpsp040/srem_mod.S b/arch/m68k/fpsp040/srem_mod.S
index 8c8d7f5..a27e70c 100644
--- a/arch/m68k/fpsp040/srem_mod.S
+++ b/arch/m68k/fpsp040/srem_mod.S
@@ -66,9 +66,8 @@
  |              Copyright (C) Motorola, Inc. 1990
  |                      All Rights Reserved
  |
-|      THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
-|      The copyright notice above does not evidence any
-|      actual or intended publication of such source code.
+|       For details on the license for this file, please see the
+|       file, README, in this same directory.

  SREM_MOD:    |idnt    2,1 | Motorola 040 Floating Point Software Package

diff --git a/arch/m68k/fpsp040/ssin.S b/arch/m68k/fpsp040/ssin.S
index 043c91c..a1ef8e0 100644
--- a/arch/m68k/fpsp040/ssin.S
+++ b/arch/m68k/fpsp040/ssin.S
@@ -83,9 +83,8 @@
  |              Copyright (C) Motorola, Inc. 1990
  |                      All Rights Reserved
  |
-|      THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
-|      The copyright notice above does not evidence any
-|      actual or intended publication of such source code.
+|       For details on the license for this file, please see the
+|       file, README, in this same directory.

  |SSIN  idnt    2,1 | Motorola 040 Floating Point Software Package

diff --git a/arch/m68k/fpsp040/ssinh.S b/arch/m68k/fpsp040/ssinh.S
index c8b3308..8a560ed 100644
--- a/arch/m68k/fpsp040/ssinh.S
+++ b/arch/m68k/fpsp040/ssinh.S
@@ -49,9 +49,8 @@
  |              Copyright (C) Motorola, Inc. 1990
  |                      All Rights Reserved
  |
-|      THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
-|      The copyright notice above does not evidence any
-|      actual or intended publication of such source code.
+|       For details on the license for this file, please see the
+|       file, README, in this same directory.

  |SSINH idnt    2,1 | Motorola 040 Floating Point Software Package

diff --git a/arch/m68k/fpsp040/stan.S b/arch/m68k/fpsp040/stan.S
index b5c2a19..f8553aa 100644
--- a/arch/m68k/fpsp040/stan.S
+++ b/arch/m68k/fpsp040/stan.S
@@ -50,9 +50,8 @@
  |              Copyright (C) Motorola, Inc. 1990
  |                      All Rights Reserved
  |
-|      THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
-|      The copyright notice above does not evidence any
-|      actual or intended publication of such source code.
+|       For details on the license for this file, please see the
+|       file, README, in this same directory.

  |STAN  idnt    2,1 | Motorola 040 Floating Point Software Package

diff --git a/arch/m68k/fpsp040/stanh.S b/arch/m68k/fpsp040/stanh.S
index 33b0098..7e12e59 100644
--- a/arch/m68k/fpsp040/stanh.S
+++ b/arch/m68k/fpsp040/stanh.S
@@ -49,9 +49,8 @@
  |              Copyright (C) Motorola, Inc. 1990
  |                      All Rights Reserved
  |
-|      THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
-|      The copyright notice above does not evidence any
-|      actual or intended publication of such source code.
+|       For details on the license for this file, please see the
+|       file, README, in this same directory.

  |STANH idnt    2,1 | Motorola 040 Floating Point Software Package

diff --git a/arch/m68k/fpsp040/sto_res.S b/arch/m68k/fpsp040/sto_res.S
index 0cdca3b..484b47d 100644
--- a/arch/m68k/fpsp040/sto_res.S
+++ b/arch/m68k/fpsp040/sto_res.S
@@ -19,9 +19,8 @@
  |              Copyright (C) Motorola, Inc. 1990
  |                      All Rights Reserved
  |
-|      THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
-|      The copyright notice above does not evidence any
-|      actual or intended publication of such source code.
+|       For details on the license for this file, please see the
+|       file, README, in this same directory.

  STO_RES:       |idnt   2,1 | Motorola 040 Floating Point Software Package

diff --git a/arch/m68k/fpsp040/stwotox.S b/arch/m68k/fpsp040/stwotox.S
index 4e3c140..0d5e6a1 100644
--- a/arch/m68k/fpsp040/stwotox.S
+++ b/arch/m68k/fpsp040/stwotox.S
@@ -76,9 +76,8 @@
  |              Copyright (C) Motorola, Inc. 1990
  |                      All Rights Reserved
  |
-|      THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
-|      The copyright notice above does not evidence any
-|      actual or intended publication of such source code.
+|       For details on the license for this file, please see the
+|       file, README, in this same directory.

  |STWOTOX       idnt    2,1 | Motorola 040 Floating Point Software Package

diff --git a/arch/m68k/fpsp040/tbldo.S b/arch/m68k/fpsp040/tbldo.S
index fe60cf4..fd5c37a 100644
--- a/arch/m68k/fpsp040/tbldo.S
+++ b/arch/m68k/fpsp040/tbldo.S
@@ -17,9 +17,8 @@
  |              Copyright (C) Motorola, Inc. 1990
  |                      All Rights Reserved
  |
-|      THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
-|      The copyright notice above does not evidence any
-|      actual or intended publication of such source code.
+|       For details on the license for this file, please see the
+|       file, README, in this same directory.

  |TBLDO idnt    2,1 | Motorola 040 Floating Point Software Package

diff --git a/arch/m68k/fpsp040/util.S b/arch/m68k/fpsp040/util.S
index 452f3d6..65b26fa 100644
--- a/arch/m68k/fpsp040/util.S
+++ b/arch/m68k/fpsp040/util.S
@@ -16,9 +16,8 @@
  |              Copyright (C) Motorola, Inc. 1990
  |                      All Rights Reserved
  |
-|      THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
-|      The copyright notice above does not evidence any
-|      actual or intended publication of such source code.
+|       For details on the license for this file, please see the
+|       file, README, in this same directory.

  |UTIL  idnt    2,1 | Motorola 040 Floating Point Software Package

diff --git a/arch/m68k/fpsp040/x_bsun.S b/arch/m68k/fpsp040/x_bsun.S
index 039247b..d5a576b 100644
--- a/arch/m68k/fpsp040/x_bsun.S
+++ b/arch/m68k/fpsp040/x_bsun.S
@@ -13,9 +13,8 @@
  |              Copyright (C) Motorola, Inc. 1990
  |                      All Rights Reserved
  |
-|      THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
-|      The copyright notice above does not evidence any
-|      actual or intended publication of such source code.
+|       For details on the license for this file, please see the
+|       file, README, in this same directory.

  X_BSUN:        |idnt    2,1 | Motorola 040 Floating Point Software Package

diff --git a/arch/m68k/fpsp040/x_fline.S b/arch/m68k/fpsp040/x_fline.S
index 3917710..264e126 100644
--- a/arch/m68k/fpsp040/x_fline.S
+++ b/arch/m68k/fpsp040/x_fline.S
@@ -13,9 +13,8 @@
  |              Copyright (C) Motorola, Inc. 1990
  |                      All Rights Reserved
  |
-|      THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
-|      The copyright notice above does not evidence any
-|      actual or intended publication of such source code.
+|       For details on the license for this file, please see the
+|       file, README, in this same directory.

  X_FLINE:       |idnt    2,1 | Motorola 040 Floating Point Software Package

diff --git a/arch/m68k/fpsp040/x_operr.S b/arch/m68k/fpsp040/x_operr.S
index b0f54bc..e2c371c 100644
--- a/arch/m68k/fpsp040/x_operr.S
+++ b/arch/m68k/fpsp040/x_operr.S
@@ -43,9 +43,8 @@
  |              Copyright (C) Motorola, Inc. 1990
  |                      All Rights Reserved
  |
-|      THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
-|      The copyright notice above does not evidence any
-|      actual or intended publication of such source code.
+|       For details on the license for this file, please see the
+|       file, README, in this same directory.

  X_OPERR:       |idnt    2,1 | Motorola 040 Floating Point Software Package

diff --git a/arch/m68k/fpsp040/x_ovfl.S b/arch/m68k/fpsp040/x_ovfl.S
index 22cb8b4..6fe4989 100644
--- a/arch/m68k/fpsp040/x_ovfl.S
+++ b/arch/m68k/fpsp040/x_ovfl.S
@@ -35,9 +35,8 @@
  |              Copyright (C) Motorola, Inc. 1990
  |                      All Rights Reserved
  |
-|      THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
-|      The copyright notice above does not evidence any
-|      actual or intended publication of such source code.
+|       For details on the license for this file, please see the
+|       file, README, in this same directory.

  X_OVFL:        |idnt    2,1 | Motorola 040 Floating Point Software Package

diff --git a/arch/m68k/fpsp040/x_snan.S b/arch/m68k/fpsp040/x_snan.S
index 039af57..4ed7664 100644
--- a/arch/m68k/fpsp040/x_snan.S
+++ b/arch/m68k/fpsp040/x_snan.S
@@ -22,9 +22,8 @@
  |              Copyright (C) Motorola, Inc. 1990
  |                      All Rights Reserved
  |
-|      THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
-|      The copyright notice above does not evidence any
-|      actual or intended publication of such source code.
+|       For details on the license for this file, please see the
+|       file, README, in this same directory.

  X_SNAN:        |idnt    2,1 | Motorola 040 Floating Point Software Package

diff --git a/arch/m68k/fpsp040/x_store.S b/arch/m68k/fpsp040/x_store.S
index 4282fa6..402dc0c 100644
--- a/arch/m68k/fpsp040/x_store.S
+++ b/arch/m68k/fpsp040/x_store.S
@@ -11,9 +11,8 @@
  |              Copyright (C) Motorola, Inc. 1990
  |                      All Rights Reserved
  |
-|      THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
-|      The copyright notice above does not evidence any
-|      actual or intended publication of such source code.
+|       For details on the license for this file, please see the
+|       file, README, in this same directory.

  X_STORE:       |idnt    2,1 | Motorola 040 Floating Point Software Package

diff --git a/arch/m68k/fpsp040/x_unfl.S b/arch/m68k/fpsp040/x_unfl.S
index 077fcc2..eb772ff 100644
--- a/arch/m68k/fpsp040/x_unfl.S
+++ b/arch/m68k/fpsp040/x_unfl.S
@@ -21,9 +21,8 @@
  |              Copyright (C) Motorola, Inc. 1990
  |                      All Rights Reserved
  |
-|      THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
-|      The copyright notice above does not evidence any
-|      actual or intended publication of such source code.
+|       For details on the license for this file, please see the
+|       file, README, in this same directory.

  X_UNFL:        |idnt    2,1 | Motorola 040 Floating Point Software Package

diff --git a/arch/m68k/fpsp040/x_unimp.S b/arch/m68k/fpsp040/x_unimp.S
index 920cb94..6f382b2 100644
--- a/arch/m68k/fpsp040/x_unimp.S
+++ b/arch/m68k/fpsp040/x_unimp.S
@@ -22,9 +22,8 @@
  |              Copyright (C) Motorola, Inc. 1990
  |                      All Rights Reserved
  |
-|      THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
-|      The copyright notice above does not evidence any
-|      actual or intended publication of such source code.
+|       For details on the license for this file, please see the
+|       file, README, in this same directory.

  X_UNIMP:       |idnt    2,1 | Motorola 040 Floating Point Software Package

diff --git a/arch/m68k/fpsp040/x_unsupp.S b/arch/m68k/fpsp040/x_unsupp.S
index 4ec5728..d7cf462 100644
--- a/arch/m68k/fpsp040/x_unsupp.S
+++ b/arch/m68k/fpsp040/x_unsupp.S
@@ -23,9 +23,8 @@
  |              Copyright (C) Motorola, Inc. 1990
  |                      All Rights Reserved
  |
-|      THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
-|      The copyright notice above does not evidence any
-|      actual or intended publication of such source code.
+|       For details on the license for this file, please see the
+|       file, README, in this same directory.

  X_UNSUPP:      |idnt    2,1 | Motorola 040 Floating Point Software Package
