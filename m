Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271741AbRJXONc>; Wed, 24 Oct 2001 10:13:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271800AbRJXONW>; Wed, 24 Oct 2001 10:13:22 -0400
Received: from oceanic.wsisiz.edu.pl ([213.135.44.33]:56893 "HELO
	oceanic.wsisiz.edu.pl") by vger.kernel.org with SMTP
	id <S271741AbRJXONO>; Wed, 24 Oct 2001 10:13:14 -0400
Date: Wed, 24 Oct 2001 16:13:47 +0200 (CEST)
From: Lukasz Trabinski <lukasz@wsisiz.edu.pl>
To: <linux-kernel@vger.kernel.org>
Subject: Two suggestions (loop and owner's of linux tree)
Message-ID: <Pine.LNX.4.33.0110241605020.12884-100000@oceanic.wsisiz.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I would like to suggest to change max_loop from 8 to 16 or more if it
possible.

--- linux.org/drivers/block/loop.c      Wed Oct 24 15:23:11 2001
+++ linux/drivers/block/loop.c  Wed Oct 24 15:24:52 2001
@@ -75,7 +75,7 @@
 
 #define MAJOR_NR LOOP_MAJOR
 
-static int max_loop = 8;
+static int max_loop = 16;
 static struct loop_device *loop_dev;
 static int *loop_sizes;
 static int *loop_blksizes;

My second suggestions is a request for change owner linux tree from 1046 
uid and 101 gid to 0.0 for security reason.  

-- 
*[ £ukasz Tr±biñski ]*
SysAdmin @wsisiz.edu.pl

