Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264033AbUDNKik (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 06:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264034AbUDNKik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 06:38:40 -0400
Received: from postfix4-2.free.fr ([213.228.0.176]:19350 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S264033AbUDNKhy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 06:37:54 -0400
From: Duncan Sands <baldrick@free.fr>
To: Greg KH <greg@kroah.com>
Subject: [PATCH 3/9] USB usbfs: remove obsolete comment from proc_resetdevice
Date: Wed, 14 Apr 2004 12:37:52 +0200
User-Agent: KMail/1.5.4
Cc: linux-usb-devel@lists.sf.net, linux-kernel@vger.kernel.org,
       Frederic Detienne <fd@cisco.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404141237.52037.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 devio.c |    3 ---
 1 files changed, 3 deletions(-)


diff -Nru a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
--- a/drivers/usb/core/devio.c	Wed Apr 14 12:17:37 2004
+++ b/drivers/usb/core/devio.c	Wed Apr 14 12:17:37 2004
@@ -730,9 +730,6 @@
 
 static int proc_resetdevice(struct dev_state *ps)
 {
-	/* FIXME when usb_reset_device() is fixed we'll need to grab
-	 * ps->dev->serialize before calling it.
-	 */
 	return usb_reset_device(ps->dev);
 
 }
