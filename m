Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265887AbUJRJoi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265887AbUJRJoi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 05:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266048AbUJRJn2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 05:43:28 -0400
Received: from out014pub.verizon.net ([206.46.170.46]:56256 "EHLO
	out014.verizon.net") by vger.kernel.org with ESMTP id S265970AbUJRJmM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 05:42:12 -0400
Message-ID: <41738FF4.2030700@verizon.net>
Date: Mon, 18 Oct 2004 05:42:12 -0400
From: Jim Nelson <james4765@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: More patches to arch/sparc/Kconfig [3 of 5]
Content-Type: multipart/mixed;
 boundary="------------060707000008030005060406"
X-Authentication-Info: Submitted using SMTP AUTH at out014.verizon.net from [209.158.211.53] at Mon, 18 Oct 2004 04:42:12 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060707000008030005060406
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Fixes x86-specific bootloader help in serial console.

Apply against 2.6.9-rc4.

diff -u  arch/sparc/Kconfig.orig arch/sparc/Kconfig


--------------060707000008030005060406
Content-Type: text/x-patch;
 name="arch_sparc_kconfig-fix-serial-console-help.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="arch_sparc_kconfig-fix-serial-console-help.patch"

--- ./arch/sparc/Kconfig.orig	2004-10-16 09:53:49.626021592 -0400
+++ ./arch/sparc/Kconfig	2004-10-16 10:18:35.964664772 -0400
@@ -188,10 +188,10 @@
 	  (/dev/tty0) will still be used as the system console by default, but
 	  you can alter that using a kernel command line option such as
 	  "console=ttyS1". (Try "man bootparam" or see the documentation of
-	  your boot loader (lilo or loadlin) about how to pass options to the
-	  kernel at boot time.)
+	  your boot loader (silo) about how to pass options to the kernel at
+	  boot time.)
 
-	  If you don't have a VGA card installed and you say Y here, the
+	  If you don't have a graphics card installed and you say Y here, the
 	  kernel will automatically use the first serial line, /dev/ttyS0, as
 	  system console.
 


--------------060707000008030005060406--
