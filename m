Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269795AbUJVHNE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269795AbUJVHNE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 03:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269796AbUJSQu4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 12:50:56 -0400
Received: from mail.kroah.org ([69.55.234.183]:55748 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269795AbUJSQis convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 12:38:48 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.9
In-Reply-To: <1098203797223@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Tue, 19 Oct 2004 09:36:39 -0700
Message-Id: <10982037992819@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1946.10.6, 2004/09/24 11:46:32-07:00, mochel@digitalimplant.org

[driver model] Change symbol exports to GPL only in platform.c.

Signed-off-by: Patrick Mochel <mochel@digitalimplant.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/base/platform.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)


diff -Nru a/drivers/base/platform.c b/drivers/base/platform.c
--- a/drivers/base/platform.c	2004-10-19 09:21:48 -07:00
+++ b/drivers/base/platform.c	2004-10-19 09:21:48 -07:00
@@ -298,13 +298,13 @@
 	}
 	return mask & *dev->dma_mask;
 }
-EXPORT_SYMBOL(dma_get_required_mask);
+EXPORT_SYMBOL_GPL(dma_get_required_mask);
 #endif
 
-EXPORT_SYMBOL(platform_bus);
-EXPORT_SYMBOL(platform_bus_type);
-EXPORT_SYMBOL(platform_device_register);
-EXPORT_SYMBOL(platform_device_register_simple);
-EXPORT_SYMBOL(platform_device_unregister);
-EXPORT_SYMBOL(platform_get_irq);
-EXPORT_SYMBOL(platform_get_resource);
+EXPORT_SYMBOL_GPL(platform_bus);
+EXPORT_SYMBOL_GPL(platform_bus_type);
+EXPORT_SYMBOL_GPL(platform_device_register);
+EXPORT_SYMBOL_GPL(platform_device_register_simple);
+EXPORT_SYMBOL_GPL(platform_device_unregister);
+EXPORT_SYMBOL_GPL(platform_get_irq);
+EXPORT_SYMBOL_GPL(platform_get_resource);

