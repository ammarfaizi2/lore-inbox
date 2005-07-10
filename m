Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262110AbVGJUSl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262110AbVGJUSl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 16:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262026AbVGJTlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 15:41:49 -0400
Received: from ns2.suse.de ([195.135.220.15]:52444 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262025AbVGJTgT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 15:36:19 -0400
Date: Sun, 10 Jul 2005 19:36:14 +0000
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: zippel@linux-m68k.org
Subject: [PATCH 66/82] remove linux/version.h from fs/hfs/
Message-ID: <20050710193614.66.sNRbVO4020.2247.olh@nectarine.suse.de>
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

fs/hfs/hfs_fs.h |    1 -
fs/hfs/inode.c  |    1 -
2 files changed, 2 deletions(-)

Index: linux-2.6.13-rc2-mm1/fs/hfs/hfs_fs.h
===================================================================
--- linux-2.6.13-rc2-mm1.orig/fs/hfs/hfs_fs.h
+++ linux-2.6.13-rc2-mm1/fs/hfs/hfs_fs.h
@@ -9,7 +9,6 @@
#ifndef _LINUX_HFS_FS_H
#define _LINUX_HFS_FS_H

-#include <linux/version.h>
#include <linux/slab.h>
#include <linux/types.h>
#include <linux/buffer_head.h>
Index: linux-2.6.13-rc2-mm1/fs/hfs/inode.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/fs/hfs/inode.c
+++ linux-2.6.13-rc2-mm1/fs/hfs/inode.c
@@ -12,7 +12,6 @@
*/

#include <linux/pagemap.h>
-#include <linux/version.h>
#include <linux/mpage.h>

#include "hfs_fs.h"
