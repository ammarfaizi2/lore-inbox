Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262070AbVGJWyW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262070AbVGJWyW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 18:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262000AbVGJTiI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 15:38:08 -0400
Received: from ns.suse.de ([195.135.220.2]:19603 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262017AbVGJTgM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 15:36:12 -0400
Date: Sun, 10 Jul 2005 19:36:11 +0000
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: Eric Van Hensbergen <ericvh@gmail.com>
Subject: [PATCH 63/82] remove linux/version.h from fs/9p
Message-ID: <20050710193611.63.OQDKxP3940.2247.olh@nectarine.suse.de>
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

fs/9p/vfs_file.c |    1 -
1 files changed, 1 deletion(-)

Index: linux-2.6.13-rc2-mm1/fs/9p/vfs_file.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/fs/9p/vfs_file.c
+++ linux-2.6.13-rc2-mm1/fs/9p/vfs_file.c
@@ -32,7 +32,6 @@
#include <linux/string.h>
#include <linux/smp_lock.h>
#include <linux/inet.h>
-#include <linux/version.h>
#include <linux/list.h>
#include <asm/uaccess.h>

