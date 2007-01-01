Return-Path: <linux-kernel-owner+w=401wt.eu-S1753610AbXAATJ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753610AbXAATJ5 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 14:09:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753633AbXAATJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 14:09:57 -0500
Received: from sp604005mt.neufgp.fr ([84.96.92.11]:43931 "EHLO smtp.Neuf.fr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753594AbXAATJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 14:09:56 -0500
Date: Mon, 01 Jan 2007 20:09:21 +0100
From: Vincent Legoll <vlegoll@9online.fr>
Subject: Re: [PATCH] Consolidate default sched_clock()
To: Alexey Dobriyan <adobriyan@openvz.org>
Cc: linux-kernel@vger.kernel.org, Vincent Legoll <vincent.legoll@gmail.com>
Message-id: <45995C61.2000402@9online.fr>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_yuQYQHVxPVlJF/j7Gnbtgg)"
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_yuQYQHVxPVlJF/j7Gnbtgg)
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT

Hello,

what about the following, on top of your patch ?

It's trivial modif to kernel-doc style comment...

-- 
Vincent Legoll

--Boundary_(ID_yuQYQHVxPVlJF/j7Gnbtgg)
Content-type: text/x-patch; name=sched_clock-consolidation-kernel-doc.patch
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=sched_clock-consolidation-kernel-doc.patch

diff --git a/kernel/sched.c b/kernel/sched.c
index f92a239..2c51ec0 100644
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -56,8 +56,8 @@
 
 #include <asm/unistd.h>
 
-/*
- * Scheduler clock - returns current time in nanosec units.
+/**
+ * sched_clock - returns current scheduler clock time in nanosec units.
  * This is default implementation.
  * Architectures and sub-architectures can override this.
  */

--Boundary_(ID_yuQYQHVxPVlJF/j7Gnbtgg)--
