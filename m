Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261203AbULAASW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261203AbULAASW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 19:18:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261210AbULAARN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 19:17:13 -0500
Received: from mail.kroah.org ([69.55.234.183]:40420 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261225AbULAAOT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 19:14:19 -0500
X-Fake: the user-agent is fake
Subject: Re: [PATCH] More PCI fixes for 2.6.10-rc2
User-Agent: Mutt/1.5.6i
In-Reply-To: <11018598032113@kroah.com>
Date: Tue, 30 Nov 2004 16:10:04 -0800
Message-Id: <1101859804222@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2223.2.2, 2004/11/24 14:44:11-08:00, greg@kroah.com

[PATCH] PCI Hotplug: fix warning compile issue in cpqphp driver

As pointed out by "O.Sezer" <sezeroz@ttnet.net.tr> in a patch to 2.4

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/hotplug/cpqphp_pci.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/pci/hotplug/cpqphp_pci.c b/drivers/pci/hotplug/cpqphp_pci.c
--- a/drivers/pci/hotplug/cpqphp_pci.c	2004-11-30 15:47:24 -08:00
+++ b/drivers/pci/hotplug/cpqphp_pci.c	2004-11-30 15:47:24 -08:00
@@ -194,7 +194,7 @@
 
 static int PCI_ScanBusForNonBridge(struct controller *ctrl, u8 bus_num, u8 * dev_num)
 {
-	u8 tdevice;
+	u16 tdevice;
 	u32 work;
 	u8 tbus;
 

