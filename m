Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266163AbUJRJog@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266163AbUJRJog (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 05:44:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266115AbUJRJnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 05:43:07 -0400
Received: from out003pub.verizon.net ([206.46.170.103]:41698 "EHLO
	out003.verizon.net") by vger.kernel.org with ESMTP id S266048AbUJRJmg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 05:42:36 -0400
Message-ID: <41739007.2010908@verizon.net>
Date: Mon, 18 Oct 2004 05:42:31 -0400
From: Jim Nelson <james4765@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: More patches to arch/sparc/Kconfig [5 of 5]
Content-Type: multipart/mixed;
 boundary="------------000401000708050803020705"
X-Authentication-Info: Submitted using SMTP AUTH at out003.verizon.net from [209.158.211.53] at Mon, 18 Oct 2004 04:42:31 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000401000708050803020705
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Fixes x86-specific bootloader help in printer config.

Apply against 2.6.9-rc4.

diff -u  arch/sparc/Kconfig.orig arch/sparc/Kconfig


--------------000401000708050803020705
Content-Type: text/x-patch;
 name="arch_sparc_kconfig-fix-printer-help.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="arch_sparc_kconfig-fix-printer-help.patch"

--- ./arch/sparc/Kconfig.orig	2004-10-16 09:53:49.626021592 -0400
+++ ./arch/sparc/Kconfig	2004-10-16 10:15:30.184460399 -0400
@@ -281,9 +281,9 @@
 
 	  If you have several parallel ports, you can specify which ports to
 	  use with the "lp" kernel command line option.  (Try "man bootparam"
-	  or see the documentation of your boot loader (lilo or loadlin) about
-	  how to pass options to the kernel at boot time.)  The syntax of the
-	  "lp" command line option can be found in <file:drivers/char/lp.c>.
+	  or see the documentation of your boot loader (silo) about how to pass
+	  options to the kernel at boot time.)  The syntax of the "lp" command
+	  line option can be found in <file:drivers/char/lp.c>.
 
 	  If you have more than 8 printers, you need to increase the LP_NO
 	  macro in lp.c and the PARPORT_MAX macro in parport.h.


--------------000401000708050803020705--
