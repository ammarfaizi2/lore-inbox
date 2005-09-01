Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030517AbVIAXPB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030517AbVIAXPB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 19:15:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030518AbVIAXPB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 19:15:01 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:31759 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030517AbVIAXPA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 19:15:00 -0400
Date: Fri, 2 Sep 2005 01:14:59 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] feature-removal-schedule.txt: remove {,un}register_serial entry
Message-ID: <20050901231459.GE3657@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If the feature is removed, there's no need to keep the entry in 
feature-removal-schedule.txt.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.13-mm1-full/Documentation/feature-removal-schedule.txt.old	2005-09-02 01:13:12.000000000 +0200
+++ linux-2.6.13-mm1-full/Documentation/feature-removal-schedule.txt	2005-09-02 01:13:29.000000000 +0200
@@ -77,16 +77,6 @@
 
 ---------------------------
 
-What:	register_serial/unregister_serial
-When:	September 2005
-Why:	This interface does not allow serial ports to be registered against
-	a struct device, and as such does not allow correct power management
-	of such ports.  8250-based ports should use serial8250_register_port
-	and serial8250_unregister_port, or platform devices instead.
-Who:	Russell King <rmk@arm.linux.org.uk>
-
----------------------------
-
 What:	i2c sysfs name change: in1_ref, vid deprecated in favour of cpu0_vid
 When:	November 2005
 Files:	drivers/i2c/chips/adm1025.c, drivers/i2c/chips/adm1026.c

