Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbVGJUSn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbVGJUSn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 16:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261210AbVGJTlh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 15:41:37 -0400
Received: from ns2.suse.de ([195.135.220.15]:24540 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261206AbVGJTfX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 15:35:23 -0400
Date: Sun, 10 Jul 2005 19:35:17 +0000
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 9/82] remove linux/version.h from drivers/block/amiflop.c
Message-ID: <20050710193517.9.vfGzYd2509.2247.olh@nectarine.suse.de>
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

drivers/block/amiflop.c |    1 -
1 files changed, 1 deletion(-)

Index: linux-2.6.13-rc2-mm1/drivers/block/amiflop.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/block/amiflop.c
+++ linux-2.6.13-rc2-mm1/drivers/block/amiflop.c
@@ -1816,7 +1816,6 @@ out_blkdev:
}

#ifdef MODULE
-#include <linux/version.h>

int init_module(void)
{
