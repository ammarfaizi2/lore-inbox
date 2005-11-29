Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751375AbVK2PMs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbVK2PMs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 10:12:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751366AbVK2PMs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 10:12:48 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:9700 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751375AbVK2PMr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 10:12:47 -0500
Date: Tue, 29 Nov 2005 16:10:44 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>
Subject: [PATCH] swsusp: Drop duplicate prototypes
Message-ID: <20051129151044.GA17293@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These two prototypes are already present in sched.h, remove duplicate
version.

Signed-off-by: Pavel Machek <pavel@suse.cz>

---
commit 72936ce37893098af1e2ec30b95274ca721bbf82
tree 5b6aaf5cd5402bfc19b3faeab179c88803756805
parent 3248196034f5f0a93554b441bd41af2620afa635
author <pavel@amd.(none)> Tue, 29 Nov 2005 16:05:14 +0100
committer <pavel@amd.(none)> Tue, 29 Nov 2005 16:05:14 +0100

diff --git a/kernel/power/power.h b/kernel/power/power.h
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -48,9 +48,6 @@ static struct subsys_attribute _name##_a
 
 extern struct subsystem power_subsys;
 
-extern int freeze_processes(void);
-extern void thaw_processes(void);
-
 extern int pm_prepare_console(void);
 extern void pm_restore_console(void);
 

-- 
Thanks, Sharp!
