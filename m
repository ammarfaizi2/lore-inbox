Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263043AbUKTFOR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263043AbUKTFOR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 00:14:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262867AbUKTCiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 21:38:14 -0500
Received: from baikonur.stro.at ([213.239.196.228]:31891 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S263049AbUKTC3k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 21:29:40 -0500
Subject: [patch 5/8]  to arch/sparc64/Kconfig
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, james4765@gmail.com
From: janitor@sternwelten.at
Date: Sat, 20 Nov 2004 03:29:39 +0100
Message-ID: <E1CVL0N-0000W9-Hi@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Description: Remove x86-specific help in arch/sparc64/Kconfig.
Apply against 2.6.9.

Signed-off by: James Nelson <james4765@gmail.com>


Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
---

 linux-2.6.10-rc2-bk4-max/arch/sparc64/Kconfig |   10 ++--------
 1 files changed, 2 insertions(+), 8 deletions(-)

diff -puN arch/sparc64/Kconfig~kconfig-arch_sparc64 arch/sparc64/Kconfig
--- linux-2.6.10-rc2-bk4/arch/sparc64/Kconfig~kconfig-arch_sparc64	2004-11-20 03:04:52.000000000 +0100
+++ linux-2.6.10-rc2-bk4-max/arch/sparc64/Kconfig	2004-11-20 03:04:52.000000000 +0100
@@ -92,8 +92,8 @@ config SMP
 	bool "Symmetric multi-processing support"
 	---help---
 	  This enables support for systems with more than one CPU. If you have
-	  a system with only one CPU, like most personal computers, say N. If
-	  you have a system with more than one CPU, say Y.
+	  a system with only one CPU, say N. If you have a system with more than
+	  one CPU, say Y.
 
 	  If you say N here, the kernel will run on single and multiprocessor
 	  machines, but will use only one CPU of a multiprocessor machine. If
@@ -101,17 +101,11 @@ config SMP
 	  singleprocessor machines. On a singleprocessor machine, the kernel
 	  will run faster if you say N here.
 
-	  Note that if you say Y here and choose architecture "586" or
-	  "Pentium" under "Processor family", the kernel will not work on 486
-	  architectures. Similarly, multiprocessor kernels for the "PPro"
-	  architecture may not work on all Pentium based boards.
-
 	  People using multiprocessor machines who say Y here should also say
 	  Y to "Enhanced Real Time Clock Support", below. The "Advanced Power
 	  Management" code will be disabled if you say Y here.
 
 	  See also the <file:Documentation/smp.txt>,
-	  <file:Documentation/i386/IO-APIC.txt>,
 	  <file:Documentation/nmi_watchdog.txt> and the SMP-HOWTO available at
 	  <http://www.tldp.org/docs.html#howto>.
 
_
