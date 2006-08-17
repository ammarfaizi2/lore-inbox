Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964942AbWHQNeV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964942AbWHQNeV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:34:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964952AbWHQNbb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:31:31 -0400
Received: from euridica.enternet.net.pl ([62.233.231.82]:37554 "EHLO
	euridica.enternet.net.pl") by vger.kernel.org with ESMTP
	id S964942AbWHQN3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:29:23 -0400
Date: Thu, 17 Aug 2006 13:29:57 +0000
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: becker@scyld.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [RFC][PATCH 74/75] net: drivers/net/tulip/xircom_tulip_cb.c pci_module_init to pci_register_driver conversion
Message-ID: <20060817132957.74.gOFNrr5566.3636.michal@euridica.enternet.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
In-Reply-To: <20060817132638.0.iSIzDm3640.3636.michal@euridica.enternet.net.pl>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/tulip/xircom_tulip_cb.c linux-work2/drivers/net/tulip/xircom_tulip_cb.c
--- linux-work-clean/drivers/net/tulip/xircom_tulip_cb.c	2006-08-16 22:41:00.000000000 +0200
+++ linux-work2/drivers/net/tulip/xircom_tulip_cb.c	2006-08-17 05:19:07.000000000 +0200
@@ -1707,7 +1707,7 @@ static int __init xircom_init(void)
 #ifdef MODULE
 	printk(version);
 #endif
-	return pci_module_init(&xircom_driver);
+	return pci_register_driver(&xircom_driver);
 }
 
 
