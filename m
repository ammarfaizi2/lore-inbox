Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283092AbRK2IMs>; Thu, 29 Nov 2001 03:12:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283094AbRK2IMi>; Thu, 29 Nov 2001 03:12:38 -0500
Received: from gateway-2.hyperlink.com ([213.52.152.2]:59658 "EHLO
	core-gateway-1.hyperlink.com") by vger.kernel.org with ESMTP
	id <S283092AbRK2IMX>; Thu, 29 Nov 2001 03:12:23 -0500
Message-ID: <2791.10.119.8.1.1007021586.squirrel@extranet.jtrix.com>
Date: Thu, 29 Nov 2001 08:13:06 -0000 (GMT)
Subject: linux-2.5.1pre3 compile error - pd.c
From: "Martin A. Brooks" <martin@jtrix.com>
To: <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.0 [rc2])
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc -D__KERNEL__ -I/home/martin/kernel-a-day-club/linux/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686    -c -o pd.o pd.c
pd.c: In function `do_pd_request':
pd.c:856: structure has no member named `bh'
pd.c: In function `pd_next_buf':
pd.c:881: `io_request_lock' undeclared (first use in this function)
pd.c:881: (Each undeclared identifier is reported only once
pd.c:881: for each function it appears in.)
pd.c: In function `do_pd_read_start':
pd.c:922: `io_request_lock' undeclared (first use in this function)
pd.c: In function `do_pd_read_drq':
pd.c:946: `io_request_lock' undeclared (first use in this function)
pd.c: In function `do_pd_write_start':
pd.c:988: `io_request_lock' undeclared (first use in this function)
pd.c: In function `do_pd_write_done':
pd.c:1033: `io_request_lock' undeclared (first use in this function)
make[4]: *** [pd.o] Error 1

--
Martin A. Brooks   Systems Administrator
Jtrix Ltd          t: +44 7395 4990
57-59 Neal Street  f: +44 7395 4991
London, WC2H 9PP   e: martin@jtrix.com


