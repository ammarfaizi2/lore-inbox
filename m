Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262375AbSI2Cjr>; Sat, 28 Sep 2002 22:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262376AbSI2Cjq>; Sat, 28 Sep 2002 22:39:46 -0400
Received: from h66-38-216-165.gtconnect.net ([66.38.216.165]:23560 "HELO
	innerfire.net") by vger.kernel.org with SMTP id <S262375AbSI2Cjp>;
	Sat, 28 Sep 2002 22:39:45 -0400
Date: Sat, 28 Sep 2002 22:45:04 -0400 (EDT)
From: Gerhard Mack <gmack@innerfire.net>
To: linux-kernel@vger.kernel.org
Subject: compile fails at aty128fb.c 
Message-ID: <Pine.LNX.4.44.0209282241580.19242-100000@innerfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Got this when trying to compile with gcc 2.95.4

aty128fb.c:419: unknown field `fb_get_fix' specified in initializer
aty128fb.c:419: warning: initialization from incompatible pointer type
aty128fb.c:420: unknown field `fb_get_var' specified in initializer
aty128fb.c:420: warning: initialization from incompatible pointer type
aty128fb.c: In function `aty128fb_set_var':
aty128fb.c:1379: structure has no member named `visual'
aty128fb.c:1380: structure has no member named `type'
aty128fb.c:1381: structure has no member named `type_aux'
aty128fb.c:1382: structure has no member named `ypanstep'
aty128fb.c:1383: structure has no member named `ywrapstep'
aty128fb.c:1384: structure has no member named `line_length'
make[2]: *** [aty128fb.o] Error 1
make[2]: Leaving directory `/root/linux-2.5.39/drivers/video'
make[1]: *** [video] Error 2
make[1]: Leaving directory `/root/linux-2.5.39/drivers'
make: *** [drivers] Error 2

--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.

