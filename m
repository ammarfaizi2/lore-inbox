Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276914AbRJ0TvC>; Sat, 27 Oct 2001 15:51:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276956AbRJ0Tuv>; Sat, 27 Oct 2001 15:50:51 -0400
Received: from mailgate5.cinetic.de ([217.72.192.165]:18148 "EHLO
	mailgate5.cinetic.de") by vger.kernel.org with ESMTP
	id <S276914AbRJ0Tug>; Sat, 27 Oct 2001 15:50:36 -0400
Message-Id: <m15xZU0-007qoFC@smtp.web.de>
Content-Type: text/plain;
  charset="iso-8859-1"
From: =?iso-8859-1?q?Ren=E9=20Scharfe?= <l.s.r@web.de>
To: Linus Torvalds <torvalds@transmeta.com>, Alan Cox <alan@redhat.com>
Subject: Re: [PATCH] strtok --> strsep in framebuffer drivers
Date: Sat, 27 Oct 2001 21:48:18 +0200
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <Pine.LNX.4.33.0110251739440.1118-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0110251739440.1118-100000@penguin.transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I suspect my last patch on that subject was too fat to get very far.
Here it comes again, this time nicely sliced.

This part just adds a missing '}' to virgefb.c which I failed to
provide in the first patch.

René 



diff -ruN linux-2.4.14-pre2/drivers/video/virgefb.c linux-2.4.14-pre2-rs/drivers/video/virgefb.c
--- linux-2.4.14-pre2/drivers/video/virgefb.c	Fri Oct 26 23:07:21 2001
+++ linux-2.4.14-pre2-rs/drivers/video/virgefb.c	Fri Oct 26 23:33:08 2001
@@ -1099,6 +1101,7 @@
 		}
 		else
 			get_video_mode(this_opt);
+	}
 
 	DPRINTK("default mode: xres=%d, yres=%d, bpp=%d\n",virgefb_default.xres,
                                                            virgefb_default.yres,

