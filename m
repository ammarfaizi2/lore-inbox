Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932391AbWAKLwe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932391AbWAKLwe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 06:52:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932382AbWAKLwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 06:52:34 -0500
Received: from vanessarodrigues.com ([192.139.46.150]:37510 "EHLO
	jaguar.mkp.net") by vger.kernel.org with ESMTP id S932375AbWAKLwd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 06:52:33 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17348.61824.49889.569928@jaguar.mkp.net>
Date: Wed, 11 Jan 2006 06:52:32 -0500
To: torvalds@osdl.org
Cc: akpm@osdl.org, tony.luck@intel.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [patch] remove unused semaphore from arch/ia64/hp/sim/simserial.c
X-Mailer: VM 7.19 under Emacs 21.4.1
From: jes@trained-monkey.org (Jes Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Remove unsued semaphore declaration.

Signed-off-by: Jes Sorensen <jes@sgi.com>

----

 arch/ia64/hp/sim/simserial.c |    1 -
 1 files changed, 1 deletion(-)

Index: linux-2.6.15-rc7-quilt/arch/ia64/hp/sim/simserial.c
===================================================================
--- linux-2.6.15-rc7-quilt.orig/arch/ia64/hp/sim/simserial.c
+++ linux-2.6.15-rc7-quilt/arch/ia64/hp/sim/simserial.c
@@ -107,7 +107,6 @@
 static struct console *console;
 
 static unsigned char *tmp_buf;
-static DECLARE_MUTEX(tmp_buf_sem);
 
 extern struct console *console_drivers; /* from kernel/printk.c */
 
