Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261632AbVGJTkb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261632AbVGJTkb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 15:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbVGJTkF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 15:40:05 -0400
Received: from cantor2.suse.de ([195.135.220.15]:33756 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261632AbVGJTfg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 15:35:36 -0400
Date: Sun, 10 Jul 2005 19:35:31 +0000
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: Brian Waite <waite@skycomputers.com>
Subject: [PATCH 23/82] remove linux/version.h from drivers/misc/hdpuftrs/
Message-ID: <20050710193531.23.DvQKvZ2891.2247.olh@nectarine.suse.de>
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

drivers/misc/hdpuftrs/hdpu_cpustate.c |    1 -
drivers/misc/hdpuftrs/hdpu_nexus.c    |    1 -
2 files changed, 2 deletions(-)

Index: linux-2.6.13-rc2-mm1/drivers/misc/hdpuftrs/hdpu_cpustate.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/misc/hdpuftrs/hdpu_cpustate.c
+++ linux-2.6.13-rc2-mm1/drivers/misc/hdpuftrs/hdpu_cpustate.c
@@ -14,7 +14,6 @@
*
*/

-#include <linux/version.h>
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/spinlock.h>
Index: linux-2.6.13-rc2-mm1/drivers/misc/hdpuftrs/hdpu_nexus.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/misc/hdpuftrs/hdpu_nexus.c
+++ linux-2.6.13-rc2-mm1/drivers/misc/hdpuftrs/hdpu_nexus.c
@@ -14,7 +14,6 @@
*
*/

-#include <linux/version.h>
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/proc_fs.h>
