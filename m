Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261665AbVCMDxm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261665AbVCMDxm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 22:53:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262677AbVCMDxm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 22:53:42 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:7430 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261665AbVCMDxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 22:53:35 -0500
Date: Sun, 13 Mar 2005 04:53:30 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: kraxel@bytesex.org, video4linux-list@redhat.com,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/media/video/tvaudio.c: make some variables static
Message-ID: <20050313035330.GQ3814@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes some needlessly global variables static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 16 Feb 2005

 tvaudio.c |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

--- linux-2.6.11-rc3-mm2-full/drivers/media/video/tvaudio.c.old	2005-02-15 22:13:38.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/media/video/tvaudio.c	2005-02-15 22:14:29.000000000 +0100
@@ -1237,17 +1237,17 @@
 /* audio chip descriptions - struct CHIPDESC                              */
 
 /* insmod options to enable/disable individual audio chips */
-int tda8425  = 1;
-int tda9840  = 1;
-int tda9850  = 1;
-int tda9855  = 1;
-int tda9873  = 1;
-int tda9874a = 1;
-int tea6300  = 0;  // address clash with msp34xx
-int tea6320  = 0;  // address clash with msp34xx
-int tea6420  = 1;
-int pic16c54 = 1;
-int ta8874z  = 0;  // address clash with tda9840
+static int tda8425  = 1;
+static int tda9840  = 1;
+static int tda9850  = 1;
+static int tda9855  = 1;
+static int tda9873  = 1;
+static int tda9874a = 1;
+static int tea6300  = 0;  // address clash with msp34xx
+static int tea6320  = 0;  // address clash with msp34xx
+static int tea6420  = 1;
+static int pic16c54 = 1;
+static int ta8874z  = 0;  // address clash with tda9840
 
 module_param(tda8425, int, 0444);
 module_param(tda9840, int, 0444);

