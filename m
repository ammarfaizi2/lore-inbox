Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261577AbVCFXrF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261577AbVCFXrF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 18:47:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261573AbVCFXrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 18:47:05 -0500
Received: from coderock.org ([193.77.147.115]:1968 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261577AbVCFWhO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 17:37:14 -0500
Subject: [patch 13/14] drivers/eisa/*: convert to pci_register_driver
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, c.lucas@ifrance.com
From: domen@coderock.org
Date: Sun, 06 Mar 2005 23:36:57 +0100
Message-Id: <20050306223657.5DB421F202@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


convert from pci_module_init to pci_register_driver

Signed-off-by: Christophe Lucas <c.lucas@ifrance.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/eisa/pci_eisa.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/eisa/pci_eisa.c~pci_register_driver-drivers_eisa drivers/eisa/pci_eisa.c
--- kj/drivers/eisa/pci_eisa.c~pci_register_driver-drivers_eisa	2005-03-05 16:12:19.000000000 +0100
+++ kj-domen/drivers/eisa/pci_eisa.c	2005-03-05 16:12:19.000000000 +0100
@@ -59,7 +59,7 @@ static struct pci_driver pci_eisa_driver
 
 static int __init pci_eisa_init_module (void)
 {
-	return pci_module_init (&pci_eisa_driver);
+	return pci_register_driver (&pci_eisa_driver);
 }
 
 device_initcall(pci_eisa_init_module);
_
