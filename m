Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314444AbSEKEcx>; Sat, 11 May 2002 00:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314544AbSEKEcw>; Sat, 11 May 2002 00:32:52 -0400
Received: from nycsmtp2fb.rdc-nyc.rr.com ([24.29.99.78]:11276 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S314444AbSEKEcv>;
	Sat, 11 May 2002 00:32:51 -0400
Date: Sat, 11 May 2002 00:24:02 -0400 (EDT)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: <fdavis@localhost.localdomain>
To: <linux-kernel@vger.kernel.org>
cc: <fdavis@si.rr.com>
Subject: [PATCH] 2.5.15 : drivers/block/paride/pd.c minor unused var
Message-ID: <Pine.LNX.4.33.0205110022030.4085-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
  This patch removes an unused function variable..

Regards,
Frank

--- drivers/block/paride/pd.c.old	Sat May  4 12:23:09 2002
+++ drivers/block/paride/pd.c	Sat May 11 00:14:07 2002
@@ -382,7 +382,7 @@
 
 int pd_init (void)
 
-{       int i;
+{       
 	request_queue_t * q; 
 
 	if (disable) return -1;

