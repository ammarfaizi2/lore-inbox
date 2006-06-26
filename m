Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964861AbWFZIb6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964861AbWFZIb6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 04:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964930AbWFZIb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 04:31:58 -0400
Received: from havoc.gtf.org ([69.61.125.42]:13233 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S964861AbWFZIb5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 04:31:57 -0400
Date: Mon, 26 Jun 2006 04:31:55 -0400
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, jayakumar.video@gmail.com,
       mchehab@infradead.org
Subject: [PATCH] quickcam messenger build fix
Message-ID: <20060626083155.GA29923@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fix build by fixing obvious typo in #include.

Signed-off-by: Jeff Garzik <jeff@garzik.org>

diff --git a/drivers/media/video/usbvideo/quickcam_messenger.c b/drivers/media/video/usbvideo/quickcam_messenger.c
index 3f3182a..56e01b6 100644
--- a/drivers/media/video/usbvideo/quickcam_messenger.c
+++ b/drivers/media/video/usbvideo/quickcam_messenger.c
@@ -33,7 +33,7 @@ #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/input.h>
-#include <linux/usb_input.h>
+#include <linux/usb/input.h>
 
 #include "usbvideo.h"
 #include "quickcam_messenger.h"
