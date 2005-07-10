Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261189AbVGKAMj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261189AbVGKAMj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 20:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262073AbVGKAKn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 20:10:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:23260 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261191AbVGJTfM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 15:35:12 -0400
Date: Sun, 10 Jul 2005 19:35:11 +0000
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: linux-ia64@vger.kernel.org
Subject: [PATCH 3/82] remove linux/version.h include from arch/ia64
Message-ID: <20050710193511.3.HkjxyJ2330.2247.olh@nectarine.suse.de>
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

arch/ia64/kernel/perfmon.c  |    1 -
arch/ia64/sn/kernel/tiocx.c |    1 -
include/asm-ia64/sn/xp.h    |    1 -
3 files changed, 3 deletions(-)

Index: linux-2.6.13-rc2-mm1/arch/ia64/kernel/perfmon.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/arch/ia64/kernel/perfmon.c
+++ linux-2.6.13-rc2-mm1/arch/ia64/kernel/perfmon.c
@@ -37,7 +37,6 @@
#include <linux/vfs.h>
#include <linux/pagemap.h>
#include <linux/mount.h>
-#include <linux/version.h>
#include <linux/bitops.h>
#include <linux/rcupdate.h>

Index: linux-2.6.13-rc2-mm1/arch/ia64/sn/kernel/tiocx.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/arch/ia64/sn/kernel/tiocx.c
+++ linux-2.6.13-rc2-mm1/arch/ia64/sn/kernel/tiocx.c
@@ -8,7 +8,6 @@

#include <linux/module.h>
#include <linux/kernel.h>
-#include <linux/version.h>
#include <linux/slab.h>
#include <linux/spinlock.h>
#include <linux/proc_fs.h>
Index: linux-2.6.13-rc2-mm1/include/asm-ia64/sn/xp.h
===================================================================
--- linux-2.6.13-rc2-mm1.orig/include/asm-ia64/sn/xp.h
+++ linux-2.6.13-rc2-mm1/include/asm-ia64/sn/xp.h
@@ -16,7 +16,6 @@
#define _ASM_IA64_SN_XP_H


-#include <linux/version.h>
#include <linux/cache.h>
#include <linux/hardirq.h>
#include <asm/sn/types.h>
