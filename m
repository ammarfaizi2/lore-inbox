Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315471AbSE2UYI>; Wed, 29 May 2002 16:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315463AbSE2UYH>; Wed, 29 May 2002 16:24:07 -0400
Received: from nycsmtp3fa.rdc-nyc.rr.com ([24.29.99.79]:27921 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S315462AbSE2UYF>;
	Wed, 29 May 2002 16:24:05 -0400
Date: Wed, 29 May 2002 16:14:52 -0400 (EDT)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: <fdavis@localhost.localdomain>
To: <linux-kernel@vger.kernel.org>
Subject: 2.5.19 : 'make dep' error
Message-ID: <Pine.LNX.4.33.0205291611040.8639-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
  I received the following error for 'make dep' . 2.5.18 works fine. 'make 
mrproper' was done after patching from 2.5.18. 
Regards,
Frank

make[1]: Entering directory `/usr/src/linux/scripts'
gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -o split-include split-include.c
In file included from /usr/include/linux/errno.h:4,
                 from /usr/include/bits/errno.h:25,
                 from /usr/include/errno.h:36,
                 from split-include.c:26:
/usr/include/asm/errno.h:4:31: asm-generic/errno.h: No such file or directory
make[1]: *** [split-include] Error 1
make[1]: Leaving directory `/usr/src/linux/scripts'
make: *** [scripts/mkdep] Error 2

