Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422867AbWAMTu1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422867AbWAMTu1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 14:50:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422866AbWAMTu1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 14:50:27 -0500
Received: from mail.kroah.org ([69.55.234.183]:35220 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1422867AbWAMTu0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 14:50:26 -0500
Cc: rmk@arm.linux.org.uk
Subject: [PATCH] Remove usb gadget generic driver methods
In-Reply-To: <11371818121681@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 13 Jan 2006 11:50:13 -0800
Message-Id: <11371818131321@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Remove usb gadget generic driver methods

USB gadget drivers make no use of these, remove the pointless
comments.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit d78967fb035aeb839a047ae69ce5f1ff39288a8d
tree e76337604583e4052b8a685223af1d342f40ad19
parent 4031bbe4bbec6c0fe50412ef7fb43a270b0f29f1
author Russell King <rmk@arm.linux.org.uk> Fri, 06 Jan 2006 11:41:32 +0000
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 13 Jan 2006 11:26:11 -0800

 drivers/usb/gadget/ether.c  |    3 ---
 drivers/usb/gadget/inode.c  |    3 ---
 drivers/usb/gadget/serial.c |    3 ---
 drivers/usb/gadget/zero.c   |    3 ---
 4 files changed, 0 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/gadget/ether.c b/drivers/usb/gadget/ether.c
index 8f402f8..afc84cf 100644
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
index c6c279d..9a4edc5 100644
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
index 2e6926b..ba9acd5 100644
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
index 6c58636..2fc110d 100644
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
 

