Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269146AbUJVGbZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269146AbUJVGbZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 02:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269784AbUJSQyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 12:54:05 -0400
Received: from mail.kroah.org ([69.55.234.183]:52164 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269783AbUJSQip convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 12:38:45 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.9
In-Reply-To: <10982037861198@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Tue, 19 Oct 2004 09:36:28 -0700
Message-Id: <1098203788346@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1946.10.1, 2004/09/24 11:43:03-07:00, mochel@digitalimplant.org

[driver model] Change symbol exports to GPL only in drivers/base/bus.c.

Signed-off-by: Patrick Mochel <mochel@digitalimplant.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/base/bus.c |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)


diff -Nru a/drivers/base/bus.c b/drivers/base/bus.c
--- a/drivers/base/bus.c	2004-10-19 09:22:13 -07:00
+++ b/drivers/base/bus.c	2004-10-19 09:22:13 -07:00
@@ -721,20 +721,20 @@
 }
 
 
-EXPORT_SYMBOL(bus_for_each_dev);
-EXPORT_SYMBOL(bus_for_each_drv);
+EXPORT_SYMBOL_GPL(bus_for_each_dev);
+EXPORT_SYMBOL_GPL(bus_for_each_drv);
 
-EXPORT_SYMBOL(device_bind_driver);
-EXPORT_SYMBOL(device_release_driver);
+EXPORT_SYMBOL_GPL(device_bind_driver);
+EXPORT_SYMBOL_GPL(device_release_driver);
 
-EXPORT_SYMBOL(bus_add_device);
-EXPORT_SYMBOL(bus_remove_device);
-EXPORT_SYMBOL(bus_register);
-EXPORT_SYMBOL(bus_unregister);
-EXPORT_SYMBOL(bus_rescan_devices);
-EXPORT_SYMBOL(get_bus);
-EXPORT_SYMBOL(put_bus);
-EXPORT_SYMBOL(find_bus);
+EXPORT_SYMBOL_GPL(bus_add_device);
+EXPORT_SYMBOL_GPL(bus_remove_device);
+EXPORT_SYMBOL_GPL(bus_register);
+EXPORT_SYMBOL_GPL(bus_unregister);
+EXPORT_SYMBOL_GPL(bus_rescan_devices);
+EXPORT_SYMBOL_GPL(get_bus);
+EXPORT_SYMBOL_GPL(put_bus);
+EXPORT_SYMBOL_GPL(find_bus);
 
-EXPORT_SYMBOL(bus_create_file);
-EXPORT_SYMBOL(bus_remove_file);
+EXPORT_SYMBOL_GPL(bus_create_file);
+EXPORT_SYMBOL_GPL(bus_remove_file);

