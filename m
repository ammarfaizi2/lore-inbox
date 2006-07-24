Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932146AbWGXNTk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbWGXNTk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 09:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932151AbWGXNTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 09:19:40 -0400
Received: from mo32.po.2iij.net ([210.128.50.17]:51209 "EHLO mo32.po.2iij.net")
	by vger.kernel.org with ESMTP id S932146AbWGXNTj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 09:19:39 -0400
Date: Mon, 24 Jul 2006 22:15:06 +0900
From: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] irq: fixed coding style
Message-Id: <20060724221506.2955bbb5.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch has fixed coding style.
I think that it is more natural.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X 2.6.18-rc2/Documentation/dontdiff 2.6.18-rc2-orig/kernel/irq/chip.c 2.6.18-rc2/kernel/irq/chip.c
--- 2.6.18-rc2-orig/kernel/irq/chip.c	2006-07-24 09:58:59.666575750 +0900
+++ 2.6.18-rc2/kernel/irq/chip.c	2006-07-24 10:15:27.319234250 +0900
@@ -146,7 +146,7 @@ static void default_disable(unsigned int
 	struct irq_desc *desc = irq_desc + irq;
 
 	if (!(desc->status & IRQ_DELAYED_DISABLE))
-		irq_desc[irq].chip->mask(irq);
+		desc->chip->mask(irq);
 }
 
 /*
