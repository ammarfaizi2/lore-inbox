Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262874AbVFVJ0y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262874AbVFVJ0y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 05:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262828AbVFVJ0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 05:26:45 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:5894 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262874AbVFVJYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 05:24:14 -0400
Date: Wed, 22 Jun 2005 11:24:09 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] document that 8139TOO supports 8129/8130
Message-ID: <20050622092408.GB3705@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The 8129/8130 support is a sub-option that is not visible if the user 
hasn't enabled the 8139 support.

Let's make it a bit easier for users to find the driver for their nic.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 16 May 2005

--- linux-2.6.12-rc4-mm1-full/drivers/net/Kconfig.old	2005-05-13 05:54:05.000000000 +0200
+++ linux-2.6.12-rc4-mm1-full/drivers/net/Kconfig	2005-05-13 06:00:21.000000000 +0200
@@ -1484,14 +1484,14 @@
 	  will be called 8139cp.  This is recommended.
 
 config 8139TOO
-	tristate "RealTek RTL-8139 PCI Fast Ethernet Adapter support"
+	tristate "RealTek RTL-8129/8130/8139 PCI Fast Ethernet Adapter support"
 	depends on NET_PCI && PCI
 	select CRC32
 	select MII
 	---help---
 	  This is a driver for the Fast Ethernet PCI network cards based on
-	  the RTL8139 chips. If you have one of those, say Y and read
-	  the Ethernet-HOWTO <http://www.tldp.org/docs.html#howto>.
+	  the RTL 8129/8130/8139 chips. If you have one of those, say Y and
+	  read the Ethernet-HOWTO <http://www.tldp.org/docs.html#howto>.
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called 8139too.  This is recommended.

