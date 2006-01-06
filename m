Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932433AbWAFLlk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932433AbWAFLlk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 06:41:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932434AbWAFLlk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 06:41:40 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:41997 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932433AbWAFLli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 06:41:38 -0500
To: LKML <linux-kernel@vger.kernel.org>
CC: Greg K-H <greg@kroah.com>, IDE <linux-usb@vger.kernel.org>
Subject: [CFT 2/3] Remove usb gadget generic driver methods
Date: Fri, 06 Jan 2006 11:41:32 +0000
Message-ID: <20060106114059.13.31@flint.arm.linux.org.uk>
In-reply-to: <20060105142951.13.01@flint.arm.linux.org.uk>
References: <20060105142951.13.01@flint.arm.linux.org.uk>
From: Russell King <rmk@arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

USB gadget drivers make no use of these, remove the pointless
comments.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

(This is an additional patch - on lkml, see
 "[CFT 1/29] Add bus_type probe, remove, shutdown methods.")

---
 drivers/usb/gadget/ether.c  |    3 ---
 drivers/usb/gadget/inode.c  |    3 ---
 drivers/usb/gadget/serial.c |    3 ---
 drivers/usb/gadget/zero.c   |    3 ---
 4 files changed, 12 deletions(-)

diff --git a/drivers/usb/gadget/ether.c b/drivers/usb/gadget/ether.c
--- a/drivers/usb/gadget/ether.c
+++ b/drivers/usb/gadget/ether.c
@@ -2534,9 +2534,6 @@ static struct usb_gadget_driver eth_driv
 	.driver 	= {
 		.name		= (char *) shortname,
 		.owner		= THIS_MODULE,
-		// .shutdown = ...
-		// .suspend = ...
-		// .resume = ...
 	},
 };
 
diff --git a/drivers/usb/gadget/inode.c b/drivers/usb/gadget/inode.c
--- a/drivers/usb/gadget/inode.c
+++ b/drivers/usb/gadget/inode.c
@@ -1738,9 +1738,6 @@ static struct usb_gadget_driver gadgetfs
 
 	.driver 	= {
 		.name		= (char *) shortname,
-		// .shutdown = ...
-		// .suspend = ...
-		// .resume = ...
 	},
 };
 
diff --git a/drivers/usb/gadget/serial.c b/drivers/usb/gadget/serial.c
--- a/drivers/usb/gadget/serial.c
+++ b/drivers/usb/gadget/serial.c
@@ -374,9 +374,6 @@ static struct usb_gadget_driver gs_gadge
 	.disconnect =		gs_disconnect,
 	.driver = {
 		.name =		GS_SHORT_NAME,
-		/* .shutdown = ... */
-		/* .suspend = ...  */
-		/* .resume = ...   */
 	},
 };
 
diff --git a/drivers/usb/gadget/zero.c b/drivers/usb/gadget/zero.c
--- a/drivers/usb/gadget/zero.c
+++ b/drivers/usb/gadget/zero.c
@@ -1303,9 +1303,6 @@ static struct usb_gadget_driver zero_dri
 	.driver 	= {
 		.name		= (char *) shortname,
 		.owner		= THIS_MODULE,
-		// .shutdown = ...
-		// .suspend = ...
-		// .resume = ...
 	},
 };
 
