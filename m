Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265900AbUJRJj5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265900AbUJRJj5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 05:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265234AbUJRJjW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 05:39:22 -0400
Received: from out014pub.verizon.net ([206.46.170.46]:22718 "EHLO
	out014.verizon.net") by vger.kernel.org with ESMTP id S265887AbUJRJiZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 05:38:25 -0400
Message-ID: <41738F0E.60508@verizon.net>
Date: Mon, 18 Oct 2004 05:38:22 -0400
From: Jim Nelson <james4765@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Patch to arch/sparc64/Kconfig [1 of 2]
Content-Type: multipart/mixed;
 boundary="------------070301040901000405080606"
X-Authentication-Info: Submitted using SMTP AUTH at out014.verizon.net from [209.158.211.53] at Mon, 18 Oct 2004 04:38:22 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070301040901000405080606
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Fixing x86-specific help references to bootloader.

Apply against 2.6.9-rc4.

diff -u arch/sparc64/Kconfig.orig arch/sparc54/Kconfig


--------------070301040901000405080606
Content-Type: text/x-patch;
 name="arch_sparc64_kconfig-virtual-terminal-help.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="arch_sparc64_kconfig-virtual-terminal-help.patch"

--- ./arch/sparc64/Kconfig.orig	2004-10-16 11:23:24.940665125 -0400
+++ ./arch/sparc64/Kconfig	2004-10-16 11:23:55.089644059 -0400
@@ -79,8 +79,8 @@
 	  terminal (/dev/tty0) will be used as system console. You can change
 	  that with a kernel command line option such as "console=tty3" which
 	  would use the third virtual terminal as system console. (Try "man
-	  bootparam" or see the documentation of your boot loader (lilo or
-	  loadlin) about how to pass options to the kernel at boot time.)
+	  bootparam" or see the documentation of your boot loader (silo)
+	  about how to pass options to the kernel at boot time.)
 
 	  If unsure, say Y.
 

--------------070301040901000405080606--
