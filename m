Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261788AbVGJV1v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261788AbVGJV1v (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 17:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261792AbVGJTjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 15:39:37 -0400
Received: from ns.suse.de ([195.135.220.2]:3987 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261788AbVGJTfm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 15:35:42 -0400
Date: Sun, 10 Jul 2005 19:35:42 +0000
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org
Subject: [PATCH 34/82] remove linux/version.h from drivers/scsi/bvme6000.c
Message-ID: <20050710193542.34.GTlMMS3178.2247.olh@nectarine.suse.de>
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

drivers/scsi/bvme6000.c |    1 -
1 files changed, 1 deletion(-)

Index: linux-2.6.13-rc2-mm1/drivers/scsi/bvme6000.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/scsi/bvme6000.c
+++ linux-2.6.13-rc2-mm1/drivers/scsi/bvme6000.c
@@ -7,7 +7,6 @@
#include <linux/mm.h>
#include <linux/blkdev.h>
#include <linux/sched.h>
-#include <linux/version.h>
#include <linux/zorro.h>

#include <asm/setup.h>
