Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314548AbSEKEaw>; Sat, 11 May 2002 00:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314557AbSEKEav>; Sat, 11 May 2002 00:30:51 -0400
Received: from nycsmtp2fb.rdc-nyc.rr.com ([24.29.99.78]:47115 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S314548AbSEKEav>;
	Sat, 11 May 2002 00:30:51 -0400
Date: Sat, 11 May 2002 00:22:01 -0400 (EDT)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: <fdavis@localhost.localdomain>
To: <linux-kernel@vger.kernel.org>
cc: <fdavis@si.rr.com>
Subject: [PATCH] 2.5.15 : drivers/block/paride/pcd.c minor unused var patch
Message-ID: <Pine.LNX.4.33.0205110017490.4085-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
  The following just removes an unused varible (Didn't see this posted 
yet). 

Regards,
Frank 

--- drivers/block/paride/pcd.c.old	Sat May  4 12:23:09 2002
+++ drivers/block/paride/pcd.c	Sat May 11 00:15:10 2002
@@ -330,7 +330,7 @@
 
 int pcd_init (void)	/* preliminary initialisation */
 
-{       int 	i, unit;
+{       int unit;
 
 	if (disable) return -1;
 


