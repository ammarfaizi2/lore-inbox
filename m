Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263439AbUJ3B7F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263439AbUJ3B7F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 21:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263661AbUJ3Bxr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 21:53:47 -0400
Received: from out002pub.verizon.net ([206.46.170.141]:7330 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP id S263470AbUJ3BnX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 21:43:23 -0400
From: james4765@verizon.net
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, james4765@verizon.net
Message-Id: <20041030014317.12427.77798.70363@localhost.localdomain>
In-Reply-To: <20041030014310.12427.89090.67655@localhost.localdomain>
References: <20041030014310.12427.89090.67655@localhost.localdomain>
Subject: [PATCH 1/2] computone: Documentation/computone.txt update
X-Authentication-Info: Submitted using SMTP AUTH at out002.verizon.net from [209.158.211.53] at Fri, 29 Oct 2004 20:43:17 -0500
Date: Fri, 29 Oct 2004 20:43:17 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description: Minor cleanup and status update to Documentation/computone.txt.

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.9-original/Documentation/computone.txt linux-2.6.9/Documentation/computone.txt
--- linux-2.6.9-original/Documentation/computone.txt	2004-10-18 17:54:55.000000000 -0400
+++ linux-2.6.9/Documentation/computone.txt	2004-10-29 21:35:52.102744264 -0400
@@ -1,3 +1,13 @@
+NOTE: This is an unmaintained driver.  It is not guaranteed to work due to
+changes made in the tty layer in 2.6.  If you wish to take over maintenance of
+this driver, contact Michael Warfield <mhw@wittsend.com>.
+
+Changelog:
+----------
+11-01-2001:	Original Document
+
+10-29-2004:	Minor misspelling & format fix, update status of driver.
+		James Nelson <james4765@gmail.com>
 
 Computone Intelliport II/Plus Multiport Serial Driver
 -----------------------------------------------------
@@ -146,7 +156,7 @@
 ip2.c are used. If you are autoloading the driver module with kerneld or
 kmod the base addresses and interrupt number must also be set in ip2.c
 and recompile or just insert and options line in /etc/modprobe.conf or both.
-The options line is equivalent to the command line and takes precidence over 
+The options line is equivalent to the command line and takes precedence over 
 what is in ip2.c. 
 
 /etc/modprobe.conf sample:
@@ -166,7 +176,8 @@
 
 
 Note:	Both io and irq should be updated to reflect YOUR system.  An "io"
-	address of 1 or 2 indicates a PCI or EISA card in the board table.		The PCI or EISA irq will be assigned automatically.
+	address of 1 or 2 indicates a PCI or EISA card in the board table.
+	The PCI or EISA irq will be assigned automatically.
 
 Specifying an invalid or in-use irq will default the driver into
 running in polled mode for that card.  If all irq entries are 0 then
