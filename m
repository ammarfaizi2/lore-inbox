Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964974AbWFZB1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964974AbWFZB1K (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 21:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964981AbWFZB1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 21:27:10 -0400
Received: from xenotime.net ([66.160.160.81]:64741 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S964974AbWFZB1I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 21:27:08 -0400
Date: Sun, 25 Jun 2006 18:29:54 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, mchehab@infradead.org
Subject: [PATCH] fix quickcam messenger build (git9)
Message-Id: <20060625182954.a557ffbd.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

header filename changed:
drivers/media/video/usbvideo/quickcam_messenger.c:36:11: error: unable to open 'linux/usb_input.h'

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/media/video/usbvideo/quickcam_messenger.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2617-g9.orig/drivers/media/video/usbvideo/quickcam_messenger.c
+++ linux-2617-g9/drivers/media/video/usbvideo/quickcam_messenger.c
@@ -33,7 +33,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/input.h>
-#include <linux/usb_input.h>
+#include <linux/usb/input.h>
 
 #include "usbvideo.h"
 #include "quickcam_messenger.h"


---
