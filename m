Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751402AbWAZUNI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402AbWAZUNI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 15:13:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbWAZUNH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 15:13:07 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:8116 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751402AbWAZUNH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 15:13:07 -0500
From: Pat Gefre <pfg@sgi.com>
Message-Id: <200601262013.k0QKD4tk027106@fsgi900.americas.sgi.com>
Subject: [PATCH] 2.6 Altix : correct export call
To: linux-kernel@vger.kernel.org
Date: Thu, 26 Jan 2006 14:13:04 -0600 (CST)
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Call EXPORT_SYMBOL_GPL in ioc3 shim layer.


Signed-off-by: Patrick Gefre <pfg@sgi.com>



 ioc3.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)


Index: linux/drivers/sn/ioc3.c
===================================================================
--- linux.orig/drivers/sn/ioc3.c	2006-01-26 10:46:30.201721192 -0600
+++ linux/drivers/sn/ioc3.c	2006-01-26 11:53:34.685090381 -0600
@@ -843,9 +843,9 @@
 MODULE_DESCRIPTION("PCI driver for SGI IOC3");
 MODULE_LICENSE("GPL");
 
-EXPORT_SYMBOL(ioc3_register_submodule);
-EXPORT_SYMBOL(ioc3_unregister_submodule);
-EXPORT_SYMBOL(ioc3_ack);
-EXPORT_SYMBOL(ioc3_gpcr_set);
-EXPORT_SYMBOL(ioc3_disable);
-EXPORT_SYMBOL(ioc3_enable);
+EXPORT_SYMBOL_GPL(ioc3_register_submodule);
+EXPORT_SYMBOL_GPL(ioc3_unregister_submodule);
+EXPORT_SYMBOL_GPL(ioc3_ack);
+EXPORT_SYMBOL_GPL(ioc3_gpcr_set);
+EXPORT_SYMBOL_GPL(ioc3_disable);
+EXPORT_SYMBOL_GPL(ioc3_enable);
