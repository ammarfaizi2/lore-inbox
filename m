Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270022AbTGYC2H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 22:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271455AbTGYC2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 22:28:07 -0400
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:56238 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S270022AbTGYC2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 22:28:03 -0400
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH][v850]  Update v850 README file
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20030725024234.037FC3733@mcspd15.ucom.lsi.nec.co.jp>
Date: Fri, 25 Jul 2003 11:42:34 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.

diff -ruN -X../cludes linux-2.6.0-test1-moo/arch/v850/README linux-2.6.0-test1-moo-v850-20030725/arch/v850/README
--- linux-2.6.0-test1-moo/arch/v850/README	2003-01-14 10:26:59.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030725/arch/v850/README	2003-07-25 11:24:25.000000000 +0900
@@ -2,21 +2,31 @@
 
    + The gdb v850e simulator (CONFIG_V850E_SIM).
 
-   + The Midas labs RTE-V850E/MA1-CB evaluation board (CONFIG_RTE_CB_MA1),
-     with untested support for the RTE-V850E/NB85E-CB board
-     (CONFIG_RTE_CB_NB85E).  This support has only been tested when running
-     with the Multi-debugger monitor ROM (for the Green Hills Multi debugger).
-     The optional NEC Solution Gear RTE-MOTHER-A motherboard is also
-     supported, which allows PCI boards to be used (CONFIG_RTE_MB_A_PCI).
-
-   + The sim85e2c simulator, which is a verilog simulation of the V850E2
-     NA85E2C cpu core (CONFIG_V850E2_SIM85E2C).
+   + The Midas labs RTE-V850E/MA1-CB and RTE-V850E/NB85E-CB evaluation boards
+     (CONFIG_RTE_CB_MA1 and CONFIG_RTE_CB_NB85E).  This support has only been
+     tested when running with the Multi-debugger monitor ROM (for the Green
+     Hills Multi debugger).  The optional NEC Solution Gear RTE-MOTHER-A
+     motherboard is also supported, which allows PCI boards to be used
+     (CONFIG_RTE_MB_A_PCI).
+
+   + The Midas labs RTE-V850E/ME2-CB evaluation board (CONFIG_RTE_CB_ME2).
+     This has only been tested using a kernel downloaded via an ICE connection
+     using the Multi debugger.  Support for the RTE-MOTHER-A is present, but
+     hasn't been tested (unlike the other Midas labs cpu boards, the
+     RTE-V850E/ME2-CB includes an ethernet adaptor).
+
+   + The NEC AS85EP1 V850E evaluation chip/board (CONFIG_V850E_AS85EP1).
+
+   + The NEC `Anna' (board/chip) implementation of the V850E2 processor
+     (CONFIG_V850E2_ANNA).
+
+   + The sim85e2c and sim85e2s simulators, which are verilog simulations of
+     the V850E2 NA85E2C/NA85E2S cpu cores (CONFIG_V850E2_SIM85E2C and
+     CONFIG_V850E2_SIM85E2S).
 
    + A FPGA implementation of the V850E2 NA85E2C cpu core
      (CONFIG_V850E2_FPGA85E2C).
 
-   + The `Anna' (board/chip) implementation of the V850E2 processor.
-
 Porting to anything with a V850E/MA1 or MA2 processor should be simple.
 See the file <asm-v850/machdep.h> and the files it includes for an example of
 how to add platform/chip-specific support.
