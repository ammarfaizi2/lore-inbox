Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262550AbSI0RZC>; Fri, 27 Sep 2002 13:25:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262551AbSI0RZC>; Fri, 27 Sep 2002 13:25:02 -0400
Received: from [216.40.201.6] ([216.40.201.6]:1298 "EHLO
	www.businesssite.com.br") by vger.kernel.org with ESMTP
	id <S262552AbSI0RYN>; Fri, 27 Sep 2002 13:24:13 -0400
Date: Fri, 27 Sep 2002 14:26:07 -0300
To: linux-kernel@vger.kernel.org
Subject: [patch] little fix in floppy.c
Message-ID: <20020927172607.GS20649@cathedrallabs.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ZG+WKzXzVby2T9Ro"
Content-Disposition: inline
From: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZG+WKzXzVby2T9Ro
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-- 
aris

--ZG+WKzXzVby2T9Ro
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="floppy.patch"

--- linux-2.5.38-vanilla/drivers/block/floppy.c	2002-09-22 01:25:02.000000000 -0300
+++ linux-2.5.38/drivers/block/floppy.c	2002-09-25 13:48:01.000000000 -0300
@@ -4556,7 +4556,7 @@
 
 void cleanup_module(void)
 {
-	int i;
+	int drive;
 		
 	unregister_sys_device(&device_floppy);
 	devfs_unregister (devfs_handle);

--ZG+WKzXzVby2T9Ro--
