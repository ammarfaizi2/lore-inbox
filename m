Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266204AbUJRKNr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266204AbUJRKNr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 06:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266221AbUJRKJl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 06:09:41 -0400
Received: from out011pub.verizon.net ([206.46.170.135]:45311 "EHLO
	out011.verizon.net") by vger.kernel.org with ESMTP id S265943AbUJRJit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 05:38:49 -0400
Message-ID: <41738F28.7090905@verizon.net>
Date: Mon, 18 Oct 2004 05:38:48 -0400
From: Jim Nelson <james4765@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Patch to arch/sparc64/Kconfig [2 of 2]
Content-Type: multipart/mixed;
 boundary="------------080509070905000607060307"
X-Authentication-Info: Submitted using SMTP AUTH at out011.verizon.net from [209.158.211.53] at Mon, 18 Oct 2004 04:38:48 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080509070905000607060307
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Fixing x86-specific help references to bootloader.

Apply against 2.6.9-rc4.

diff -u arch/sparc64/Kconfig.orig arch/sparc54/Kconfig


--------------080509070905000607060307
Content-Type: text/x-patch;
 name="arch_sparc64_kconfig-SMP-help.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="arch_sparc64_kconfig-SMP-help.patch"

--- ./arch/sparc64/Kconfig.orig	2004-10-16 11:23:24.940665125 -0400
+++ ./arch/sparc64/Kconfig	2004-10-16 11:29:32.674618258 -0400
@@ -92,8 +92,8 @@
 	bool "Symmetric multi-processing support"
 	---help---
 	  This enables support for systems with more than one CPU. If you have
-	  a system with only one CPU, like most personal computers, say N. If
-	  you have a system with more than one CPU, say Y.
+	  a system with only one CPU, say N. If you have a system with more than
+	  one CPU, say Y.
 
 	  If you say N here, the kernel will run on single and multiprocessor
 	  machines, but will use only one CPU of a multiprocessor machine. If
@@ -101,17 +101,11 @@
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
 


--------------080509070905000607060307--
