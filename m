Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267237AbUIEVa4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267237AbUIEVa4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 17:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267250AbUIEVa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 17:30:56 -0400
Received: from panthera-systems.net ([213.239.209.134]:38789 "EHLO
	panthera-systems.net") by vger.kernel.org with ESMTP
	id S267237AbUIEVat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 17:30:49 -0400
Message-ID: <413B8588.5030302@panthera-systems.net>
Date: Sun, 05 Sep 2004 23:30:48 +0200
From: Daniel Baumann <daniel.baumann@panthera-systems.net>
Reply-To: daniel.baumann@panthera-systems.net
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Typing error: s/IA32/IA-32/
Content-Type: multipart/mixed;
 boundary="------------090700020008040209050201"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090700020008040209050201
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

IA32 is wrong according to Intel.

-- 
Address:        Daniel Baumann, Burgunderstrasse 3, CH-4562 Biberist
Email:          daniel.baumann@panthera-systems.net
Internet:       http://people.panthera-systems.net/~daniel-baumann/

--------------090700020008040209050201
Content-Type: text/x-patch;
 name="linux-2.6.8.1_typing-error_ia32.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.8.1_typing-error_ia32.patch"

diff -Naur linux-2.6.8.1.original/CREDITS linux-2.6.8.1/CREDITS
--- linux-2.6.8.1.original/CREDITS	2004-08-14 12:55:47.000000000 +0200
+++ linux-2.6.8.1/CREDITS	2004-09-05 22:19:37.000000000 +0200
@@ -41,7 +41,7 @@
 E: tigran@veritas.com
 W: http://www.moses.uklinux.net/patches
 D: BFS filesystem
-D: Intel IA32 CPU microcode update support
+D: Intel IA-32 CPU microcode update support
 D: Various kernel patches
 S: United Kingdom
 
diff -Naur linux-2.6.8.1.original/Documentation/Changes linux-2.6.8.1/Documentation/Changes
--- linux-2.6.8.1.original/Documentation/Changes	2004-08-14 12:56:22.000000000 +0200
+++ linux-2.6.8.1/Documentation/Changes	2004-09-05 22:19:56.000000000 +0200
@@ -202,10 +202,10 @@
 newer has this support.  Use the recommended version or newer
 from the table above.
 
-Intel IA32 microcode
---------------------
+Intel IA-32 microcode
+---------------------
 
-A driver has been added to allow updating of Intel IA32 microcode,
+A driver has been added to allow updating of Intel IA-32 microcode,
 accessible as both a devfs regular file and as a normal (misc)
 character device.  If you are not using devfs you may need to:
 
diff -Naur linux-2.6.8.1.original/Documentation/ioctl-number.txt linux-2.6.8.1/Documentation/ioctl-number.txt
--- linux-2.6.8.1.original/Documentation/ioctl-number.txt	2004-08-14 12:56:22.000000000 +0200
+++ linux-2.6.8.1/Documentation/ioctl-number.txt	2004-09-05 22:20:09.000000000 +0200
@@ -77,7 +77,7 @@
 '#'	00-3F	IEEE 1394 Subsystem	Block for the entire subsystem
 '1'	00-1F	<linux/timepps.h>	PPS kit from Ulrich Windl
 					<ftp://ftp.de.kernel.org/pub/linux/daemons/ntp/PPS/>
-'6'	00-10	<asm-i386/processor.h>	Intel IA32 microcode update driver
+'6'	00-10	<asm-i386/processor.h>	Intel IA-32 microcode update driver
 					<mailto:tigran@veritas.com>
 '8'	all				SNP8023 advanced NIC card
 					<mailto:mcr@solidum.com>
diff -Naur linux-2.6.8.1.original/arch/i386/Kconfig linux-2.6.8.1/arch/i386/Kconfig
--- linux-2.6.8.1.original/arch/i386/Kconfig	2004-08-14 12:54:50.000000000 +0200
+++ linux-2.6.8.1/arch/i386/Kconfig	2004-09-05 22:19:09.000000000 +0200
@@ -95,7 +95,7 @@
 config X86_VISWS
 	bool "SGI 320/540 (Visual Workstation)"
 	help
-	  The SGI Visual Workstation series is an IA32-based workstation
+	  The SGI Visual Workstation series is an IA-32-based workstation
 	  based on SGI systems chips with some legacy PC hardware attached.
 
 	  Say Y here to create a kernel to run on the SGI 320 or 540.
@@ -111,11 +111,11 @@
 	  It is intended for a generic binary kernel.
 
 config X86_ES7000
-	bool "Support for Unisys ES7000 IA32 series"
+	bool "Support for Unisys ES7000 IA-32 series"
 	depends on SMP
 	help
 	  Support for Unisys ES7000 systems.  Say 'Y' here if this kernel is
-	  supposed to run on an IA32-based Unisys ES7000 system. 
+	  supposed to run on an IA-32-based Unisys ES7000 system. 
 	  Only choose this option if you have such a system, otherwise you 
 	  should say N here.
 
@@ -622,11 +622,11 @@
 	  Say N otherwise.
 
 config MICROCODE
-	tristate "/dev/cpu/microcode - Intel IA32 CPU microcode support"
+	tristate "/dev/cpu/microcode - Intel IA-32 CPU microcode support"
 	---help---
 	  If you say Y here and also to "/dev file system support" in the
 	  'File systems' section, you will be able to update the microcode on
-	  Intel processors in the IA32 family, e.g. Pentium Pro, Pentium II,
+	  Intel processors in the IA-32 family, e.g. Pentium Pro, Pentium II,
 	  Pentium III, Pentium 4, Xeon etc.  You will obviously need the
 	  actual microcode binary data itself which is not shipped with the
 	  Linux kernel.
@@ -684,7 +684,7 @@
 
 	  If more than 4 Gigabytes is used then answer "64GB" here. This
 	  selection turns Intel PAE (Physical Address Extension) mode on.
-	  PAE implements 3-level paging on IA32 processors. PAE is fully
+	  PAE implements 3-level paging on IA-32 processors. PAE is fully
 	  supported by Linux, PAE mode is implemented on all recent Intel
 	  processors (Pentium Pro and better). NOTE: If you say "64GB" here,
 	  then the kernel will not boot on CPUs that don't support PAE!
diff -Naur linux-2.6.8.1.original/arch/x86_64/Kconfig linux-2.6.8.1/arch/x86_64/Kconfig
--- linux-2.6.8.1.original/arch/x86_64/Kconfig	2004-08-14 12:55:59.000000000 +0200
+++ linux-2.6.8.1/arch/x86_64/Kconfig	2004-09-05 22:21:46.000000000 +0200
@@ -95,7 +95,7 @@
 config MPSC
        bool "Intel x86-64" 
        help
-	  Optimize for Intel IA32 with 64bit extension CPUs
+	  Optimize for Intel IA-32 with 64bit extension CPUs
 	  (Prescott/Nocona/Potomac)
        
 config GENERIC_CPU
@@ -361,14 +361,14 @@
 source "fs/Kconfig.binfmt"
 
 config IA32_EMULATION
-	bool "IA32 Emulation"
+	bool "IA-32 Emulation"
 	help
 	  Include code to run 32-bit programs under a 64-bit kernel. You should likely
 	  turn this on, unless you're 100% sure that you don't have any 32-bit programs
 	  left.
 
 config IA32_AOUT
-       bool "IA32 a.out support"
+       bool "IA-32 a.out support"
        depends on IA32_EMULATION
        help
          Support old a.out binaries in the 32bit emulation.

--------------090700020008040209050201--
