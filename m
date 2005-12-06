Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751550AbVLFAfp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751550AbVLFAfp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 19:35:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751530AbVLFAfd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 19:35:33 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:27342
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751526AbVLFAee
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 19:34:34 -0500
Message-Id: <20051206000153.691107000@tglx.tec.linutronix.de>
References: <20051206000126.589223000@tglx.tec.linutronix.de>
Date: Tue, 06 Dec 2005 01:01:33 +0100
From: tglx@linutronix.de
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, rostedt@goodmis.org, johnstul@us.ibm.com,
       zippel@linux-m86k.org, mingo@elte.hu
Subject: [patch 07/21] Coding style clean up of clock constants
Content-Disposition: inline; filename=time-h-clean-up-clock-constants.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


- clean up the CLOCK_ portions of time.h

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

 include/linux/time.h |   23 +++++++++--------------
 1 files changed, 9 insertions(+), 14 deletions(-)

Index: linux-2.6.15-rc5/include/linux/time.h
===================================================================
--- linux-2.6.15-rc5.orig/include/linux/time.h
+++ linux-2.6.15-rc5/include/linux/time.h
@@ -99,30 +99,25 @@ struct	itimerval {
 	struct	timeval it_value;	/* current value */
 };
 
-
 /*
  * The IDs of the various system clocks (for POSIX.1b interval timers).
  */
-#define CLOCK_REALTIME		 0
-#define CLOCK_MONOTONIC	  	 1
-#define CLOCK_PROCESS_CPUTIME_ID 2
-#define CLOCK_THREAD_CPUTIME_ID	 3
+#define CLOCK_REALTIME			0
+#define CLOCK_MONOTONIC			1
+#define CLOCK_PROCESS_CPUTIME_ID	2
+#define CLOCK_THREAD_CPUTIME_ID		3
 
 /*
  * The IDs of various hardware clocks
  */
-
-
-#define CLOCK_SGI_CYCLE 10
-#define MAX_CLOCKS 16
-#define CLOCKS_MASK  (CLOCK_REALTIME | CLOCK_MONOTONIC)
-#define CLOCKS_MONO (CLOCK_MONOTONIC)
+#define CLOCK_SGI_CYCLE			10
+#define MAX_CLOCKS			16
+#define CLOCKS_MASK			(CLOCK_REALTIME | CLOCK_MONOTONIC)
+#define CLOCKS_MONO			CLOCK_MONOTONIC
 
 /*
  * The various flags for setting POSIX.1b interval timers.
  */
-
-#define TIMER_ABSTIME 0x01
-
+#define TIMER_ABSTIME			0x01
 
 #endif

--

