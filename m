Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268248AbTBYUVO>; Tue, 25 Feb 2003 15:21:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268295AbTBYUVO>; Tue, 25 Feb 2003 15:21:14 -0500
Received: from [24.77.48.240] ([24.77.48.240]:39977 "EHLO aiinc.aiinc.ca")
	by vger.kernel.org with ESMTP id <S268248AbTBYUVD>;
	Tue, 25 Feb 2003 15:21:03 -0500
Date: Tue, 25 Feb 2003 12:31:18 -0800
From: Michael Hayes <mike@aiinc.ca>
Message-Id: <200302252031.h1PKVIV24908@aiinc.aiinc.ca>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Spelling fixes for 2.5.63 - couldn't
Cc: torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes:
    couldnt -> couldn't (5 occurrences)

diff -ur a/arch/i386/kernel/smpboot.c b/arch/i386/kernel/smpboot.c
--- a/arch/i386/kernel/smpboot.c	Mon Feb 24 11:05:31 2003
+++ b/arch/i386/kernel/smpboot.c	Tue Feb 25 09:50:50 2003
@@ -956,7 +956,7 @@
 	smp_tune_scheduling();
 
 	/*
-	 * If we couldnt find an SMP configuration at boot time,
+	 * If we couldn't find an SMP configuration at boot time,
 	 * get out of here now!
 	 */
 	if (!smp_found_config) {
diff -ur a/arch/ia64/sn/fakeprom/fpromasm.S b/arch/ia64/sn/fakeprom/fpromasm.S
--- a/arch/ia64/sn/fakeprom/fpromasm.S	Mon Feb 24 11:05:14 2003
+++ b/arch/ia64/sn/fakeprom/fpromasm.S	Tue Feb 25 09:50:53 2003
@@ -38,7 +38,7 @@
  *		- determine the base address of the node it is loaded on
  *		- add the node base to _gp.
  *		- add the node base to all addresses derived from "movl" 
- *		  instructions. (I couldnt get GPREL addressing to work)
+ *		  instructions. (I couldn't get GPREL addressing to work)
  *		  (maybe newer versions of the tools will support this)
  *		- scan the .got section and add the node base to all
  *		  pointers in this section.
diff -ur a/arch/x86_64/kernel/smpboot.c b/arch/x86_64/kernel/smpboot.c
--- a/arch/x86_64/kernel/smpboot.c	Mon Feb 24 11:06:02 2003
+++ b/arch/x86_64/kernel/smpboot.c	Tue Feb 25 09:50:55 2003
@@ -774,7 +774,7 @@
 	}
 
 	/*
-	 * If we couldnt find an SMP configuration at boot time,
+	 * If we couldn't find an SMP configuration at boot time,
 	 * get out of here now!
 	 */
 	if (!smp_found_config) {
diff -ur a/drivers/md/md.c b/drivers/md/md.c
--- a/drivers/md/md.c	Mon Feb 24 11:05:14 2003
+++ b/drivers/md/md.c	Tue Feb 25 09:50:59 2003
@@ -2290,7 +2290,7 @@
 				}
 				err = set_array_info(mddev, &info);
 				if (err) {
-					printk(KERN_WARNING "md: couldnt set array info. %d\n", err);
+					printk(KERN_WARNING "md: couldn't set array info. %d\n", err);
 					goto abort_unlock;
 				}
 			}
diff -ur a/drivers/usb/media/konicawc.c b/drivers/usb/media/konicawc.c
--- a/drivers/usb/media/konicawc.c	Mon Feb 24 11:05:04 2003
+++ b/drivers/usb/media/konicawc.c	Tue Feb 25 09:51:01 2003
@@ -607,7 +607,7 @@
 	}
 
 	if(newsize > MAX_FRAME_SIZE) {
-		DEBUG(1, "couldnt find size %d,%d", x, y);
+		DEBUG(1, "couldn't find size %d,%d", x, y);
 		return -EINVAL;
 	}
 
