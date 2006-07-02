Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750710AbWGBXVl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbWGBXVl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 19:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750709AbWGBXVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 19:21:41 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:24791 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1750710AbWGBXVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 19:21:40 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Mon, 3 Jul 2006 01:21:16 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 13/19] ieee1394: nodemgr: remove unnecessary includes
To: Ben Collins <bcollins@ubuntu.com>
cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <tkrat.8d67352567e525c1@s5r6.in-berlin.de>
Message-ID: <tkrat.e21522082d203fa8@s5r6.in-berlin.de>
References: <tkrat.8d67352567e525c1@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (-0.017) AWL,BAYES_40
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
Index: linux/drivers/ieee1394/nodemgr.c
===================================================================
--- linux.orig/drivers/ieee1394/nodemgr.c	2006-07-01 09:57:16.000000000 +0200
+++ linux/drivers/ieee1394/nodemgr.c	2006-07-01 21:02:55.000000000 +0200
@@ -12,12 +12,8 @@
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/slab.h>
-#include <linux/smp_lock.h>
-#include <linux/interrupt.h>
-#include <linux/kmod.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
-#include <linux/pci.h>
 #include <linux/moduleparam.h>
 #include <asm/atomic.h>
 


