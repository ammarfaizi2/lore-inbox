Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282121AbRK1K1o>; Wed, 28 Nov 2001 05:27:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282119AbRK1K1f>; Wed, 28 Nov 2001 05:27:35 -0500
Received: from gateway-2.hyperlink.com ([213.52.152.2]:18195 "EHLO
	core-gateway-1.hyperlink.com") by vger.kernel.org with ESMTP
	id <S282118AbRK1K1W>; Wed, 28 Nov 2001 05:27:22 -0500
Message-ID: <4933.10.119.8.1.1006943285.squirrel@extranet.jtrix.com>
Date: Wed, 28 Nov 2001 10:28:05 -0000 (GMT)
Subject: 2.5.1pre2 build error
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
pd.c: In function `pd_init':
pd.c:397: too few arguments to function `blk_init_queue'
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
make[4]: Leaving directory
`/home/martin/kernel-a-day-club/linux/drivers/block/paride'
make[3]: *** [first_rule] Error 2
make[3]: Leaving directory
`/home/martin/kernel-a-day-club/linux/drivers/block/paride'
make[2]: *** [_subdir_paride] Error 2
make[2]: Leaving directory
`/home/martin/kernel-a-day-club/linux/drivers/block'make[1]: *** [_subdir_block] Error 2
make[1]: Leaving directory `/home/martin/kernel-a-day-club/linux/drivers'
make: *** [_dir_drivers] Error 2

Martin A. Brooks   Systems Administrator
Jtrix Ltd          t: +44 7395 4990
57-59 Neal Street  f: +44 7395 4991
London, WC2H 9PP   e: martin@jtrix.com


