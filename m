Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270316AbSISIFu>; Thu, 19 Sep 2002 04:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270373AbSISIFu>; Thu, 19 Sep 2002 04:05:50 -0400
Received: from moutvdom.kundenserver.de ([195.20.224.149]:50902 "EHLO
	moutvdom.kundenserver.de") by vger.kernel.org with ESMTP
	id <S270316AbSISIFq> convert rfc822-to-8bit; Thu, 19 Sep 2002 04:05:46 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Rene von Grillo <renevongrillo@online.de>
Reply-To: renevongrillo@online.de
To: linux-kernel@vger.kernel.org
Subject: Problem: No such file: linux/limits.h
Date: Thu, 19 Sep 2002 10:11:52 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200209191011.52778.renevongrillo@online.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo,

I have a problem compiling the kernel 2.4.19.
The running kernel is linux-2.4.10.SuSE.

The packed file was from www.kernel.org; I have unzipped it into 
/usr/src/linux-2.4.19 and made a new symbolic link /usr/linux to it.
Then I have run make xconfig and saved the configuration.
Now the problem:

vongrillo:/usr/src/linux # make dep
gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -o scripts/mkdep 
scripts/mkdep.c
In file included from /usr/include/bits/posix1_lim.h:126,
                 from /usr/include/limits.h:144,
                 from 
/usr/lib/gcc-lib/i486-suse-linux/2.95.3/include/limits.h:117,
                 from 
/usr/lib/gcc-lib/i486-suse-linux/2.95.3/include/syslimits.h:7,
                 from 
/usr/lib/gcc-lib/i486-suse-linux/2.95.3/include/limits.h:11,
                 from scripts/mkdep.c:35:
/usr/include/bits/local_lim.h:36: linux/limits.h: No such file or directory
make: *** [scripts/mkdep] Error 1

In the directory /usr/linux is now such file. And I have found more than 1 
file "limits.h".
Which file "limits.h" is the right?


Best regards
RvG
