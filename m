Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261824AbVFSOlM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261824AbVFSOlM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Jun 2005 10:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262209AbVFSOlM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Jun 2005 10:41:12 -0400
Received: from mo00.iij4u.or.jp ([210.130.0.19]:35299 "EHLO mo00.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S261824AbVFSOlJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Jun 2005 10:41:09 -0400
Date: Sun, 19 Jun 2005 23:41:01 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: yuasa@hh.iij4u.or.jp, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.12] usb: Makefile update for SISUSBVGA
Message-Id: <20050619234101.2c6d0cc2.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following Makefile update is needed for SISUSBVGA.
Please apply.

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff --git a/drivers/usb/Makefile b/drivers/usb/Makefile
--- a/drivers/usb/Makefile
+++ b/drivers/usb/Makefile
@@ -69,6 +69,7 @@ obj-$(CONFIG_USB_RIO500)	+= misc/
 obj-$(CONFIG_USB_TEST)		+= misc/
 obj-$(CONFIG_USB_USS720)	+= misc/
 obj-$(CONFIG_USB_PHIDGETSERVO)	+= misc/
+obj-$(CONFIG_USB_SISUSBVGA)	+= misc/
 
 obj-$(CONFIG_USB_ATM)		+= atm/
 obj-$(CONFIG_USB_SPEEDTOUCH)	+= atm/


