Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261862AbVAYHv7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261862AbVAYHv7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 02:51:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261864AbVAYHvT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 02:51:19 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:20487 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261862AbVAYHtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 02:49:16 -0500
Date: Tue, 25 Jan 2005 08:49:13 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
Subject: [2.6 patch] kernel/power/main.c: make pm_states static
Message-ID: <20050125074913.GG3515@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes pm_states static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 12 Dec 2004

--- linux-2.6.10-rc2-mm4-full/kernel/power/main.c.old	2004-12-12 03:04:13.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/kernel/power/main.c	2004-12-12 03:04:22.000000000 +0100
@@ -114,7 +114,7 @@
 
 
 
-char * pm_states[] = {
+static char * pm_states[] = {
 	[PM_SUSPEND_STANDBY]	= "standby",
 	[PM_SUSPEND_MEM]	= "mem",
 	[PM_SUSPEND_DISK]	= "disk",

