Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262077AbVGJVgm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262077AbVGJVgm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 17:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261832AbVGJTjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 15:39:13 -0400
Received: from ns2.suse.de ([195.135.220.15]:43228 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261831AbVGJTfv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 15:35:51 -0400
Date: Sun, 10 Jul 2005 19:35:50 +0000
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org
Subject: [PATCH 42/82] remove linux/version.h from drivers/scsi/megaraid
Message-ID: <20050710193550.42.tKRWic3388.2247.olh@nectarine.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
In-Reply-To: <20050710193508.0.PmFpst2252.2247.olh@nectarine.suse.de>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


changing CONFIG_LOCALVERSION rebuilds too much, for no appearent reason.

Signed-off-by: Olaf Hering <olh@suse.de>

drivers/scsi/megaraid/mega_common.h |    1 -
drivers/scsi/megaraid/megaraid_mm.h |    1 -
2 files changed, 2 deletions(-)

Index: linux-2.6.13-rc2-mm1/drivers/scsi/megaraid/mega_common.h
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/scsi/megaraid/mega_common.h
+++ linux-2.6.13-rc2-mm1/drivers/scsi/megaraid/mega_common.h
@@ -25,7 +25,6 @@
#include <linux/delay.h>
#include <linux/blkdev.h>
#include <linux/list.h>
-#include <linux/version.h>
#include <linux/moduleparam.h>
#include <linux/dma-mapping.h>
#include <asm/semaphore.h>
Index: linux-2.6.13-rc2-mm1/drivers/scsi/megaraid/megaraid_mm.h
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/scsi/megaraid/megaraid_mm.h
+++ linux-2.6.13-rc2-mm1/drivers/scsi/megaraid/megaraid_mm.h
@@ -18,7 +18,6 @@
#include <linux/spinlock.h>
#include <linux/fs.h>
#include <asm/uaccess.h>
-#include <linux/version.h>
#include <linux/module.h>
#include <linux/moduleparam.h>
#include <linux/pci.h>
