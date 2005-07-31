Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261728AbVGaFvy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261728AbVGaFvy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 01:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261737AbVGaFvx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 01:51:53 -0400
Received: from mx1.redhat.com ([66.187.233.31]:4073 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261728AbVGaFvt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 01:51:49 -0400
Date: Sat, 30 Jul 2005 22:51:45 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: greg@kroah.com
Cc: zaitcev@redhat.com, linux-kernel@vger.kernel.org
Subject: 2.6.13 ub 2/3: Fold one line
Message-Id: <20050730225145.4b99ecd0.zaitcev@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.0beta3 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evidently, Yani Ioannou's display is wider than mine.

Signed-off-by: Pete Zaitcev <zaitcev@yahoo.com>

--- linux-2.6.13-rc4-4seg/drivers/block/ub.c	2005-07-30 22:19:55.000000000 -0700
+++ linux-2.6.13-rc4-lem/drivers/block/ub.c	2005-07-29 22:42:00.000000000 -0700
@@ -516,7 +516,8 @@ static void ub_cmdtr_sense(struct ub_dev
 	}
 }
 
-static ssize_t ub_diag_show(struct device *dev, struct device_attribute *attr, char *page)
+static ssize_t ub_diag_show(struct device *dev, struct device_attribute *attr,
+    char *page)
 {
 	struct usb_interface *intf;
 	struct ub_dev *sc;
