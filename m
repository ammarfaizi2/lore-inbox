Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265230AbRF0DqN>; Tue, 26 Jun 2001 23:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265232AbRF0DqD>; Tue, 26 Jun 2001 23:46:03 -0400
Received: from mail002.syd.optusnet.com.au ([203.2.75.245]:44932 "EHLO
	mail002.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id <S265230AbRF0Dpt>; Tue, 26 Jun 2001 23:45:49 -0400
Followup-To: syoungs@dingoblue.net.au
To: linux-kernel@vger.kernel.org
Subject: Compiling with gcc-3.0
From: Steve Youngs <syoungs@dingoblue.net.au>
Organization: Linux Users - Fanatics Dept.
X-Attribution: SY
X-Face: #/1'_-|5_1$xjR,mVKhpfMJcRh8"k}_a{EkIO:Ox<]@zl/Yr|H,qH#3jJi6Aw(Mg@"!+Z"C
 N_S3!3jzW^FnPeumv4l#,E}J.+e%0q(U>#b-#`~>l^A!_j5AEgpU)>t+VYZ$:El7hLa1:%%L=3%B>n
 K{^jU_{&
Date: 27 Jun 2001 13:45:20 +1000
Message-ID: <microsoft-free.x4y9qeziun.fsf@slackware.mynet.pc>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) XEmacs/21.5 (anise)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not on this list, followups set to my email address.

Trying to compile 2.4.5 with gcc-3.0 gives me this:

,----
| gcc -D__KERNEL__ -I/usr/src/linux-2.4.5/include -Wall \
|   -Wstrict-prototypes -O2 -fomit-frame-pointer \
|   -fno-strict-aliasing -pipe \
|   -mpreferred-stack-boundary=2 -march=athlon \
|   -c -o timer.o timer.c
| 
| timer.c:35: conflicting types for `xtime'
| 
| /usr/src/linux-2.4.5/include/linux/sched.h:540: \
|   previous declaration of `xtime'
| 
| make[2]: *** [timer.o] Error 1
| make[2]: Leaving directory `/usr/src/linux-2.4.5/kernel'
| make[1]: *** [first_rule] Error 2
| make[1]: Leaving directory `/usr/src/linux-2.4.5/kernel'
| make: *** [_dir_kernel] Error 2
`----

Has anyone else seen this?  Is it a problem with the kernel or gcc?
Have I just stuffed up the gcc installation?

I don't see this with gcc-2.95.2

Thanks very much for any light you can shed of this for me.

-- 
|---<Steve Youngs>---------------<GnuPG KeyID: 787C1157>---|
|              Ashes to ashes, dust to dust.               |
|      The proof of the pudding, is under the crust.       |
|-----------------------------<syoungs@dingoblue.net.au>---|
