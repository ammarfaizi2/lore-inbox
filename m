Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261895AbVAHH1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261895AbVAHH1F (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 02:27:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261972AbVAHHZe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 02:25:34 -0500
Received: from mail.kroah.org ([69.55.234.183]:61573 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261895AbVAHFsb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:31 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <11051632593220@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:39 -0800
Message-Id: <11051632592320@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.444.5, 2004/12/15 11:15:47-08:00, greg@kroah.com

[PATCH] misc: remove miscdevice.h from pci hotplug drivers as they do not need it.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/hotplug/pciehp_core.c |    1 -
 drivers/pci/hotplug/shpchp_core.c |    1 -
 2 files changed, 2 deletions(-)


diff -Nru a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
--- a/drivers/pci/hotplug/pciehp_core.c	2005-01-07 15:51:36 -08:00
+++ b/drivers/pci/hotplug/pciehp_core.c	2005-01-07 15:51:36 -08:00
@@ -33,7 +33,6 @@
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/proc_fs.h>
-#include <linux/miscdevice.h>
 #include <linux/slab.h>
 #include <linux/workqueue.h>
 #include <linux/pci.h>
diff -Nru a/drivers/pci/hotplug/shpchp_core.c b/drivers/pci/hotplug/shpchp_core.c
--- a/drivers/pci/hotplug/shpchp_core.c	2005-01-07 15:51:36 -08:00
+++ b/drivers/pci/hotplug/shpchp_core.c	2005-01-07 15:51:36 -08:00
@@ -33,7 +33,6 @@
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/proc_fs.h>
-#include <linux/miscdevice.h>
 #include <linux/slab.h>
 #include <linux/workqueue.h>
 #include <linux/pci.h>

