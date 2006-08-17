Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964905AbWHQNoA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964905AbWHQNoA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964898AbWHQN2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:28:25 -0400
Received: from euridica.enternet.net.pl ([62.233.231.82]:12194 "EHLO
	euridica.enternet.net.pl") by vger.kernel.org with ESMTP
	id S964894AbWHQN2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:28:21 -0400
Date: Thu, 17 Aug 2006 13:28:54 +0000
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: khc@pm.waw.pl
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [RFC][PATCH 50/75] net: drivers/net/wan/pci200syn.c pci_module_init to pci_register_driver conversion
Message-ID: <20060817132854.50.mHRHNx4920.3636.michal@euridica.enternet.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
In-Reply-To: <20060817132638.0.iSIzDm3640.3636.michal@euridica.enternet.net.pl>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/wan/pci200syn.c linux-work2/drivers/net/wan/pci200syn.c
--- linux-work-clean/drivers/net/wan/pci200syn.c	2006-08-16 22:41:00.000000000 +0200
+++ linux-work2/drivers/net/wan/pci200syn.c	2006-08-17 05:19:56.000000000 +0200
@@ -476,7 +476,7 @@ static int __init pci200_init_module(voi
 		printk(KERN_ERR "pci200syn: Invalid PCI clock frequency\n");
 		return -EINVAL;
 	}
-	return pci_module_init(&pci200_pci_driver);
+	return pci_register_driver(&pci200_pci_driver);
 }
 
 
