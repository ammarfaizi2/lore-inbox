Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261824AbVGJVgl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261824AbVGJVgl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 17:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261831AbVGJTjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 15:39:16 -0400
Received: from cantor.suse.de ([195.135.220.2]:7315 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261824AbVGJTft (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 15:35:49 -0400
Date: Sun, 10 Jul 2005 19:35:49 +0000
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org
Subject: [PATCH 41/82] remove linux/version.h from drivers/scsi/iteraid.h
Message-ID: <20050710193549.41.pEwTZh3360.2247.olh@nectarine.suse.de>
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
drivers/scsi/iteraid.h |    1 -
1 files changed, 1 deletion(-)

Index: linux-2.6.13-rc2-mm1/drivers/scsi/iteraid.h
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/scsi/iteraid.h
+++ linux-2.6.13-rc2-mm1/drivers/scsi/iteraid.h
@@ -23,7 +23,6 @@
#ifndef _ITERAID_H_
#define _ITERAID_H_

-#include <linux/version.h>
#include <linux/types.h>

#define ITE_VENDOR_ID	0x1283
