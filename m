Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262849AbTHURjM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 13:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262844AbTHURbP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 13:31:15 -0400
Received: from mail.kroah.org ([65.200.24.183]:12742 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262847AbTHURbA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 13:31:00 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10614870692308@kroah.com>
Subject: Re: [PATCH] PCI fixes for 2.6.0-test3
In-Reply-To: <10614870691817@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 21 Aug 2003 10:31:09 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1123.21.4, 2003/08/20 15:57:41-07:00, greg@kroah.com

[PATCH] PCI: remove #include <linux/miscdevice.h> from some pci hotplug drivers.

It's not needed.


 drivers/pci/hotplug/cpqphp_core.c  |    1 -
 drivers/pci/hotplug/cpqphp_nvram.c |    1 -
 2 files changed, 2 deletions(-)


diff -Nru a/drivers/pci/hotplug/cpqphp_core.c b/drivers/pci/hotplug/cpqphp_core.c
--- a/drivers/pci/hotplug/cpqphp_core.c	Thu Aug 21 10:22:08 2003
+++ b/drivers/pci/hotplug/cpqphp_core.c	Thu Aug 21 10:22:08 2003
@@ -34,7 +34,6 @@
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/proc_fs.h>
-#include <linux/miscdevice.h>
 #include <linux/slab.h>
 #include <linux/workqueue.h>
 #include <linux/pci.h>
diff -Nru a/drivers/pci/hotplug/cpqphp_nvram.c b/drivers/pci/hotplug/cpqphp_nvram.c
--- a/drivers/pci/hotplug/cpqphp_nvram.c	Thu Aug 21 10:22:08 2003
+++ b/drivers/pci/hotplug/cpqphp_nvram.c	Thu Aug 21 10:22:08 2003
@@ -31,7 +31,6 @@
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/proc_fs.h>
-#include <linux/miscdevice.h>
 #include <linux/slab.h>
 #include <linux/workqueue.h>
 #include <linux/pci.h>

