Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317811AbSFSIMs>; Wed, 19 Jun 2002 04:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317812AbSFSIMr>; Wed, 19 Jun 2002 04:12:47 -0400
Received: from grunt.ksu.ksu.edu ([129.130.12.17]:27293 "EHLO
	mailhub.cns.ksu.edu") by vger.kernel.org with ESMTP
	id <S317811AbSFSIMr>; Wed, 19 Jun 2002 04:12:47 -0400
Date: Wed, 19 Jun 2002 03:12:48 -0500
From: Joseph Pingenot <trelane@digitasaru.net>
To: linux-kernel@vger.kernel.org
Subject: Build problem in sched.c in 2.5.23
Message-ID: <20020619031247.B5211@ksu.edu>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
X-School: Kansas State University
X-vi-or-emacs: vi
X-MSMail-Priority: High
X-Priority: 1 (Highest)
X-MS-TNEF-Correlator: <AFJAUFHRUOGRESULWAOIHFEAUIOFBVHSHNRAIU.monkey@spamcentral.invalid>
X-MimeOLE: Not Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make[1]: Entering directory `/usr/local/src/kernel/linux-2.5.23/kernel'
  gcc -Wp,-MD,./.sched.o.d -D__KERNEL__ -I/usr/local/src/kernel/linux-2.5.23/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -nostdinc -iwithprefix include    -fno-omit-frame-pointer -DKBUILD_BASENAME=sched   -c -o sched.o sched.c
sched.c: In function `sys_sched_setaffinity':
sched.c:1332: `cpu_online_map' undeclared (first use in this function)
sched.c:1332: (Each undeclared identifier is reported only once
sched.c:1332: for each function it appears in.)
sched.c: In function `sys_sched_getaffinity':
sched.c:1391: `cpu_online_map' undeclared (first use in this function)
make[1]: *** [sched.o] Error 1
make[1]: Leaving directory `/usr/local/src/kernel/linux-2.5.23/kernel'
make: *** [kernel] Error 2

Need any more details?
-- 
Joseph======================================================jap3003@ksu.edu
"[...]this, they say, cost about $40 too much, and about 20,000 Iowans 
 bought [Windows] 98.  Which gives us a tab of $800,000, i.e. the
 equivalent of a rounding error in Redmond's vast war chest." -The Register
