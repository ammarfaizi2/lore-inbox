Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933185AbWFXCTk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933185AbWFXCTk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 22:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933186AbWFXCTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 22:19:40 -0400
Received: from ns2.suse.de ([195.135.220.15]:26031 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S933185AbWFXCTj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 22:19:39 -0400
Subject: patch driver-core-fix-driver-core-kernel-doc.patch added to gregkh-2.6 tree
To: rdunlap@xenotime.net, greg@kroah.com, gregkh@suse.de,
       linux-kernel@vger.kernel.org
From: <gregkh@suse.de>
Date: Fri, 23 Jun 2006 19:16:19 -0700
In-Reply-To: <20060622151407.9d7d7664.rdunlap@xenotime.net>
Message-Id: <20060624021932.5F48B77BD93@imap.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a note to let you know that I've just added the patch titled

     Subject: Driver core: fix driver-core kernel-doc

to my gregkh-2.6 tree.  Its filename is

     driver-core-fix-driver-core-kernel-doc.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/


>From rdunlap@xenotime.net Thu Jun 22 15:22:30 2006
Date: Thu, 22 Jun 2006 15:14:07 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: gregkh <greg@kroah.com>
Subject: Driver core: fix driver-core kernel-doc
Message-Id: <20060622151407.9d7d7664.rdunlap@xenotime.net>

From: Randy Dunlap <rdunlap@xenotime.net>

Warning(/var/linsrc/linux-2617-g4//drivers/base/core.c:574): No description found for parameter 'class'
Warning(/var/linsrc/linux-2617-g4//drivers/base/core.c:574): No description found for parameter 'devt'
Warning(/var/linsrc/linux-2617-g4//drivers/base/core.c:626): No description found for parameter 'devt'

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/base/core.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- gregkh-2.6.orig/drivers/base/core.c
+++ gregkh-2.6/drivers/base/core.c
@@ -561,9 +561,9 @@ static void device_create_release(struct
 
 /**
  * device_create - creates a device and registers it with sysfs
- * @cs: pointer to the struct class that this device should be registered to.
+ * @class: pointer to the struct class that this device should be registered to.
  * @parent: pointer to the parent struct device of this new device, if any.
- * @dev: the dev_t for the char device to be added.
+ * @devt: the dev_t for the char device to be added.
  * @fmt: string for the class device's name
  *
  * This function can be used by char device classes.  A struct
@@ -623,7 +623,7 @@ EXPORT_SYMBOL_GPL(device_create);
 /**
  * device_destroy - removes a device that was created with device_create()
  * @class: the pointer to the struct class that this device was registered * with.
- * @dev: the dev_t of the device that was previously registered.
+ * @devt: the dev_t of the device that was previously registered.
  *
  * This call unregisters and cleans up a class device that was created with a
  * call to class_device_create()


Patches currently in gregkh-2.6 which might be from rdunlap@xenotime.net are

driver/driver-core-fix-driver-core-kernel-doc.patch
usb/usb-fix-usb-kernel-doc.patch
