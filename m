Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269966AbUJVHr4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269966AbUJVHr4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 03:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269846AbUJSQpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 12:45:42 -0400
Received: from mail.kroah.org ([69.55.234.183]:57540 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269800AbUJSQit convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 12:38:49 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.9
In-Reply-To: <1098203788346@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Tue, 19 Oct 2004 09:36:31 -0700
Message-Id: <10982037903268@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1946.10.2, 2004/09/24 11:43:50-07:00, mochel@digitalimplant.org

[driver model] Change sybmols exports to GPL only in class.c

Signed-off-by: Patrick Mochel <mochel@digitalimplant.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/base/class.c |   34 +++++++++++++++++-----------------
 1 files changed, 17 insertions(+), 17 deletions(-)


diff -Nru a/drivers/base/class.c b/drivers/base/class.c
--- a/drivers/base/class.c	2004-10-19 09:22:08 -07:00
+++ b/drivers/base/class.c	2004-10-19 09:22:08 -07:00
@@ -528,22 +528,22 @@
 	return 0;
 }
 
-EXPORT_SYMBOL(class_create_file);
-EXPORT_SYMBOL(class_remove_file);
-EXPORT_SYMBOL(class_register);
-EXPORT_SYMBOL(class_unregister);
-EXPORT_SYMBOL(class_get);
-EXPORT_SYMBOL(class_put);
+EXPORT_SYMBOL_GPL(class_create_file);
+EXPORT_SYMBOL_GPL(class_remove_file);
+EXPORT_SYMBOL_GPL(class_register);
+EXPORT_SYMBOL_GPL(class_unregister);
+EXPORT_SYMBOL_GPL(class_get);
+EXPORT_SYMBOL_GPL(class_put);
 
-EXPORT_SYMBOL(class_device_register);
-EXPORT_SYMBOL(class_device_unregister);
-EXPORT_SYMBOL(class_device_initialize);
-EXPORT_SYMBOL(class_device_add);
-EXPORT_SYMBOL(class_device_del);
-EXPORT_SYMBOL(class_device_get);
-EXPORT_SYMBOL(class_device_put);
-EXPORT_SYMBOL(class_device_create_file);
-EXPORT_SYMBOL(class_device_remove_file);
+EXPORT_SYMBOL_GPL(class_device_register);
+EXPORT_SYMBOL_GPL(class_device_unregister);
+EXPORT_SYMBOL_GPL(class_device_initialize);
+EXPORT_SYMBOL_GPL(class_device_add);
+EXPORT_SYMBOL_GPL(class_device_del);
+EXPORT_SYMBOL_GPL(class_device_get);
+EXPORT_SYMBOL_GPL(class_device_put);
+EXPORT_SYMBOL_GPL(class_device_create_file);
+EXPORT_SYMBOL_GPL(class_device_remove_file);
 
-EXPORT_SYMBOL(class_interface_register);
-EXPORT_SYMBOL(class_interface_unregister);
+EXPORT_SYMBOL_GPL(class_interface_register);
+EXPORT_SYMBOL_GPL(class_interface_unregister);

