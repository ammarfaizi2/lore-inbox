Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266135AbTBGQoN>; Fri, 7 Feb 2003 11:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266175AbTBGQoN>; Fri, 7 Feb 2003 11:44:13 -0500
Received: from nycsmtp1out.rdc-nyc.rr.com ([24.29.99.222]:12274 "EHLO
	nycsmtp1out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S266135AbTBGQoM>; Fri, 7 Feb 2003 11:44:12 -0500
Date: Fri, 7 Feb 2003 12:03:16 -0500 (EST)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@master
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com, <trivial@rustcorp.com.au>
Subject: [PATCH] 2.5.59 : drivers/net/amd8111e.c
Message-ID: <Pine.LNX.4.44.0302071201030.6917-100000@master>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
   The following patch addresses buzilla bug # 311, and removes an
offending semicolon. Please review for inclusion.

Regards,
Frank

--- linux/drivers/net/amd8111e.c.old	2003-01-16 21:22:17.000000000 -0500
+++ linux/drivers/net/amd8111e.c	2003-02-07 03:12:29.000000000 -0500
@@ -953,7 +953,7 @@
      	reg_buff = kmalloc( AMD8111E_REG_DUMP_LEN,GFP_KERNEL);
 	if(NULL == reg_buff)
 		return NULL;
-    	for( i=0; i< AMD8111E_REG_DUMP_LEN;i+=4);
+    	for( i=0; i< AMD8111E_REG_DUMP_LEN;i+=4)
 		reg_buff[i]= readl(mmio + i);	
 	return reg_buff;
 }

