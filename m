Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965469AbWI0JZR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965469AbWI0JZR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 05:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965470AbWI0JZR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 05:25:17 -0400
Received: from www.osadl.org ([213.239.205.134]:13519 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S965469AbWI0JZP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 05:25:15 -0400
Date: Wed, 27 Sep 2006 11:25:11 +0200
From: Jan Altenberg <tb10alj@tglx.de>
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix simple Kconfig.preempt typo in 2.6.18-rt4
Message-ID: <20060927092511.GA4644@tb10alj3.homag.com>
Mail-Followup-To: Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- Fix a simple typo in kernel/Kconfig.preempt

Signed-off-by: Jan Altenberg <tb10alj@tglx.de>

----------------------

--- linux-2.6.18-rt4/kernel/Kconfig.preempt.orig	2006-09-27 11:09:20.000000000 +0200
+++ linux-2.6.18-rt4/kernel/Kconfig.preempt	2006-09-27 11:09:40.000000000 +0200
@@ -65,7 +65,7 @@ config PREEMPT_RT
 	  critical kernel code involuntarily preemptible. The remaining
 	  handful of lowlevel non-preemptible codepaths are short and
 	  have a deterministic latency of a couple of tens of
-	  microseconds (depending the the hardware).  This also allows
+	  microseconds (depending on the hardware).  This also allows
 	  applications to run more 'smoothly' even when the system is
 	  under load, at the cost of lower throughput and runtime
 	  overhead to kernel code.
