Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261701AbULZQdA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261701AbULZQdA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 11:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261700AbULZQc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 11:32:59 -0500
Received: from out010pub.verizon.net ([206.46.170.133]:22964 "EHLO
	out010.verizon.net") by vger.kernel.org with ESMTP id S261699AbULZQcz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 11:32:55 -0500
From: James Nelson <james4765@verizon.net>
To: ultralinux@vger.kernel.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       James Nelson <james4765@verizon.net>
Message-Id: <20041226163315.15908.71539.84549@localhost.localdomain>
Subject: [PATCH][resend] sparc64: remove x86-specific SMP reference in Kconfig
X-Authentication-Info: Submitted using SMTP AUTH at out010.verizon.net from [209.158.220.243] at Sun, 26 Dec 2004 10:32:54 -0600
Date: Sun, 26 Dec 2004 10:32:54 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove inapplicable references to x86 SMP configuration in arch/sparc64/Kconfig.

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.10-original/arch/sparc64/Kconfig linux-2.6.10/arch/sparc64/Kconfig
--- linux-2.6.10-original/arch/sparc64/Kconfig	2004-12-24 16:35:25.000000000 -0500
+++ linux-2.6.10/arch/sparc64/Kconfig	2004-12-26 11:31:01.051423855 -0500
@@ -92,8 +92,8 @@
 	bool "Symmetric multi-processing support"
 	---help---
 	  This enables support for systems with more than one CPU. If you have
-	  a system with only one CPU, like most personal computers, say N. If
-	  you have a system with more than one CPU, say Y.
+	  a system with only one CPU, say N. If you have a system with more
+	  than one CPU, say Y.
 
 	  If you say N here, the kernel will run on single and multiprocessor
 	  machines, but will use only one CPU of a multiprocessor machine. If
@@ -101,19 +101,11 @@
 	  singleprocessor machines. On a singleprocessor machine, the kernel
 	  will run faster if you say N here.
 
-	  Note that if you say Y here and choose architecture "586" or
-	  "Pentium" under "Processor family", the kernel will not work on 486
-	  architectures. Similarly, multiprocessor kernels for the "PPro"
-	  architecture may not work on all Pentium based boards.
-
 	  People using multiprocessor machines who say Y here should also say
-	  Y to "Enhanced Real Time Clock Support", below. The "Advanced Power
-	  Management" code will be disabled if you say Y here.
+	  Y to "Enhanced Real Time Clock Support", below.
 
-	  See also the <file:Documentation/smp.txt>,
-	  <file:Documentation/i386/IO-APIC.txt>,
-	  <file:Documentation/nmi_watchdog.txt> and the SMP-HOWTO available at
-	  <http://www.tldp.org/docs.html#howto>.
+	  See also the <file:Documentation/smp.txt> and the SMP-HOWTO available
+	  at <http://www.tldp.org/docs.html#howto>.
 
 	  If you don't know what to do here, say N.
 
