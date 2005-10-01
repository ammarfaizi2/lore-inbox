Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750729AbVJAE4e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbVJAE4e (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 00:56:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750730AbVJAE4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 00:56:34 -0400
Received: from mo01.iij4u.or.jp ([210.130.0.20]:42458 "EHLO mo01.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S1750729AbVJAE4e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 00:56:34 -0400
Date: Sat, 1 Oct 2005 13:56:20 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: yuasa@hh.iij4u.or.jp, linux-kernel@vger.kernel.org
Subject: [PATCH] mips: add missing semicolon
Message-Id: <20051001135620.5cc759b9.yuasa@hh.iij4u.or.jp>
In-Reply-To: <20050929143732.59d22569.akpm@osdl.org>
References: <20050929143732.59d22569.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch has added the missing semicolon.

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff mm2-orig/arch/mips/kernel/process.c mm2/arch/mips/kernel/process.c
--- mm2-orig/arch/mips/kernel/process.c	2005-10-01 09:07:21.000000000 +0900
+++ mm2/arch/mips/kernel/process.c	2005-10-01 08:51:22.000000000 +0900
@@ -60,7 +60,7 @@
 				(*cpu_wait)();
 		preempt_enable_no_resched();
 		schedule();
-		preempt_disable()
+		preempt_disable();
 	}
 }
 
