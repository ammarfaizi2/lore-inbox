Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266186AbTBGQqY>; Fri, 7 Feb 2003 11:46:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266200AbTBGQqY>; Fri, 7 Feb 2003 11:46:24 -0500
Received: from nycsmtp1out.rdc-nyc.rr.com ([24.29.99.222]:63732 "EHLO
	nycsmtp1out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S266186AbTBGQqX>; Fri, 7 Feb 2003 11:46:23 -0500
Date: Fri, 7 Feb 2003 12:05:28 -0500 (EST)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@master
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com, <trivial@rustcorp.com.au>
Message-ID: <Pine.LNX.4.44.0302071204270.6917-100000@master>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
   The following patch addresses buzilla bug # 312, and removes an
offending semicolon. Please review for inclusion.

Regards,
Frank

--- linux/drivers/net/tokenring/smctr.c.old	2003-01-16 21:22:09.000000000 -0500
+++ linux/drivers/net/tokenring/smctr.c	2003-02-07 03:10:50.000000000 -0500
@@ -3064,7 +3064,7 @@
         __u8 r;
 
         /* Check if node address has been specified by user. (non-0) */
-        for(i = 0; ((i < 6) && (dev->dev_addr[i] == 0)); i++);
+        for(i = 0; ((i < 6) && (dev->dev_addr[i] == 0)); i++)
         {
                 if(i != 6)
                 {

