Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262373AbTFJUcz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 16:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262368AbTFJUce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 16:32:34 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:64412 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S263945AbTFJShS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:37:18 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <1055270966860@kroah.com>
Subject: Re: [PATCH] Yet more PCI fixes for 2.5.70
In-Reply-To: <10552709662135@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 10 Jun 2003 11:49:26 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1335, 2003/06/09 15:39:57-07:00, greg@kroah.com

PCI: remove pci_present() from drivers/mtd/devices/pmc551.c


 drivers/mtd/devices/pmc551.c |    5 -----
 1 files changed, 5 deletions(-)


diff -Nru a/drivers/mtd/devices/pmc551.c b/drivers/mtd/devices/pmc551.c
--- a/drivers/mtd/devices/pmc551.c	Tue Jun 10 11:21:13 2003
+++ b/drivers/mtd/devices/pmc551.c	Tue Jun 10 11:21:13 2003
@@ -681,11 +681,6 @@
 
         printk(KERN_INFO PMC551_VERSION);
 
-        if(!pci_present()) {
-                printk(KERN_NOTICE "pmc551: PCI not enabled.\n");
-                return -ENODEV;
-        }
-
         /*
          * PCU-bus chipset probe.
          */

