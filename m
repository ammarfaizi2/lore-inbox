Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263333AbTE0EaF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 00:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263338AbTE0EaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 00:30:05 -0400
Received: from [164.164.89.245] ([164.164.89.245]:55054 "EHLO
	snblrm01.scandentgroup.com") by vger.kernel.org with ESMTP
	id S263333AbTE0EaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 00:30:04 -0400
Subject: Re: Kernel compilation errors.
To: maha rajan <maha_rtlin@yahoo.co.in>
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OFABB8B352.2513915F-ON65256D33.00199E10@scandentgroup.com>
From: satyakumar.y@scandentgroup.com
Date: Tue, 27 May 2003 10:16:04 +0530
X-MIMETrack: Serialize by Router on snblrm01/Scandent(Release 5.0.8 |June 18, 2001) at
 05/27/2003 10:16:07 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



in function  timer.c  comment   line  35   volatile struct timeval xtime
__attribute__ ((aligned (16)));

it will compile




                                                                                                                             
                    maha rajan                                                                                               
                    <maha_rtlin@yahoo.co.in>       To:     linux-kernel@vger.kernel.org                                      
                    Sent by:                       cc:                                                                       
                    linux-kernel-owner@vger.       Subject:     Kernel compilation errors.                                   
                    kernel.org                                                                                               
                                                                                                                             
                                                                                                                             
                    05/26/2003 05:39 PM                                                                                      
                                                                                                                             
                                                                                                                             




Dear all,
  I am running a kernel 2.4.20-8 and i have the
sources of linux-2.4.4 and when i try to compile it I
get the messages below.Can you please help me with
this

gcc -D__KERNEL__ -I/usr/src2.4/linux/include -Wall
-Wstrict-prototypes -O2 -fomit-frame-pointer
-fno-strict-aliasing -pipe
-mpreferred-stack-boundary=2 -march=athlon     -c -o
timer.o timer.c
timer.c:35: conflicting types for `xtime'
/usr/src2.4/linux/include/linux/sched.h:540: previous
declaration of `xtime'
make[2]: *** [timer.o] Error 1
make[2]: Leaving directory `/usr/src2.4/linux/kernel'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/usr/src2.4/linux/kernel'
make: *** [_dir_kernel] Error 2

My system is an athlon/256MB/inboard Nvidia
video/Sound.

Thanks in advance
with regards,
Maharajan. V


________________________________________________________________________
Missed your favourite TV serial last night? Try the new, Yahoo! TV.
       visit http://in.tv.yahoo.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/




