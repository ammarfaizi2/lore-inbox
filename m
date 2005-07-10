Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262026AbVGJUSm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262026AbVGJUSm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 16:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262027AbVGJTlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 15:41:47 -0400
Received: from cantor.suse.de ([195.135.220.2]:22163 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262026AbVGJTgT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 15:36:19 -0400
Date: Sun, 10 Jul 2005 19:36:16 +0000
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: Jeff Dike <jdike@addtoit.com>
Subject: [PATCH 68/82] remove linux/version.h from fs/hostfs/
Message-ID: <20050710193616.68.LZuYFy4074.2247.olh@nectarine.suse.de>
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

fs/hostfs/hostfs_kern.c |    1 -
1 files changed, 1 deletion(-)

Index: linux-2.6.13-rc2-mm1/fs/hostfs/hostfs_kern.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/fs/hostfs/hostfs_kern.c
+++ linux-2.6.13-rc2-mm1/fs/hostfs/hostfs_kern.c
@@ -8,7 +8,6 @@

#include <linux/stddef.h>
#include <linux/fs.h>
-#include <linux/version.h>
#include <linux/module.h>
#include <linux/init.h>
#include <linux/slab.h>
