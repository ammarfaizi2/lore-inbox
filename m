Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270075AbRHSGJR>; Sun, 19 Aug 2001 02:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270076AbRHSGJH>; Sun, 19 Aug 2001 02:09:07 -0400
Received: from web10403.mail.yahoo.com ([216.136.130.95]:61191 "HELO
	web10403.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S270075AbRHSGIx>; Sun, 19 Aug 2001 02:08:53 -0400
Message-ID: <20010819060907.86161.qmail@web10403.mail.yahoo.com>
Date: Sun, 19 Aug 2001 16:09:07 +1000 (EST)
From: =?iso-8859-1?q?Steve=20Kieu?= <haiquy@yahoo.com>
Subject: gcc-3.0 with 2.2.x ?
To: kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I can use gcc-3.0 to compile 2.4.8-ac7 but can not do
that with 2.2.19

The error message is

/home/linux/include/linux/signal.h:205: warning:
deprecated use of label at end of compound statement
sched.c: At top level:
sched.c:52: conflicting types for `xtime'
/home/linux/include/linux/sched.h:508: previous
declaration of `xtime'
sched.c: In function `schedule':
sched.c:739: warning: deprecated use of label at end
of compound statement
make[2]: *** [sched.o] Error 1
make[2]: Leaving directory `/home/linux/kernel'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/home/linux/kernel'
make: *** [_dir_kernel] Error 2

so I would like to know if there is any patches to
2.2.19 to make it friendlier with gcc-3.0. In the mean
time I am going to see sched.c and sched.h and try to
make it work :-)

thanks


=====
S.KIEU

_____________________________________________________________________________
http://shopping.yahoo.com.au - Father's Day Shopping
- Find the perfect gift for your Dad for Father's Day
