Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261566AbUJ1PAr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261566AbUJ1PAr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 11:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbUJ1PAq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 11:00:46 -0400
Received: from out011pub.verizon.net ([206.46.170.135]:41132 "EHLO
	out011.verizon.net") by vger.kernel.org with ESMTP id S261566AbUJ1PAb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 11:00:31 -0400
From: james4765@verizon.net
To: kernel-janitors@lists.osdl.org
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, james4765@verizon.net
Message-Id: <20041028150029.2776.69333.50087@localhost.localdomain>
Subject: [PATCH 1/9] to arch/sh/drivers/pci/Kconfig
X-Authentication-Info: Submitted using SMTP AUTH at out011.verizon.net from [209.158.211.53] at Thu, 28 Oct 2004 10:00:30 -0500
Date: Thu, 28 Oct 2004 10:00:30 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description: Remove x86-specific help in arch/sh/drivers/pci/Kconfig.
Apply against 2.6.9.

Signed-off by: James Nelson <james4765@gmail.com>

diff -u arch/sh/drivers/pci/Kconfig.orig arch/sh/drivers/pci/Kconfig
--- arch/sh/drivers/pci/Kconfig.orig	2004-10-17 15:22:15.567649627 -0400
+++ arch/sh/drivers/pci/Kconfig	2004-10-17 15:23:00.778611363 -0400
@@ -3,8 +3,7 @@
 	help
 	  Find out whether you have a PCI motherboard. PCI is the name of a
 	  bus system, i.e. the way the CPU talks to the other stuff inside
-	  your box. Other bus systems are ISA, EISA, MicroChannel (MCA) or
-	  VESA. If you have PCI, say Y, otherwise N.
+	  your box. If you have PCI, say Y, otherwise N.
 
 	  The PCI-HOWTO, available from
 	  <http://www.tldp.org/docs.html#howto>, contains valuable
