Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750932AbWAaXEc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750932AbWAaXEc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 18:04:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750933AbWAaXEc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 18:04:32 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:12480 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750925AbWAaXEc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 18:04:32 -0500
From: Pat Gefre <pfg@sgi.com>
Message-Id: <200601312304.k0VN4Pnp044804@fsgi900.americas.sgi.com>
Subject: [PATCH] 2.6 Altix : correct export call
To: akpm@osdl.org
Date: Tue, 31 Jan 2006 17:04:25 -0600 (CST)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

I didn't get any resistence to this - so guessing these are the correct
macro calls...



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
