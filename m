Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268276AbTBYU0J>; Tue, 25 Feb 2003 15:26:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268298AbTBYUV3>; Tue, 25 Feb 2003 15:21:29 -0500
Received: from [24.77.48.240] ([24.77.48.240]:40489 "EHLO aiinc.aiinc.ca")
	by vger.kernel.org with ESMTP id <S268276AbTBYUVD>;
	Tue, 25 Feb 2003 15:21:03 -0500
Date: Tue, 25 Feb 2003 12:31:18 -0800
From: Michael Hayes <mike@aiinc.ca>
Message-Id: <200302252031.h1PKVIb24918@aiinc.aiinc.ca>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Spelling fixes for 2.5.63 - hasn't
Cc: torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes:
    hasnt -> hasn't (9 occurrences)

diff -ur a/arch/mips/au1000/common/time.c b/arch/mips/au1000/common/time.c
--- a/arch/mips/au1000/common/time.c	Mon Feb 24 11:05:15 2003
+++ b/arch/mips/au1000/common/time.c	Tue Feb 25 09:48:36 2003
@@ -240,7 +240,7 @@
 
 		/*
 		 * xtime is atomically updated in timer_bh. jiffies - wall_jiffies
-		 * is nonzero if the timer bottom half hasnt executed yet.
+		 * is nonzero if the timer bottom half hasn't executed yet.
 		 */
 		if (jiffies - wall_jiffies)
 			tv->tv_usec += USECS_PER_JIFFY;
diff -ur a/arch/mips/dec/time.c b/arch/mips/dec/time.c
--- a/arch/mips/dec/time.c	Mon Feb 24 11:05:40 2003
+++ b/arch/mips/dec/time.c	Tue Feb 25 09:48:38 2003
@@ -220,7 +220,7 @@
 
 		/*
 		 * xtime is atomically updated in timer_bh. jiffies - wall_jiffies
-		 * is nonzero if the timer bottom half hasnt executed yet.
+		 * is nonzero if the timer bottom half hasn't executed yet.
 		 */
 		if (jiffies - wall_jiffies)
 			tv->tv_usec += USECS_PER_JIFFY;
diff -ur a/arch/mips/ite-boards/generic/time.c b/arch/mips/ite-boards/generic/time.c
--- a/arch/mips/ite-boards/generic/time.c	Mon Feb 24 11:05:17 2003
+++ b/arch/mips/ite-boards/generic/time.c	Tue Feb 25 09:48:40 2003
@@ -350,7 +350,7 @@
 		/*
 		 * xtime is atomically updated in timer_bh. 
 		 * jiffies - wall_jiffies
-		 * is nonzero if the timer bottom half hasnt executed yet.
+		 * is nonzero if the timer bottom half hasn't executed yet.
 		 */
 		if (jiffies - wall_jiffies)
 			tv->tv_usec += USECS_PER_JIFFY;
diff -ur a/arch/mips/kernel/old-time.c b/arch/mips/kernel/old-time.c
--- a/arch/mips/kernel/old-time.c	Mon Feb 24 11:05:38 2003
+++ b/arch/mips/kernel/old-time.c	Tue Feb 25 09:48:45 2003
@@ -229,7 +229,7 @@
 
 	/*
 	 * xtime is atomically updated in timer_bh. jiffies - wall_jiffies
-	 * is nonzero if the timer bottom half hasnt executed yet.
+	 * is nonzero if the timer bottom half hasn't executed yet.
 	 */
 	if (jiffies - wall_jiffies)
 		tv->tv_usec += USECS_PER_JIFFY;
diff -ur a/arch/mips/kernel/time.c b/arch/mips/kernel/time.c
--- a/arch/mips/kernel/time.c	Mon Feb 24 11:05:29 2003
+++ b/arch/mips/kernel/time.c	Tue Feb 25 09:48:47 2003
@@ -73,7 +73,7 @@
 		/*
 		 * xtime is atomically updated in timer_bh. 
 		 * jiffies - wall_jiffies
-		 * is nonzero if the timer bottom half hasnt executed yet.
+		 * is nonzero if the timer bottom half hasn't executed yet.
 		 */
 		if (jiffies - wall_jiffies)
 			tv->tv_usec += USECS_PER_JIFFY;
diff -ur a/arch/mips/mips-boards/generic/time.c b/arch/mips/mips-boards/generic/time.c
--- a/arch/mips/mips-boards/generic/time.c	Mon Feb 24 11:05:36 2003
+++ b/arch/mips/mips-boards/generic/time.c	Tue Feb 25 09:48:49 2003
@@ -380,7 +380,7 @@
 		/*
 		 * xtime is atomically updated in timer_bh. 
 		 * jiffies - wall_jiffies
-		 * is nonzero if the timer bottom half hasnt executed yet.
+		 * is nonzero if the timer bottom half hasn't executed yet.
 		 */
 		if (jiffies - wall_jiffies)
 			tv->tv_usec += USECS_PER_JIFFY;
diff -ur a/arch/mips/philips/nino/time.c b/arch/mips/philips/nino/time.c
--- a/arch/mips/philips/nino/time.c	Mon Feb 24 11:05:05 2003
+++ b/arch/mips/philips/nino/time.c	Tue Feb 25 09:48:51 2003
@@ -82,7 +82,7 @@
 
 	    /*
 	     * xtime is atomically updated in timer_bh. lost_ticks is
-	     * nonzero if the timer bottom half hasnt executed yet.
+	     * nonzero if the timer bottom half hasn't executed yet.
 	     */
 	    if (jiffies - wall_jiffies)
 		    tv->tv_usec += USECS_PER_JIFFY;
diff -ur a/arch/mips64/mips-boards/generic/time.c b/arch/mips64/mips-boards/generic/time.c
--- a/arch/mips64/mips-boards/generic/time.c	Mon Feb 24 11:05:11 2003
+++ b/arch/mips64/mips-boards/generic/time.c	Tue Feb 25 09:48:34 2003
@@ -369,7 +369,7 @@
 		/*
 		 * xtime is atomically updated in timer_bh. 
 		 * jiffies - wall_jiffies
-		 * is nonzero if the timer bottom half hasnt executed yet.
+		 * is nonzero if the timer bottom half hasn't executed yet.
 		 */
 		if (jiffies - wall_jiffies)
 			tv->tv_usec += USECS_PER_JIFFY;
diff -ur a/drivers/message/i2o/i2o_core.c b/drivers/message/i2o/i2o_core.c
--- a/drivers/message/i2o/i2o_core.c	Mon Feb 24 11:05:35 2003
+++ b/drivers/message/i2o/i2o_core.c	Tue Feb 25 09:48:54 2003
@@ -2619,7 +2619,7 @@
 	{
 		/* 
 		 *	Mark the entry dead. We cannot remove it. This is important.
-		 *	When it does terminate (which it must do if the controller hasnt
+		 *	When it does terminate (which it must do if the controller hasn't
 		 *	died..) then it will otherwise scribble on stuff.
 		 *	!complete lets us safely check if the entry is still
 		 *	allocated and thus we can write into it
