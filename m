Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272626AbTG1BH1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 21:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272561AbTG1ADz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 20:03:55 -0400
Received: from zeus.kernel.org ([204.152.189.113]:28659 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S272730AbTG0W6V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 18:58:21 -0400
Date: Sun, 27 Jul 2003 21:20:15 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307272020.h6RKKFjU029777@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: typo fix for time.h
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Steven Cole)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/include/linux/time.h linux-2.6.0-test2-ac1/include/linux/time.h
--- linux-2.6.0-test2/include/linux/time.h	2003-07-14 14:11:56.000000000 +0100
+++ linux-2.6.0-test2-ac1/include/linux/time.h	2003-07-23 16:39:58.000000000 +0100
@@ -118,7 +118,7 @@
 jiffies_to_timespec(unsigned long jiffies, struct timespec *value)
 {
 	/*
-	 * Convert jiffies to nanoseconds and seperate with
+	 * Convert jiffies to nanoseconds and separate with
 	 * one divide.
 	 */
 	u64 nsec = (u64)jiffies * TICK_NSEC; 
@@ -146,7 +146,7 @@
 jiffies_to_timeval(unsigned long jiffies, struct timeval *value)
 {
 	/*
-	 * Convert jiffies to nanoseconds and seperate with
+	 * Convert jiffies to nanoseconds and separate with
 	 * one divide.
 	 */
 	u64 nsec = (u64)jiffies * TICK_NSEC; 
