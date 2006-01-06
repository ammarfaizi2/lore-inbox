Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932579AbWAFC2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932579AbWAFC2N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 21:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932597AbWAFC2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 21:28:13 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:54494 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S932579AbWAFC2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 21:28:12 -0500
Date: Fri, 6 Jan 2006 11:28:09 +0900
To: jejb@steeleye.com
Cc: linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: [PATCH] mca: delete unreached line
Message-ID: <20060106022809.GA18912@miraclelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: mita@miraclelinux.com (Akinobu Mita)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is this a misprint?

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>

--- 2.6-rc/drivers/mca/mca-device.c.orig	2005-12-09 15:29:26.000000000 +0800
+++ 2.6-rc/drivers/mca/mca-device.c	2005-12-09 15:29:42.000000000 +0800
@@ -65,8 +65,6 @@ unsigned char mca_device_read_pos(struct
 	struct mca_bus *mca_bus = to_mca_bus(mca_dev->dev.parent);
 
 	return mca_bus->f.mca_read_pos(mca_dev, reg);
-
-	return 	mca_dev->pos[reg];
 }
 EXPORT_SYMBOL(mca_device_read_pos);
 
