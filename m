Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932376AbWEQATp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376AbWEQATp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 20:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932340AbWEQATV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 20:19:21 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:44445 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932376AbWEQATG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 20:19:06 -0400
Date: Wed, 17 May 2006 02:19:00 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Russell King <rmk@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       linux-arm-kernel@lists.arm.linux.org.uk
Subject: [patch 49/50] genirq: ARM drivers/input/touchscreen: Fixup includes
Message-ID: <20060517001900.GX12877@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Include the generic header file instead of the ARM specific one.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 drivers/input/touchscreen/corgi_ts.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-genirq.q/drivers/input/touchscreen/corgi_ts.c
===================================================================
--- linux-genirq.q.orig/drivers/input/touchscreen/corgi_ts.c
+++ linux-genirq.q/drivers/input/touchscreen/corgi_ts.c
@@ -17,7 +17,7 @@
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/slab.h>
-//#include <asm/irq.h>
+#include <linux/irq.h>
 
 #include <asm/arch/sharpsl.h>
 #include <asm/arch/hardware.h>
