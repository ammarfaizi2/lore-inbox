Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266043AbTBGQl5>; Fri, 7 Feb 2003 11:41:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266069AbTBGQl5>; Fri, 7 Feb 2003 11:41:57 -0500
Received: from nycsmtp3out.rdc-nyc.rr.com ([24.29.99.224]:42155 "EHLO
	nycsmtp3out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S266043AbTBGQlz>; Fri, 7 Feb 2003 11:41:55 -0500
Date: Fri, 7 Feb 2003 12:01:00 -0500 (EST)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@master
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com, <trivial@rustcorp.com.au>
Subject: [PATCH] 2.5.59 : drivers/media/video/w9966.c
Message-ID: <Pine.LNX.4.44.0302071159220.6917-100000@master>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
   The following patch addresses buzilla bug # 310, and removes an
offending semicolon. Please review for inclusion.

Regards,
Frank

--- linux/drivers/media/video/w9966.c.old	2003-01-16 21:21:46.000000000 -0500
+++ linux/drivers/media/video/w9966.c	2003-02-07 03:14:42.000000000 -0500
@@ -742,7 +742,7 @@
 	case VIDIOCGTUNER:
 	{
 		struct video_tuner *vtune = arg;
-		if(vtune->tuner != 0);
+		if(vtune->tuner != 0)
 			return -EINVAL;
 		strcpy(vtune->name, "no tuner");
 		vtune->rangelow = 0;

