Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287145AbSBKEsR>; Sun, 10 Feb 2002 23:48:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287193AbSBKEsI>; Sun, 10 Feb 2002 23:48:08 -0500
Received: from nycsmtp1out.rdc-nyc.rr.com ([24.29.99.226]:65197 "EHLO
	nycsmtp1out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S287145AbSBKErz>; Sun, 10 Feb 2002 23:47:55 -0500
Message-ID: <3C674CFA.2030107@nyc.rr.com>
Date: Sun, 10 Feb 2002 23:47:54 -0500
From: John Weber <weber@nyc.rr.com>
Organization: WorldWideWeber
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.4 Compile Error
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Will try to specify the problem more precisely after I play around for a 
bit, but here goes the error:

[root@boolean linux-2.5.4]# make bzImage
gcc -D__KERNEL__ -I/usr/src/linux-2.5.4/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=i686   -DKBUILD_BASENAME=main -c -o init/main.o init/main.c
In file included from /usr/src/linux-2.5.4/include/asm/thread_info.h:13,
                  from /usr/src/linux-2.5.4/include/linux/thread_info.h:10,
                  from /usr/src/linux-2.5.4/include/linux/spinlock.h:7,
                  from /usr/src/linux-2.5.4/include/linux/mmzone.h:8,
                  from /usr/src/linux-2.5.4/include/linux/gfp.h:4,
                  from /usr/src/linux-2.5.4/include/linux/slab.h:14,
                  from /usr/src/linux-2.5.4/include/linux/proc_fs.h:5,
                  from init/main.c:15:
/usr/src/linux-2.5.4/include/asm/processor.h: In function `thread_saved_pc':
/usr/src/linux-2.5.4/include/asm/processor.h:444: dereferencing pointer 
to incomplete type
make: *** [init/main.o] Error 1

