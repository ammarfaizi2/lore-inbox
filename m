Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266221AbUJRKNv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266221AbUJRKNv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 06:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265909AbUJRKI5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 06:08:57 -0400
Received: from out006pub.verizon.net ([206.46.170.106]:251 "EHLO
	out006.verizon.net") by vger.kernel.org with ESMTP id S265697AbUJRJjC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 05:39:02 -0400
Message-ID: <41738F34.90101@verizon.net>
Date: Mon, 18 Oct 2004 05:39:00 -0400
From: Jim Nelson <james4765@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Fix help in arch/sh/drivers/pci/Kconfig
Content-Type: multipart/mixed;
 boundary="------------040006060407000905070500"
X-Authentication-Info: Submitted using SMTP AUTH at out006.verizon.net from [209.158.211.53] at Mon, 18 Oct 2004 04:39:01 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040006060407000905070500
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Removes x86-specific help in CONFIG_PCI

Applied against 2.6.9-rc4.

diff -u arch/sh/drivers/pci/Kconfig.orig arch/sh/drivers/pci/Kconfig


--------------040006060407000905070500
Content-Type: text/x-patch;
 name="arch_sh_drivers_pci_kconfig-fix-help.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="arch_sh_drivers_pci_kconfig-fix-help.patch"

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


--------------040006060407000905070500--
