Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262027AbVGJUSm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262027AbVGJUSm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 16:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261203AbVGJTln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 15:41:43 -0400
Received: from mail.suse.de ([195.135.220.2]:23187 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262027AbVGJTgT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 15:36:19 -0400
Date: Sun, 10 Jul 2005 19:36:19 +0000
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: netdev@oss.sgi.com
Subject: [PATCH 71/82] remove linux/version.h from include/linux/if_wanpipe_common.h
Message-ID: <20050710193619.71.OhUmOh4153.2247.olh@nectarine.suse.de>
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

include/linux/if_wanpipe_common.h |    2 --
1 files changed, 2 deletions(-)

Index: linux-2.6.13-rc2-mm1/include/linux/if_wanpipe_common.h
===================================================================
--- linux-2.6.13-rc2-mm1.orig/include/linux/if_wanpipe_common.h
+++ linux-2.6.13-rc2-mm1/include/linux/if_wanpipe_common.h
@@ -17,8 +17,6 @@
#ifndef _WANPIPE_SOCK_DRIVER_COMMON_H
#define _WANPIPE_SOCK_DRIVER_COMMON_H

-#include <linux/version.h>
-
typedef struct {
struct net_device *slave;
atomic_t packet_sent;
