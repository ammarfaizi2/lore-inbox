Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261708AbVGJVSZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261708AbVGJVSZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 17:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262079AbVGJTjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 15:39:51 -0400
Received: from ns2.suse.de ([195.135.220.15]:36060 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261708AbVGJTfi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 15:35:38 -0400
Date: Sun, 10 Jul 2005 19:35:37 +0000
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org
Subject: [PATCH 29/82] remove linux/version.h from drivers/scsi/3w-xxxx.h
Message-ID: <20050710193537.29.YyPlzr3046.2247.olh@nectarine.suse.de>
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

drivers/scsi/3w-xxxx.h |    1 -
1 files changed, 1 deletion(-)

Index: linux-2.6.13-rc2-mm1/drivers/scsi/3w-xxxx.h
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/scsi/3w-xxxx.h
+++ linux-2.6.13-rc2-mm1/drivers/scsi/3w-xxxx.h
@@ -54,7 +54,6 @@
#ifndef _3W_XXXX_H
#define _3W_XXXX_H

-#include <linux/version.h>
#include <linux/types.h>

/* AEN strings */
