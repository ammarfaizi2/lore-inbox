Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262648AbRFBSOX>; Sat, 2 Jun 2001 14:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262655AbRFBSOD>; Sat, 2 Jun 2001 14:14:03 -0400
Received: from iris.services.ou.edu ([129.15.2.125]:31135 "EHLO
	iris.services.ou.edu") by vger.kernel.org with ESMTP
	id <S262648AbRFBSNz>; Sat, 2 Jun 2001 14:13:55 -0400
Date: Sat, 02 Jun 2001 13:17:15 -0500
From: Sean Jones <sjones@ossm.edu>
Subject: Warning in ac6
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <3B192DAB.FF8FB3B5@ossm.edu>
MIME-version: 1.0
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-ac6 i586)
Content-type: text/plain; charset=UTF-8
Content-transfer-encoding: 7BIT
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've recieved this warning in the past several ac versions both 2.4.5
and 2.4.4. Here is the out put from the compiler:

gcc -D__KERNEL__ -I/usr/src/linux-2.4/include -Wall -Wstrict-prototypes
-O2 -fomit-frame-pointer -fno-strict-aliasing -pipe
-mpreferred-stack-boundary=2 -march=i586   -c -o init/main.o init/main.c
In file included from /usr/src/linux-2.4/include/linux/raid/md.h:50,
                 from init/main.c:24:
/usr/src/linux-2.4/include/linux/raid/md_k.h: In function
`pers_to_level':
/usr/src/linux-2.4/include/linux/raid/md_k.h:41: warning: control
reaches end of non-void function

Also the file /proc/sys/fs/binfmt_misc seems to be missing on my
machine. How would I remedy this problem?

Could you CC all responces to me because my router does not support ECN.

Thank you,

Sean Jones
