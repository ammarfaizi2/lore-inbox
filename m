Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269790AbUJSQwD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269790AbUJSQwD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 12:52:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269793AbUJSQva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 12:51:30 -0400
Received: from mail.kroah.org ([69.55.234.183]:54468 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269791AbUJSQir convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 12:38:47 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.9
In-Reply-To: <10982037903268@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Tue, 19 Oct 2004 09:36:33 -0700
Message-Id: <109820379375@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1946.10.3, 2004/09/24 11:44:27-07:00, mochel@digitalimplant.org

[driver model] Change symbol exports to GPL only in core.c

Signed-off-by: Patrick Mochel <mochel@digitalimplant.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/base/core.c |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)


diff -Nru a/drivers/base/core.c b/drivers/base/core.c
--- a/drivers/base/core.c	2004-10-19 09:22:03 -07:00
+++ b/drivers/base/core.c	2004-10-19 09:22:03 -07:00
@@ -401,17 +401,17 @@
 	return subsystem_register(&devices_subsys);
 }
 
-EXPORT_SYMBOL(device_for_each_child);
+EXPORT_SYMBOL_GPL(device_for_each_child);
 
-EXPORT_SYMBOL(device_initialize);
-EXPORT_SYMBOL(device_add);
-EXPORT_SYMBOL(device_register);
+EXPORT_SYMBOL_GPL(device_initialize);
+EXPORT_SYMBOL_GPL(device_add);
+EXPORT_SYMBOL_GPL(device_register);
 
-EXPORT_SYMBOL(device_del);
-EXPORT_SYMBOL(device_unregister);
-EXPORT_SYMBOL(get_device);
-EXPORT_SYMBOL(put_device);
-EXPORT_SYMBOL(device_find);
+EXPORT_SYMBOL_GPL(device_del);
+EXPORT_SYMBOL_GPL(device_unregister);
+EXPORT_SYMBOL_GPL(get_device);
+EXPORT_SYMBOL_GPL(put_device);
+EXPORT_SYMBOL_GPL(device_find);
 
-EXPORT_SYMBOL(device_create_file);
-EXPORT_SYMBOL(device_remove_file);
+EXPORT_SYMBOL_GPL(device_create_file);
+EXPORT_SYMBOL_GPL(device_remove_file);

