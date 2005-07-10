Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261798AbVGJU5m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbVGJU5m (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 16:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262084AbVGJTku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 15:40:50 -0400
Received: from ns.suse.de ([195.135.220.2]:61074 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261260AbVGJTf2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 15:35:28 -0400
Date: Sun, 10 Jul 2005 19:35:28 +0000
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: Neil Brown <neilb@cse.unsw.edu.au>
Subject: [PATCH 20/82] remove linux/version.h from drivers/md/bitmap.c
Message-ID: <20050710193528.20.ffNhaS2810.2247.olh@nectarine.suse.de>
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

drivers/md/bitmap.c |    1 -
1 files changed, 1 deletion(-)

Index: linux-2.6.13-rc2-mm1/drivers/md/bitmap.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/md/bitmap.c
+++ linux-2.6.13-rc2-mm1/drivers/md/bitmap.c
@@ -21,7 +21,6 @@
*/

#include <linux/module.h>
-#include <linux/version.h>
#include <linux/errno.h>
#include <linux/slab.h>
#include <linux/init.h>
