Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313638AbSFCDIw>; Sun, 2 Jun 2002 23:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313711AbSFCDIv>; Sun, 2 Jun 2002 23:08:51 -0400
Received: from front2.mail.megapathdsl.net ([66.80.60.30]:1548 "EHLO
	front2.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S313638AbSFCDIv>; Sun, 2 Jun 2002 23:08:51 -0400
Subject: 2.5.20 -- suspend.c still breaks the build (originally reported for
	2.5.18)
From: Miles Lane <miles@megapathdsl.net>
To: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0206021853030.1383-100000@penguin.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 02 Jun 2002 20:06:49 -0700
Message-Id: <1023073620.1685.10.camel@turbulence.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

suspend.c: In function `freeze_processes':
suspend.c:234: warning: implicit declaration of function `signal_wake_up'
suspend.c: In function `fill_suspend_header':
suspend.c:286: warning: comparison between pointer and integer
suspend.c:305:2: #error this is broken, FIXME
suspend.c: In function `do_suspend_sync':
suspend.c:306: `tq_disk' undeclared (first use in this function)
suspend.c:306: (Each undeclared identifier is reported only once
suspend.c:306: for each function it appears in.)
suspend.c: In function `write_suspend_image':
suspend.c:431: warning: passing arg 3 of `get_swaphandle_info' from incompatible pointer type
suspend.c:430: warning: unused variable `dummy2'
suspend.c: In function `count_and_copy_data_pages':
suspend.c:536: warning: passing arg 1 of `mmx_copy_page' makes pointer from integer without a cast
suspend.c:536: warning: passing arg 2 of `mmx_copy_page' makes pointer from integer without a cast
suspend.c: In function `suspend_save_image':
suspend.c:724: warning: assignment makes integer from pointer without a cast
suspend.c: In function `resume_try_to_read':
suspend.c:1059: warning: passing arg 1 of `name_to_kdev_t' discards qualifiers from pointer target type
suspend.c:1067: warning: unsigned int format, kdev_t arg (arg 2)
suspend.c:1057: warning: unused variable `blksize'
suspend.c: At top level:
suspend.c:1221: warning: static declaration for `resume_setup' follows non-static
make[1]: *** [suspend.o] Error 1
make[1]: Leaving directory `/usr/src/linux/kernel'


