Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964888AbWHQN2Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964888AbWHQN2Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:28:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964892AbWHQN2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:28:20 -0400
Received: from euridica.enternet.net.pl ([62.233.231.82]:8610 "EHLO
	euridica.enternet.net.pl") by vger.kernel.org with ESMTP
	id S964888AbWHQN2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:28:12 -0400
Date: Thu, 17 Aug 2006 13:28:34 +0000
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: disdos@traum404.de
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [RFC][PATCH 44/75] net: drivers/net/wireless/orinoco_nortel.c pci_module_init to pci_register_driver conversion
Message-ID: <20060817132834.44.XCNShr4744.3636.michal@euridica.enternet.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
In-Reply-To: <20060817132638.0.iSIzDm3640.3636.michal@euridica.enternet.net.pl>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/wireless/orinoco_nortel.c linux-work2/drivers/net/wireless/orinoco_nortel.c
--- linux-work-clean/drivers/net/wireless/orinoco_nortel.c	2006-08-16 22:41:00.000000000 +0200
+++ linux-work2/drivers/net/wireless/orinoco_nortel.c	2006-08-17 05:20:22.000000000 +0200
@@ -304,7 +304,7 @@ MODULE_LICENSE("Dual MPL/GPL");
 static int __init orinoco_nortel_init(void)
 {
 	printk(KERN_DEBUG "%s\n", version);
-	return pci_module_init(&orinoco_nortel_driver);
+	return pci_register_driver(&orinoco_nortel_driver);
 }
 
 static void __exit orinoco_nortel_exit(void)
