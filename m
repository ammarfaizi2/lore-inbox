Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261602AbVGJVBq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbVGJVBq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 17:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261718AbVGJTkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 15:40:37 -0400
Received: from mx1.suse.de ([195.135.220.2]:62610 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261411AbVGJTfd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 15:35:33 -0400
Date: Sun, 10 Jul 2005 19:35:32 +0000
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: Max Asbock <masbock@us.ibm.com>
Subject: [PATCH 24/82] remove linux/version.h from drivers/misc/ibmasm/
Message-ID: <20050710193532.24.yomyuT2919.2247.olh@nectarine.suse.de>
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

drivers/misc/ibmasm/ibmasm.h |    1 -
1 files changed, 1 deletion(-)

Index: linux-2.6.13-rc2-mm1/drivers/misc/ibmasm/ibmasm.h
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/misc/ibmasm/ibmasm.h
+++ linux-2.6.13-rc2-mm1/drivers/misc/ibmasm/ibmasm.h
@@ -31,7 +31,6 @@
#include <linux/slab.h>
#include <linux/config.h>
#include <linux/module.h>
-#include <linux/version.h>
#include <linux/interrupt.h>
#include <linux/device.h>
#include <linux/input.h>
