Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312767AbSCVRth>; Fri, 22 Mar 2002 12:49:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312768AbSCVRt1>; Fri, 22 Mar 2002 12:49:27 -0500
Received: from tstac.esa.lanl.gov ([128.165.46.3]:59011 "EHLO
	tstac.esa.lanl.gov") by vger.kernel.org with ESMTP
	id <S312767AbSCVRtW>; Fri, 22 Mar 2002 12:49:22 -0500
Subject: [PATCH] 2.5.7-dj1, add 3 help texts to arch/alpha/Config.help
From: Steven Cole <elenstev@mesatop.com>
To: Dave Jones <davej@suse.de>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 22 Mar 2002 10:46:36 -0700
Message-Id: <1016819196.24906.66.camel@spc.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds three help texts to arch/alpha/Config.help.
The texts were obtained from ESR's v2.97 Configure.help.

Steven

--- linux-2.5.7-dj1/arch/alpha/Config.help.orig	Fri Mar 22 10:08:02 2002
+++ linux-2.5.7-dj1/arch/alpha/Config.help	Fri Mar 22 10:15:47 2002
@@ -251,6 +251,10 @@
 CONFIG_ALPHA_GAMMA
   Say Y if you have an AS 2000 5/xxx or an AS 2100 5/xxx.
 
+CONFIG_ALPHA_EV67
+  Is this a machine based on the EV67 core?  If in doubt, select N here
+  and the machine will be treated as an EV6.
+
 CONFIG_ALPHA_SRM
   There are two different types of booting firmware on Alphas: SRM,
   which is command line driven, and ARC, which uses menus and arrow
@@ -592,4 +596,15 @@
   and certain other kinds of spinlock errors commonly made.  This is
   best used in conjunction with the NMI watchdog so that spinlock
   deadlocks are also debuggable.
+
+CONFIG_DEBUG_RWLOCK
+  If you say Y here then read-write lock processing will count how many
+  times it has tried to get the lock and issue an error message after
+  too many attempts.  If you suspect a rwlock problem or a kernel
+  hacker asks for this option then say Y.  Otherwise say N.
+
+CONFIG_DEBUG_SEMAPHORE
+  If you say Y here then semaphore processing will issue lots of
+  verbose debugging messages.  If you suspect a semaphore problem or a
+  kernel hacker asks for this option then say Y.  Otherwise say N.
 





