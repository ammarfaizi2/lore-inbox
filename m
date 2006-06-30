Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932984AbWF3SJF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932984AbWF3SJF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 14:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932987AbWF3SJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 14:09:04 -0400
Received: from havoc.gtf.org ([69.61.125.42]:47779 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S932984AbWF3SJB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 14:09:01 -0400
Date: Fri, 30 Jun 2006 14:08:57 -0400
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, rolandd@cisco.com
Subject: [PATCH] infiniband build fix (devfs-related)
Message-ID: <20060630180857.GA28647@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jeff Garzik <jeff@garzik.org>

diff --git a/drivers/infiniband/ulp/iser/iscsi_iser.c b/drivers/infiniband/ulp/iser/iscsi_iser.c
index 4c3f2de..b2c033e 100644
--- a/drivers/infiniband/ulp/iser/iscsi_iser.c
+++ b/drivers/infiniband/ulp/iser/iscsi_iser.c
@@ -54,7 +54,6 @@ #include <linux/kfifo.h>
 #include <linux/blkdev.h>
 #include <linux/init.h>
 #include <linux/ioctl.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/cdev.h>
 #include <linux/in.h>
 #include <linux/net.h>
