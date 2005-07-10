Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262058AbVGJWyW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262058AbVGJWyW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 18:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262070AbVGJTin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 15:38:43 -0400
Received: from mx1.suse.de ([195.135.220.2]:10387 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261849AbVGJTf5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 15:35:57 -0400
Date: Sun, 10 Jul 2005 19:35:57 +0000
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org
Subject: [PATCH 49/82] remove linux/version.h from drivers/scsi/scsi_debug.c
Message-ID: <20050710193557.49.eHfyeO3572.2247.olh@nectarine.suse.de>
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

drivers/scsi/scsi_debug.c |    4 ----
1 files changed, 4 deletions(-)

Index: linux-2.6.13-rc2-mm1/drivers/scsi/scsi_debug.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/scsi/scsi_debug.c
+++ linux-2.6.13-rc2-mm1/drivers/scsi/scsi_debug.c
@@ -48,10 +48,6 @@

#include <linux/stat.h>

-#ifndef LINUX_VERSION_CODE
-#include <linux/version.h>
-#endif
-
#include "scsi_logging.h"
#include "scsi_debug.h"

