Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965144AbWGFCyI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965144AbWGFCyI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 22:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965140AbWGFCyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 22:54:07 -0400
Received: from xenotime.net ([66.160.160.81]:65449 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S965144AbWGFCyG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 22:54:06 -0400
Date: Wed, 5 Jul 2006 19:56:51 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, len.brown@intel.com
Subject: [PATCH] acpi bus: add missing newline
Message-Id: <20060705195651.4076e7f2.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Add newline so next message won't begin with <6>...

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/acpi/bus.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2617-g25.orig/drivers/acpi/bus.c
+++ linux-2617-g25/drivers/acpi/bus.c
@@ -192,7 +192,7 @@ int acpi_bus_set_power(acpi_handle handl
 	/* Make sure this is a valid target state */
 
 	if (!device->flags.power_manageable) {
-		printk(KERN_DEBUG "Device `[%s]' is not power manageable",
+		printk(KERN_DEBUG "Device `[%s]' is not power manageable\n",
 				device->kobj.name);
 		return -ENODEV;
 	}


---
