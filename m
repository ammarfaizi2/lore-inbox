Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932412AbVI3CQr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932412AbVI3CQr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 22:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbVI3CQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 22:16:46 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:34263 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932412AbVI3CQp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 22:16:45 -0400
Date: Fri, 30 Sep 2005 03:16:43 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org
Subject: [PATCH] useless linux/irq.h includes (arch/um)
Message-ID: <20050930021643.GY7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC14-rc2-git6-base/arch/um/drivers/port_kern.c current/arch/um/drivers/port_kern.c
--- RC14-rc2-git6-base/arch/um/drivers/port_kern.c	2005-09-26 00:02:29.000000000 -0400
+++ current/arch/um/drivers/port_kern.c	2005-09-15 23:59:08.000000000 -0400
@@ -7,7 +7,6 @@
 #include "linux/sched.h"
 #include "linux/slab.h"
 #include "linux/interrupt.h"
-#include "linux/irq.h"
 #include "linux/spinlock.h"
 #include "linux/errno.h"
 #include "asm/atomic.h"
diff -urN RC14-rc2-git6-base/arch/um/kernel/irq.c current/arch/um/kernel/irq.c
--- RC14-rc2-git6-base/arch/um/kernel/irq.c	2005-09-26 00:02:29.000000000 -0400
+++ current/arch/um/kernel/irq.c	2005-09-15 23:59:51.000000000 -0400
@@ -9,7 +9,6 @@
 #include "linux/kernel.h"
 #include "linux/module.h"
 #include "linux/smp.h"
-#include "linux/irq.h"
 #include "linux/kernel_stat.h"
 #include "linux/interrupt.h"
 #include "linux/random.h"
