Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264920AbTBGQwK>; Fri, 7 Feb 2003 11:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265960AbTBGQwK>; Fri, 7 Feb 2003 11:52:10 -0500
Received: from nycsmtp1out.rdc-nyc.rr.com ([24.29.99.222]:40443 "EHLO
	nycsmtp1out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S264920AbTBGQwJ>; Fri, 7 Feb 2003 11:52:09 -0500
Date: Fri, 7 Feb 2003 12:11:15 -0500 (EST)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@master
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com, <trivial@rustcorp.com.au>
Subject: [PATCH] 2.5.59 : sound/oss/cs46xx.c
Message-ID: <Pine.LNX.4.44.0302071209580.6917-100000@master>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
   The following patch addresses buzilla bug # 317, and removes an
offending semicolon. Please review for inclusion.

Regards,
Frank

--- linux/sound/oss/cs46xx.c.old	2003-01-16 21:21:34.000000000 -0500
+++ linux/sound/oss/cs46xx.c	2003-02-07 03:01:28.000000000 -0500
@@ -4314,7 +4314,7 @@
     {
         offset = ClrStat[i].BA1__DestByteOffset;
         count  = ClrStat[i].BA1__SourceSize;
-        for(  temp1 = offset; temp1<(offset+count); temp1+=4 );
+        for(  temp1 = offset; temp1<(offset+count); temp1+=4 )
               writel(0, pBA1+temp1);
     }
 

