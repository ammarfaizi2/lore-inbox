Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751310AbVLAAMH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbVLAAMH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 19:12:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbVK3X53
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 18:57:29 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:38818
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751288AbVK3X5S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 18:57:18 -0500
Subject: [patch 07/43] Cleanup clock constants coding style
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, mingo@elte.hu, zippel@linux-m68k.org, george@mvista.com,
       johnstul@us.ibm.com
References: <20051130231140.164337000@tglx.tec.linutronix.de>
Content-Type: text/plain
Organization: linutronix
Date: Thu, 01 Dec 2005 01:02:59 +0100
Message-Id: <1133395380.32542.450.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

plain text document attachment (time-h-clean-up-clock-constants.patch)
- clean up the CLOCK_ portions of time.h

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

 include/linux/time.h |   23 +++++++++--------------
 1 files changed, 9 insertions(+), 14 deletions(-)

Index: linux-2.6.15-rc2-rework/include/linux/time.h
===================================================================
--- linux-2.6.15-rc2-rework.orig/include/linux/time.h
+++ linux-2.6.15-rc2-rework/include/linux/time.h
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

