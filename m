Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751351AbVLAAI6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbVLAAI6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 19:08:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbVLAAId
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 19:08:33 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:60834
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751296AbVK3X6J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 18:58:09 -0500
Subject: [patch 18/43] Remove now unnecessary includes
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, mingo@elte.hu, zippel@linux-m68k.org, george@mvista.com,
       johnstul@us.ibm.com
References: <20051130231140.164337000@tglx.tec.linutronix.de>
Content-Type: text/plain
Organization: linutronix
Date: Thu, 01 Dec 2005 01:03:31 +0100
Message-Id: <1133395411.32542.461.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

plain text document attachment (ktimer-cleanup-includes.patch)
- remove some now unnecessary includes

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>

 init/main.c    |    2 --
 kernel/timer.c |    1 -
 2 files changed, 3 deletions(-)

Index: linux-2.6.15-rc2-rework/init/main.c
===================================================================
--- linux-2.6.15-rc2-rework.orig/init/main.c
+++ linux-2.6.15-rc2-rework/init/main.c
@@ -47,8 +47,6 @@
 #include <linux/rmap.h>
 #include <linux/mempolicy.h>
 #include <linux/key.h>
-#include <linux/ktimer.h>
-
 #include <net/sock.h>
 
 #include <asm/io.h>
Index: linux-2.6.15-rc2-rework/kernel/timer.c
===================================================================
--- linux-2.6.15-rc2-rework.orig/kernel/timer.c
+++ linux-2.6.15-rc2-rework/kernel/timer.c
@@ -30,7 +30,6 @@
 #include <linux/thread_info.h>
 #include <linux/time.h>
 #include <linux/jiffies.h>
-#include <linux/ktimer.h>
 #include <linux/posix-timers.h>
 #include <linux/cpu.h>
 #include <linux/syscalls.h>

--

