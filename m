Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263733AbTDGWnq (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 18:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263735AbTDGWnm (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 18:43:42 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:36736
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263733AbTDGWnf (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 18:43:35 -0400
Date: Tue, 8 Apr 2003 01:02:26 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200304080002.h3802QPe008910@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: Config.in typos
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Steve Cole and co)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/arch/i386/Kconfig linux-2.5.67-ac1/arch/i386/Kconfig
--- linux-2.5.67/arch/i386/Kconfig	2003-03-26 19:59:49.000000000 +0000
+++ linux-2.5.67-ac1/arch/i386/Kconfig	2003-04-04 16:22:18.000000000 +0100
@@ -142,7 +150,7 @@
 config M486
 	bool "486"
 	help
-	  Select this for a x486 processor, ether Intel or one of the
+	  Select this for a 486 series processor, either Intel or one of the
 	  compatible processors from AMD, Cyrix, IBM, or Intel.  Includes DX,
 	  DX2, and DX4 variants; also SL/SLC/SLC2/SLC3/SX/SX2 and UMC U5D or
 	  U5S.
@@ -150,8 +158,8 @@
 config M586
 	bool "586/K5/5x86/6x86/6x86MX"
 	help
-	  Select this for an x586 or x686 processor such as the AMD K5, the
-	  Intel 5x86 or 6x86, or the Intel 6x86MX.  This choice does not
+	  Select this for an 586 or 686 series processor such as the AMD K5,
+	  the Intel 5x86 or 6x86, or the Intel 6x86MX.  This choice does not
 	  assume the RDTSC (Read Time Stamp Counter) instruction.
 
 config M586TSC
@@ -226,28 +234,28 @@
 config MCRUSOE
 	bool "Crusoe"
 	help
-	  Select this for Transmeta Crusoe processor.  Treats the processor
+	  Select this for a Transmeta Crusoe processor.  Treats the processor
 	  like a 586 with TSC, and sets some GCC optimization flags (like a
 	  Pentium Pro with no alignment requirements).
 
 config MWINCHIPC6
 	bool "Winchip-C6"
 	help
-	  Select this for a IDT Winchip C6 chip.  Linux and GCC
+	  Select this for an IDT Winchip C6 chip.  Linux and GCC
 	  treat this chip as a 586TSC with some extended instructions
 	  and alignment requirements.
 
 config MWINCHIP2
 	bool "Winchip-2"
 	help
-	  Select this for a IDT Winchip-2.  Linux and GCC
+	  Select this for an IDT Winchip-2.  Linux and GCC
 	  treat this chip as a 586TSC with some extended instructions
 	  and alignment requirements.
 
 config MWINCHIP3D
 	bool "Winchip-2A/Winchip-3"
 	help
-	  Select this for a IDT Winchip-2A or 3.  Linux and GCC
+	  Select this for an IDT Winchip-2A or 3.  Linux and GCC
 	  treat this chip as a 586TSC with some extended instructions
 	  and alignment reqirements.  Development kernels also enable
 	  out of order memory stores for this CPU, which can increase
@@ -260,15 +268,15 @@
 	  treat this chip as a generic 586. Whilst the CPU is 686 class,
 	  it lacks the cmov extension which gcc assumes is present when
 	  generating 686 code.
-	  Note, that Nehemiah (Model 9) and above will not boot with this
-	  kernel due to them lacking the 3dnow instructions used in earlier
+	  Note that Nehemiah (Model 9) and above will not boot with this
+	  kernel due to them lacking the 3DNow! instructions used in earlier
 	  incarnations of the CPU.
 
 config MVIAC3_2
 	bool "VIA C3-2 (Nehemiah)"
 	help
-	  Select this for a VIA C3 "Nehemiah". Selecting this enables usage of SSE
-	  and tells gcc to treat the CPU as a 686.
+	  Select this for a VIA C3 "Nehemiah". Selecting this enables usage
+	  of SSE and tells gcc to treat the CPU as a 686.
 	  Note, this kernel will not boot on older (pre model 9) C3s.
 
 endchoice
@@ -435,7 +443,8 @@
 	  enable and use it. If you say Y here even though your machine doesn't
 	  have a local APIC, then the kernel will still run with no slowdown at
 	  all. The local APIC supports CPU-generated self-interrupts (timer,
-	  performance counters), and the NMI watchdog which detects hard lockups.
+	  performance counters), and the NMI watchdog which detects hard
+	  lockups.
 
 	  If you have a system with several CPUs, you do not need to say Y
 	  here: the local APIC will be used automatically.
@@ -522,7 +531,7 @@
 	---help---
 	  This adds a driver to safely access the System Management Mode of
 	  the CPU on Toshiba portables with a genuine Toshiba BIOS. It does
-	  not work on models with a Pheonix BIOS. The System Management Mode
+	  not work on models with a Phoenix BIOS. The System Management Mode
 	  is used to set the BIOS and power saving options on Toshiba portables.
 
 	  For information on utilities to make use of this driver see the
