Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261987AbUKCX1w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261987AbUKCX1w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 18:27:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262000AbUKCXZI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 18:25:08 -0500
Received: from gprs214-112.eurotel.cz ([160.218.214.112]:31363 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261890AbUKCXVr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 18:21:47 -0500
Date: Thu, 4 Nov 2004 00:21:35 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Reduce ammount of sparse warnings in acpi/sleep/main.c
Message-ID: <20041103232135.GA8077@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This gets me rid of four or so sparse warnings... and is right thing
to do, anyway. Please apply,
							Pavel

--- linux.middle//drivers/acpi/sleep/main.c	2004-10-25 23:03:40.000000000 +0200
+++ linux/drivers/acpi/sleep/main.c	2004-11-04 00:18:36.000000000 +0100
@@ -156,7 +156,7 @@
 
 int acpi_suspend(u32 acpi_state)
 {
-	u32 states[] = {
+	suspend_state_t states[] = {
 		[1]	= PM_SUSPEND_STANDBY,
 		[3]	= PM_SUSPEND_MEM,
 		[4]	= PM_SUSPEND_DISK,

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
