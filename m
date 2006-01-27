Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422666AbWA0Wxx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422666AbWA0Wxx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 17:53:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422667AbWA0Wxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 17:53:52 -0500
Received: from smtp1.pp.htv.fi ([213.243.153.37]:9356 "EHLO smtp1.pp.htv.fi")
	by vger.kernel.org with ESMTP id S1422660AbWA0Wxg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 17:53:36 -0500
Date: Sat, 28 Jan 2006 00:53:35 +0200
From: Paul Mundt <lethal@linux-sh.org>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 9/11] sh: Add missing timers directory rule to build.
Message-ID: <20060127225335.GJ30816@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20060127224919.GA30816@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060127224919.GA30816@linux-sh.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This should have been part of the timer framework support that
was merged earlier, but looks to have been accidentally omitted.

Signed-off-by: Paul Mundt <lethal@linux-sh.org>

---

 arch/sh/kernel/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

1e8f7de2d6e5dad3db913b8ff15c4d20c8555c33
diff --git a/arch/sh/kernel/Makefile b/arch/sh/kernel/Makefile
index 7a86eeb..f05cd96 100644
--- a/arch/sh/kernel/Makefile
+++ b/arch/sh/kernel/Makefile
@@ -8,7 +8,7 @@ obj-y	:= process.o signal.o entry.o trap
 	ptrace.o setup.o time.o sys_sh.o semaphore.o \
 	io.o io_generic.o sh_ksyms.o
 
-obj-y				+= cpu/
+obj-y				+= cpu/ timers/
 
 obj-$(CONFIG_SMP)		+= smp.o
 obj-$(CONFIG_CF_ENABLER)	+= cf-enabler.o
