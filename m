Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262461AbVAPINc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262461AbVAPINc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 03:13:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262456AbVAPIMA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 03:12:00 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:51471 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262457AbVAPILN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 03:11:13 -0500
Date: Sun, 16 Jan 2005 09:11:10 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Pavel Machek <pavel@suse.cz>, Patrick Mochel <mochel@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] i386/power/cpu.c: remove three unused variables
Message-ID: <20050116081110.GI4274@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below removes three unused variables.

Please check whether this patch is correct, or whether the variables 
should have been used.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

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

