Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261655AbULZNqw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261655AbULZNqw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 08:46:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbULZNqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 08:46:51 -0500
Received: from out008pub.verizon.net ([206.46.170.108]:6040 "EHLO
	out008.verizon.net") by vger.kernel.org with ESMTP id S261653AbULZNql
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 08:46:41 -0500
From: James Nelson <james4765@verizon.net>
To: linux-sh@m17n.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       James Nelson <james4765@verizon.net>
Message-Id: <20041226134659.11730.54114.52485@localhost.localdomain>
Subject: [PATCH] sh: Remove x86-specific help in Kconfig
X-Authentication-Info: Submitted using SMTP AUTH at out008.verizon.net from [209.158.220.243] at Sun, 26 Dec 2004 07:46:38 -0600
Date: Sun, 26 Dec 2004 07:46:38 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove x86-specific bus refernces in arch/sh/drivers/pci/Kconfig.

Still applies against 2.6.10

Signed-off-by: James Nelson <james4765@gmail.com>

--- linux-2.6.10-original/arch/sh/drivers/pci/Kconfig	2004-12-24 16:33:49.000000000 -0500
+++ linux-2.6.10/arch/sh/drivers/pci/Kconfig	2004-12-26 08:24:25.476866445 -0500
@@ -3,8 +3,7 @@
 	help
 	  Find out whether you have a PCI motherboard. PCI is the name of a
 	  bus system, i.e. the way the CPU talks to the other stuff inside
-	  your box. Other bus systems are ISA, EISA, MicroChannel (MCA) or
-	  VESA. If you have PCI, say Y, otherwise N.
+	  your box. If you have PCI, say Y, otherwise N.
 
 	  The PCI-HOWTO, available from
 	  <http://www.tldp.org/docs.html#howto>, contains valuable
