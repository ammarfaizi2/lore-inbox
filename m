Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261831AbVGJVgm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261831AbVGJVgm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 17:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261835AbVGJTjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 15:39:11 -0400
Received: from ns2.suse.de ([195.135.220.15]:43996 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261832AbVGJTfw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 15:35:52 -0400
Date: Sun, 10 Jul 2005 19:35:51 +0000
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org
Subject: [PATCH 43/82] remove linux/version.h from drivers/scsi/mvme147.c
Message-ID: <20050710193551.43.ZznDmV3416.2247.olh@nectarine.suse.de>
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

drivers/scsi/mvme147.c |    1 -
1 files changed, 1 deletion(-)

Index: linux-2.6.13-rc2-mm1/drivers/scsi/mvme147.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/scsi/mvme147.c
+++ linux-2.6.13-rc2-mm1/drivers/scsi/mvme147.c
@@ -2,7 +2,6 @@
#include <linux/mm.h>
#include <linux/blkdev.h>
#include <linux/sched.h>
-#include <linux/version.h>
#include <linux/interrupt.h>

#include <asm/page.h>
