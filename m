Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268900AbUJUJRe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268900AbUJUJRe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 05:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268971AbUJUJM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 05:12:56 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:5644 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S270329AbUJTTY6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 15:24:58 -0400
Date: Wed, 20 Oct 2004 14:20:07 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: netdev@oss.sgi.com, linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: [patch 2.6.9 5/11] tulip: Add MODULE_VERSION
Message-ID: <20041020142007.H8775@tuxdriver.com>
Mail-Followup-To: netdev@oss.sgi.com, linux-kernel@vger.kernel.org,
	jgarzik@pobox.com
References: <20041020141146.C8775@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20041020141146.C8775@tuxdriver.com>; from linville@tuxdriver.com on Wed, Oct 20, 2004 at 02:11:46PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add MODULE_VERSION to the tulip-based drivers

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---
 drivers/net/tulip/de2104x.c         |    1 +
 drivers/net/tulip/dmfe.c            |    1 +
 drivers/net/tulip/tulip_core.c      |    1 +
 drivers/net/tulip/winbond-840.c     |    1 +
 drivers/net/tulip/xircom_tulip_cb.c |    1 +
 5 files changed, 5 insertions(+)

--- linux-2.6.9/drivers/net/tulip/de2104x.c.orig
+++ linux-2.6.9/drivers/net/tulip/de2104x.c
@@ -56,6 +56,7 @@ KERN_INFO DRV_NAME " PCI Ethernet driver
 MODULE_AUTHOR("Jeff Garzik <jgarzik@pobox.com>");
 MODULE_DESCRIPTION("Intel/Digital 21040/1 series PCI Ethernet driver");
 MODULE_LICENSE("GPL");
+MODULE_VERSION(DRV_VERSION);
 
 static int debug = -1;
 MODULE_PARM (debug, "i");
--- linux-2.6.9/drivers/net/tulip/tulip_core.c.orig
+++ linux-2.6.9/drivers/net/tulip/tulip_core.c
@@ -115,6 +115,7 @@ static int csr0 = 0x00A00000 | 0x4800;
 MODULE_AUTHOR("The Linux Kernel Team");
 MODULE_DESCRIPTION("Digital 21*4* Tulip ethernet driver");
 MODULE_LICENSE("GPL");
+MODULE_VERSION(DRV_VERSION);
 MODULE_PARM(tulip_debug, "i");
 MODULE_PARM(max_interrupt_work, "i");
 MODULE_PARM(rx_copybreak, "i");
--- linux-2.6.9/drivers/net/tulip/xircom_tulip_cb.c.orig
+++ linux-2.6.9/drivers/net/tulip/xircom_tulip_cb.c
@@ -116,6 +116,7 @@ KERN_INFO " unofficial 2.4.x kernel port
 MODULE_AUTHOR("Donald Becker <becker@scyld.com>");
 MODULE_DESCRIPTION("Xircom CBE-100 ethernet driver");
 MODULE_LICENSE("GPL v2");
+MODULE_VERSION(DRV_VERSION);
 
 MODULE_PARM(debug, "i");
 MODULE_PARM(max_interrupt_work, "i");
--- linux-2.6.9/drivers/net/tulip/dmfe.c.orig
+++ linux-2.6.9/drivers/net/tulip/dmfe.c
@@ -1986,6 +1986,7 @@ static struct pci_driver dmfe_driver = {
 MODULE_AUTHOR("Sten Wang, sten_wang@davicom.com.tw");
 MODULE_DESCRIPTION("Davicom DM910X fast ethernet driver");
 MODULE_LICENSE("GPL");
+MODULE_VERSION(DRV_VERSION);
 
 MODULE_PARM(debug, "i");
 MODULE_PARM(mode, "i");
--- linux-2.6.9/drivers/net/tulip/winbond-840.c.orig
+++ linux-2.6.9/drivers/net/tulip/winbond-840.c
@@ -144,6 +144,7 @@ KERN_INFO "  http://www.scyld.com/networ
 MODULE_AUTHOR("Donald Becker <becker@scyld.com>");
 MODULE_DESCRIPTION("Winbond W89c840 Ethernet driver");
 MODULE_LICENSE("GPL");
+MODULE_VERSION(DRV_VERSION);
 
 MODULE_PARM(max_interrupt_work, "i");
 MODULE_PARM(debug, "i");
