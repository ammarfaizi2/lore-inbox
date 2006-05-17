Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932381AbWEQAVL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932381AbWEQAVL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 20:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932388AbWEQAUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 20:20:52 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:47261 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932381AbWEQATR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 20:19:17 -0400
Date: Wed, 17 May 2006 02:19:13 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Russell King <rmk@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       linux-arm-kernel@lists.arm.linux.org.uk
Subject: [patch 50/50] genirq: add version string to EXTRAVERSION
Message-ID: <20060517001913.GY12877@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL,UPPERCASE_25_50 autolearn=no SpamAssassin version=3.0.3
	0.2 UPPERCASE_25_50        message body is 25-50% uppercase
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

add version string to EXTRAVERSION.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-genirq.q/Makefile
===================================================================
--- linux-genirq.q.orig/Makefile
+++ linux-genirq.q/Makefile
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 17
-EXTRAVERSION =-rc4
+EXTRAVERSION =-rc4-genirq3
 NAME=Sliding Snow Leopard
 
 # *DOCUMENTATION*
