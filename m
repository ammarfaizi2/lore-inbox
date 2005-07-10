Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262062AbVGJWyT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbVGJWyT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 18:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262069AbVGJTig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 15:38:36 -0400
Received: from mail.suse.de ([195.135.220.2]:20883 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262020AbVGJTgN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 15:36:13 -0400
Date: Sun, 10 Jul 2005 19:36:13 +0000
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 65/82] remove linux/version.h from fs/configfs
Message-ID: <20050710193613.65.ZJdYdD3993.2247.olh@nectarine.suse.de>
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

fs/configfs/symlink.c |    1 -
1 files changed, 1 deletion(-)

Index: linux-2.6.13-rc2-mm1/fs/configfs/symlink.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/fs/configfs/symlink.c
+++ linux-2.6.13-rc2-mm1/fs/configfs/symlink.c
@@ -24,7 +24,6 @@
* configfs Copyright (C) 2005 Oracle.  All rights reserved.
*/

-#include <linux/version.h>
#include <linux/fs.h>
#include <linux/module.h>
#include <linux/namei.h>
