Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274634AbRJAGnG>; Mon, 1 Oct 2001 02:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274633AbRJAGmp>; Mon, 1 Oct 2001 02:42:45 -0400
Received: from web10408.mail.yahoo.com ([216.136.130.110]:32531 "HELO
	web10408.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S274631AbRJAGmk>; Mon, 1 Oct 2001 02:42:40 -0400
Message-ID: <20011001064308.52994.qmail@web10408.mail.yahoo.com>
Date: Mon, 1 Oct 2001 16:43:08 +1000 (EST)
From: =?iso-8859-1?q?Steve=20Kieu?= <haiquy@yahoo.com>
Subject: 2.4.10-ac1 with gcc-3.0.1 compile error!
To: kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I compile with 2.95.3 is ok ; if I use gcc-3.0.1 I got

gcc -D__KERNEL__ -I/home/sk/src/linux/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2
-fomit-frame-pointer -fno-strict-aliasing -fno-common
-mcpu=i686 -march=i686 -fno-strength-reduce -pipe
-mpreferred-stack-boundary=2 -march=i686    -c -o
timer.o timer.c
timer.c:35: conflicting types for `xtime'
/home/sk/src/linux/include/linux/sched.h:573: previous
declaration of `xtime'
make[2]: *** [timer.o] Error 1
make[2]: Leaving directory `/home/sk/src/linux/kernel'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/home/sk/src/linux/kernel'
make: *** [_dir_kernel] Error 2

How can I use gcc-3.0.1? pls help.

PS this is 2.4.10-ac1 with preempt patch if it is
useful for tracking the problem.




=====
S.KIEU

http://travel.yahoo.com.au - Yahoo! Travel
- Got Itchy feet? Get inspired!
