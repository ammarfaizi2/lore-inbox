Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265970AbUJRJoi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265970AbUJRJoi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 05:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266096AbUJRJn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 05:43:59 -0400
Received: from out006pub.verizon.net ([206.46.170.106]:38396 "EHLO
	out006.verizon.net") by vger.kernel.org with ESMTP id S265887AbUJRJl1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 05:41:27 -0400
Message-ID: <41738FC6.4080606@verizon.net>
Date: Mon, 18 Oct 2004 05:41:26 -0400
From: Jim Nelson <james4765@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Patch to arch/sparc/Kconfig [1 of 5]
Content-Type: multipart/mixed;
 boundary="------------010703030403010309070002"
X-Authentication-Info: Submitted using SMTP AUTH at out006.verizon.net from [209.158.211.53] at Mon, 18 Oct 2004 04:41:27 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010703030403010309070002
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Fixes x86-specific help in SPARC32 SMP support help.

Apply against 2.6.9-rc4.

diff -u  arch/sparc/Kconfig.orig arch/sparc/Kconfig

--------------010703030403010309070002
Content-Type: text/x-patch;
 name="arch_sparc_kconfig-fix-SMP-help.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="arch_sparc_kconfig-fix-SMP-help.patch"

--- ./arch/sparc/Kconfig.orig	2004-10-16 09:53:49.626021592 -0400
+++ ./arch/sparc/Kconfig	2004-10-16 10:02:10.724152771 -0400
@@ -85,8 +85,8 @@
 	depends on BROKEN
 	---help---
 	  This enables support for systems with more than one CPU. If you have
-	  a system with only one CPU, like most personal computers, say N. If
-	  you have a system with more than one CPU, say Y.
+	  a system with only one CPU, say N. If you have a system with more
+	  than one CPU, say Y.
 
 	  If you say N here, the kernel will run on single and multiprocessor
 	  machines, but will use only one CPU of a multiprocessor machine. If
@@ -94,17 +94,11 @@
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
 


--------------010703030403010309070002--
