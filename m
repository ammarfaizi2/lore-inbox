Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262310AbSJWAk6>; Tue, 22 Oct 2002 20:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262328AbSJWAk6>; Tue, 22 Oct 2002 20:40:58 -0400
Received: from nycsmtp1out.rdc-nyc.rr.com ([24.29.99.226]:956 "EHLO
	nycsmtp1out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S262310AbSJWAk5>; Tue, 22 Oct 2002 20:40:57 -0400
Date: Tue, 22 Oct 2002 20:39:30 -0400 (EDT)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@localhost.localdomain
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com, <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] 2.5.44-ac1 : init/do_mounts.c
Message-ID: <Pine.LNX.4.44.0210222037370.913-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
  This patch removes an outdated macro STATIC.
Regards,
Frank

--- linux/init/do_mounts.c.old	Tue Oct 22 18:23:11 2002
+++ linux/init/do_mounts.c	Tue Oct 22 19:39:30 2002
@@ -844,8 +844,6 @@
 #define Tracec(c,x)
 #define Tracecv(c,x)
 
-#define STATIC static
-
 static int  fill_inbuf(void);
 static void flush_window(void);
 static void *malloc(int size);

