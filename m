Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266777AbSKHIIy>; Fri, 8 Nov 2002 03:08:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266779AbSKHIIx>; Fri, 8 Nov 2002 03:08:53 -0500
Received: from dp.samba.org ([66.70.73.150]:46776 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266778AbSKHIIs>;
	Fri, 8 Nov 2002 03:08:48 -0500
From: Rusty Trivial Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [TRIVIAL] added include needed to compile centaur.c for 2.5.46-bk1
Date: Fri, 08 Nov 2002 18:49:24 +1100
Message-Id: <20021108081530.1B2772C38B@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From:  "James McMechan" <james_mcmechan@hotmail.com>


--- trivial-2.5-bk/arch/i386/kernel/cpu/centaur.c.orig	2002-11-08 18:46:34.000000000 +1100
+++ trivial-2.5-bk/arch/i386/kernel/cpu/centaur.c	2002-11-08 18:46:34.000000000 +1100
@@ -3,6 +3,7 @@
 #include <linux/bitops.h>
 #include <asm/processor.h>
 #include <asm/msr.h>
+#include <asm/e820.h>
 #include "cpu.h"
 
 #ifdef CONFIG_X86_OOSTORE
-- 
  Don't blame me: the Monkey is driving
  File: "James McMechan" <james_mcmechan@hotmail.com>: added include needed to compile centaur.c for 2.5.46-bk1
