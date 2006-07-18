Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751326AbWGRL5O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326AbWGRL5O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 07:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbWGRL5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 07:57:13 -0400
Received: from server6.greatnet.de ([83.133.96.26]:25068 "EHLO
	server6.greatnet.de") by vger.kernel.org with ESMTP
	id S1751323AbWGRL5M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 07:57:12 -0400
Message-ID: <44BCCD3A.20109@nachtwindheim.de>
Date: Tue, 18 Jul 2006 13:59:54 +0200
From: Henne <henne@nachtwindheim.de>
User-Agent: Thunderbird 1.5.0.4 (X11/20060527)
MIME-Version: 1.0
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org
Subject: [PATCH] kernel-doc in kernel/irq/handle.c
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Henrik Kretzschmar <henne@nachtwindheim.de>

Adds the description of the parameters from handle_bad_irq().
Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>
---

diff -ruN linux-2.6.18-rc2/kernel/irq/handle.c linux/kernel/irq/handle.c
--- linux-2.6.18-rc2/kernel/irq/handle.c        2006-07-18 13:37:39.000000000 +0200
+++ linux/kernel/irq/handle.c   2006-07-18 13:51:15.000000000 +0200
@@ -20,6 +20,11 @@

 /**
  * handle_bad_irq - handle spurious and unhandled irqs
+ * @irq:       the interrupt number
+ * @desc:      description of the interrupt
+ * @regs:      pointer to a register structure
+ *
+ * Handles spurious and unhandled IRQ's. It also prints a debugmessage.
  */
 void fastcall
 handle_bad_irq(unsigned int irq, struct irq_desc *desc, struct pt_regs *regs)
