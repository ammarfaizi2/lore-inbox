Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265851AbTATNnk>; Mon, 20 Jan 2003 08:43:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265854AbTATNnj>; Mon, 20 Jan 2003 08:43:39 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:640 "EHLO bilbo.tmr.com")
	by vger.kernel.org with ESMTP id <S265851AbTATNnj>;
	Mon, 20 Jan 2003 08:43:39 -0500
Date: Mon, 20 Jan 2003 08:50:25 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
X-X-Sender: root@bilbo.tmr.com
Reply-To: Bill Davidsen <davidsen@tmr.com>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [2.5] ne.o doesn't build
Message-ID: <Pine.LNX.4.44.0301200848010.4733-100000@bilbo.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.56, 2.57, etc. I'll look at this later in the week when I have more 
time.

make -j2 -f scripts/Makefile.build obj=drivers/usb/storage
make -j2 -f scripts/Makefile.build obj=drivers/video
make -j2 -f scripts/Makefile.build obj=drivers/video/console
drivers/net/ne.c: In function `cleanup_module':
drivers/net/ne.c:791: dereferencing pointer to incomplete type
make[2]: *** [drivers/net/ne.o] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [drivers/net] Error 2
make: *** [drivers] Error 2

-- 
bill davidsen, CTO TMR Associates, Inc <davidsen@tmr.com>
  Having the feature freeze for Linux 2.5 on Hallow'een is appropriate,
since using 2.5 kernels includes a lot of things jumping out of dark
corners to scare you.


