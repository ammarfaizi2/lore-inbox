Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261260AbVCKSmA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261260AbVCKSmA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 13:42:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbVCKSj6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 13:39:58 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:25617 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261283AbVCKSQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 13:16:57 -0500
Date: Fri, 11 Mar 2005 19:16:49 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Pavel Machek <pavel@suse.cz>, Patrick Mochel <mochel@osdl.org>,
       linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: [2.6 patch] i386/power/cpu.c: remove three unused variables
Message-ID: <20050311181649.GM3723@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes three unused variables.

Pavel Machek and H. Peter Anvin have already confirmed it's correct.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 16 Jan 2005

--- linux-2.6.11-rc1-mm1-full/arch/i386/power/cpu.c.old	2005-01-16 05:51:42.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/arch/i386/power/cpu.c	2005-01-16 05:52:02.000000000 +0100
@@ -28,8 +28,7 @@
 
 static struct saved_context saved_context;
 
-unsigned long saved_context_eax, saved_context_ebx;
-unsigned long saved_context_ecx, saved_context_edx;
+unsigned long saved_context_ebx;
 unsigned long saved_context_esp, saved_context_ebp;
 unsigned long saved_context_esi, saved_context_edi;
 unsigned long saved_context_eflags;

