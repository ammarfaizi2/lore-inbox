Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261832AbVGJVgn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261832AbVGJVgn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 17:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261836AbVGJTjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 15:39:08 -0400
Received: from mail.suse.de ([195.135.220.2]:8595 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261835AbVGJTfw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 15:35:52 -0400
Date: Sun, 10 Jul 2005 19:35:52 +0000
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org
Subject: [PATCH 44/82] remove linux/version.h from drivers/scsi/mvme16x.c
Message-ID: <20050710193552.44.TLNuEE3442.2247.olh@nectarine.suse.de>
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

drivers/scsi/mvme16x.c |    1 -
1 files changed, 1 deletion(-)

Index: linux-2.6.13-rc2-mm1/drivers/scsi/mvme16x.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/scsi/mvme16x.c
+++ linux-2.6.13-rc2-mm1/drivers/scsi/mvme16x.c
@@ -7,7 +7,6 @@
#include <linux/mm.h>
#include <linux/blkdev.h>
#include <linux/sched.h>
-#include <linux/version.h>

#include <asm/page.h>
#include <asm/pgtable.h>
