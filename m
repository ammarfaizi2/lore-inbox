Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261191AbVGKAMk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261191AbVGKAMk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 20:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261195AbVGKAKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 20:10:30 -0400
Received: from ns1.suse.de ([195.135.220.2]:54674 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261184AbVGJTfO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 15:35:14 -0400
Date: Sun, 10 Jul 2005 19:35:13 +0000
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: parisc-linux@parisc-linux.org
Subject: [PATCH 5/82] remove linux/version.h include from arch/parisc
Message-ID: <20050710193513.5.zzSumL2388.2247.olh@nectarine.suse.de>
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

arch/parisc/kernel/asm-offsets.c |    1 -
1 files changed, 1 deletion(-)

Index: linux-2.6.13-rc2-mm1/arch/parisc/kernel/asm-offsets.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/arch/parisc/kernel/asm-offsets.c
+++ linux-2.6.13-rc2-mm1/arch/parisc/kernel/asm-offsets.c
@@ -30,7 +30,6 @@
#include <linux/types.h>
#include <linux/sched.h>
#include <linux/thread_info.h>
-#include <linux/version.h>
#include <linux/ptrace.h>
#include <linux/hardirq.h>

