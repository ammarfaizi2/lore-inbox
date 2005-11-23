Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751160AbVKWXrU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbVKWXrU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 18:47:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbVKWXqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 18:46:47 -0500
Received: from mail.kroah.org ([69.55.234.183]:19906 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751322AbVKWXqa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 18:46:30 -0500
Date: Wed, 23 Nov 2005 15:45:53 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       rdunlap@xenotime.net
Subject: [patch 21/22] USB: kernel-doc for linux/usb.h
Message-ID: <20051123234553.GV527@kroah.com>
References: <20051123225156.624397000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="usb-kernel-doc-for-linux-usb.h.patch"
In-Reply-To: <20051123234335.GA527@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Fix kernel-doc warning in linux/usb.h.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 include/linux/usb.h |    1 +
 1 file changed, 1 insertion(+)

--- usb-2.6.orig/include/linux/usb.h
+++ usb-2.6/include/linux/usb.h
@@ -47,6 +47,7 @@ struct usb_driver;
  * @urb_list: urbs queued to this endpoint; maintained by usbcore
  * @hcpriv: for use by HCD; typically holds hardware dma queue head (QH)
  *	with one or more transfer descriptors (TDs) per urb
+ * @kobj: kobject for sysfs info
  * @extra: descriptors following this endpoint in the configuration
  * @extralen: how many bytes of "extra" are valid
  *

--
