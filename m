Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262774AbUCPKqZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 05:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263441AbUCPKqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 05:46:24 -0500
Received: from zwering.adsl.utwente.nl ([130.89.225.193]:2193 "EHLO
	arzie-2.adsl.utwente.nl") by vger.kernel.org with ESMTP
	id S262774AbUCPKqW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 05:46:22 -0500
Message-ID: <4056DAFD.6020902@dds.nl>
Date: Tue, 16 Mar 2004 11:46:21 +0100
From: Robert Zwerus <arzie@dds.nl>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040308)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Trivial spelling corrections to arch/i386/Kconfig
Content-Type: multipart/mixed;
 boundary="------------020007030500040701020105"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020007030500040701020105
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus and kernel folks,

Attached a patch with some spelling corrections. Please merge, thanks!
-- 
A Dieu,
  Robert Zwerus - e-mail: arzie@dds.nl
  ICQ UIN: 3943443 - MSN: robert_zwerus@hotmail.com

--------------020007030500040701020105
Content-Type: text/x-patch;
 name="arch_i386_Kconfig.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="arch_i386_Kconfig.patch"

--- Kconfig.orig	2004-03-16 11:39:00.953920334 +0100
+++ Kconfig	2004-03-16 11:35:58.698807155 +0100
@@ -837,12 +837,12 @@ config EFI
 	kernel should continue to boot on existing non-EFI platforms.
 
 config IRQBALANCE
- 	bool "Enable kernel irq balancing"
+ 	bool "Enable kernel IRQ balancing"
 	depends on SMP && X86_IO_APIC
 	default y
 	help
- 	  The defalut yes will allow the kernel to do irq load balancing.
-	  Saying no will keep the kernel from doing irq load balancing.
+ 	  The default yes will allow the kernel to do IRQ load balancing.
+	  Saying no will keep the kernel from doing IRQ load balancing.
 
 config HAVE_DEC_LOCK
 	bool
@@ -861,7 +861,7 @@ config REGPARM
 	depends on EXPERIMENTAL
 	default n
 	help
-	Compile the kernel with -mregparm=3. This uses an different ABI
+	Compile the kernel with -mregparm=3. This uses a different ABI
 	and passes the first three arguments of a function call in registers.
 	This will probably break binary only modules.
 

--------------020007030500040701020105--
