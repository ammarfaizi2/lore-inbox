Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263154AbUCSXlJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 18:41:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263149AbUCSXgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 18:36:06 -0500
Received: from mail.kroah.org ([65.200.24.183]:37071 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263150AbUCSXc2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 18:32:28 -0500
Subject: Re: [PATCH] PCI and PCI Hotplug fixes for 2.6.5-rc1
In-Reply-To: <1079739131618@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 19 Mar 2004 15:32:11 -0800
Message-Id: <10797391312346@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1608.97.4, 2004/03/10 14:23:37-08:00, greg@kroah.com

[PATCH] PCI Hotplug: fix compiler warning in acpiphp driver


 drivers/pci/hotplug/acpiphp_pci.c |    1 -
 1 files changed, 1 deletion(-)


diff -Nru a/drivers/pci/hotplug/acpiphp_pci.c b/drivers/pci/hotplug/acpiphp_pci.c
--- a/drivers/pci/hotplug/acpiphp_pci.c	Fri Mar 19 15:21:21 2004
+++ b/drivers/pci/hotplug/acpiphp_pci.c	Fri Mar 19 15:21:21 2004
@@ -488,7 +488,6 @@
 void acpiphp_unconfigure_function (struct acpiphp_func *func)
 {
 	struct acpiphp_bridge *bridge;
-	int retval = 0;
 
 	/* if pci_dev is NULL, ignore it */
 	if (!func->pci_dev)

