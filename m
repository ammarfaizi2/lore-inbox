Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262830AbVCDAym@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262830AbVCDAym (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 19:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262828AbVCDAtC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 19:49:02 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:22540 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262824AbVCDArl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 19:47:41 -0500
Date: Fri, 4 Mar 2005 01:47:38 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] unexport idle_cpu
Message-ID: <20050304004738.GV4608@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I didn't find any possible modular usage in the kernel.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.11-rc5-mm1-full/kernel/sched.c.old	2005-03-04 01:06:21.000000000 +0100
+++ linux-2.6.11-rc5-mm1-full/kernel/sched.c	2005-03-04 01:06:36.000000000 +0100
@@ -3387,8 +3387,6 @@
 	return cpu_curr(cpu) == cpu_rq(cpu)->idle;
 }
 
-EXPORT_SYMBOL_GPL(idle_cpu);
-
 /**
  * idle_task - return the idle task for a given cpu.
  * @cpu: the processor in question.
