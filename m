Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261784AbVGJV1u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbVGJV1u (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 17:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261788AbVGJTjj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 15:39:39 -0400
Received: from ns2.suse.de ([195.135.220.15]:38364 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261784AbVGJTfm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 15:35:42 -0400
Date: Sun, 10 Jul 2005 19:35:41 +0000
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org
Subject: [PATCH 33/82] remove linux/version.h from drivers/scsi/arcmsr
Message-ID: <20050710193541.33.RXSOKn3150.2247.olh@nectarine.suse.de>
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

drivers/scsi/arcmsr/arcmsr.c |    1 -
drivers/scsi/arcmsr/arcmsr.h |    1 -
2 files changed, 2 deletions(-)

Index: linux-2.6.13-rc2-mm1/drivers/scsi/arcmsr/arcmsr.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/scsi/arcmsr/arcmsr.c
+++ linux-2.6.13-rc2-mm1/drivers/scsi/arcmsr/arcmsr.c
@@ -81,7 +81,6 @@
#include <config/modversions.h>
#endif
#include <linux/module.h>
-#include <linux/version.h>
/* Now your module include files & source code follows */
#include <asm/dma.h>
#include <asm/io.h>
Index: linux-2.6.13-rc2-mm1/drivers/scsi/arcmsr/arcmsr.h
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/scsi/arcmsr/arcmsr.h
+++ linux-2.6.13-rc2-mm1/drivers/scsi/arcmsr/arcmsr.h
@@ -43,7 +43,6 @@
**************************************************************************
*/
#include <linux/config.h>
-#include <linux/version.h>

#if defined(__SMP__) && !defined(CONFIG_SMP)
# define CONFIG_SMP
