Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266443AbTBGQyB>; Fri, 7 Feb 2003 11:54:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266453AbTBGQyA>; Fri, 7 Feb 2003 11:54:00 -0500
Received: from nycsmtp1out.rdc-nyc.rr.com ([24.29.99.222]:40701 "EHLO
	nycsmtp1out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S266443AbTBGQx7>; Fri, 7 Feb 2003 11:53:59 -0500
Date: Fri, 7 Feb 2003 12:13:04 -0500 (EST)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@master
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com, <trivial@rustcorp.com.au>
Subject: [PATCH] 2.5.59 : sound/oss/vidc.c
Message-ID: <Pine.LNX.4.44.0302071211390.6917-100000@master>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
   The following patch addresses buzilla bug # 318, and removes an
offending semicolon. Please review for inclusion.

Regards,
Frank

--- linux/sound/oss/vidc.c.old	2003-01-16 21:21:38.000000000 -0500
+++ linux/sound/oss/vidc.c	2003-02-07 02:59:44.000000000 -0500
@@ -225,7 +225,7 @@
 			newsize = 208;
 		if (newsize > 4096)
 			newsize = 4096;
-		for (new2size = 128; new2size < newsize; new2size <<= 1);
+		for (new2size = 128; new2size < newsize; new2size <<= 1)
 			if (new2size - newsize > newsize - (new2size >> 1))
 				new2size >>= 1;
 		if (new2size > 4096) {

