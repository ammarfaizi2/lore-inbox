Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262114AbULLT5L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbULLT5L (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 14:57:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262121AbULLT5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 14:57:10 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:17682 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262114AbULLT4C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 14:56:02 -0500
Date: Sun, 12 Dec 2004 20:55:52 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Patrick Mochel <mochel@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] kernel/power/main.c: make pm_states static
Message-ID: <20041212195552.GK22324@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes pm_states static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm4-full/kernel/power/main.c.old	2004-12-12 03:04:13.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/kernel/power/main.c	2004-12-12 03:04:22.000000000 +0100
@@ -114,7 +114,7 @@
 
 
 
-char * pm_states[] = {
+static char * pm_states[] = {
 	[PM_SUSPEND_STANDBY]	= "standby",
 	[PM_SUSPEND_MEM]	= "mem",
 	[PM_SUSPEND_DISK]	= "disk",

