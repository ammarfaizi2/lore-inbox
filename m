Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261898AbVGJTnZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261898AbVGJTnZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 15:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261919AbVGJTmK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 15:42:10 -0400
Received: from ns.suse.de ([195.135.220.2]:12691 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261915AbVGJTgA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 15:36:00 -0400
Date: Sun, 10 Jul 2005 19:36:00 +0000
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org
Subject: [PATCH 52/82] remove linux/version.h from drivers/scsi/wd33c93.c
Message-ID: <20050710193600.52.wrYWPC3654.2247.olh@nectarine.suse.de>
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

drivers/scsi/wd33c93.c |    1 -
1 files changed, 1 deletion(-)

Index: linux-2.6.13-rc2-mm1/drivers/scsi/wd33c93.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/scsi/wd33c93.c
+++ linux-2.6.13-rc2-mm1/drivers/scsi/wd33c93.c
@@ -77,7 +77,6 @@
#include <linux/sched.h>
#include <linux/string.h>
#include <linux/delay.h>
-#include <linux/version.h>
#include <linux/init.h>
#include <linux/blkdev.h>
#include <asm/irq.h>
