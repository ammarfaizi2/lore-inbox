Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261686AbUJ1PDk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261686AbUJ1PDk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 11:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbUJ1PCH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 11:02:07 -0400
Received: from out012pub.verizon.net ([206.46.170.137]:35744 "EHLO
	out012.verizon.net") by vger.kernel.org with ESMTP id S261686AbUJ1PBH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 11:01:07 -0400
From: james4765@verizon.net
To: kernel-janitors@lists.osdl.org
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, james4765@verizon.net
Message-Id: <20041028150104.2776.45930.45727@localhost.localdomain>
In-Reply-To: <20041028150029.2776.69333.50087@localhost.localdomain>
References: <20041028150029.2776.69333.50087@localhost.localdomain>
Subject: [PATCH 6/9] to arch/sparc/Kconfig
X-Authentication-Info: Submitted using SMTP AUTH at out012.verizon.net from [209.158.211.53] at Thu, 28 Oct 2004 10:01:04 -0500
Date: Thu, 28 Oct 2004 10:01:05 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description: Remove x86-specific help in arch/sparc/Kconfig.
Apply against 2.6.9.

Signed-off by: James Nelson <james4765@gmail.com>

diff -u ./arch/sparc/Kconfig.orig ./arch/sparc/Kconfig
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
 
