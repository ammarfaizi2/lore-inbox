Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131644AbRCZPuw>; Mon, 26 Mar 2001 10:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131889AbRCZPuc>; Mon, 26 Mar 2001 10:50:32 -0500
Received: from mail-out.chello.nl ([213.46.240.7]:834 "EHLO
	amsmta02-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S131644AbRCZPuW>; Mon, 26 Mar 2001 10:50:22 -0500
Message-Id: <5.0.2.1.2.20010326175151.01eef100@pop.wanadoo.nl>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Mon, 26 Mar 2001 18:00:36 +0200
To: linux-kernel@vger.kernel.org
From: Theodoor Scholte <tscholte@wanadoo.nl>
Subject: Compiling problem kernel 2.4.2
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a problem with compiling kernel-2.4.2. When I want to make a bzImage 
on a RedHat Linux 5.2 box,
then I get this error-message:

gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -02
-fomit-frame-pointer -fno-strict-aliasing -pipe -march=i486  -c -o init/main.o
init/main.c
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -02
fomit-frame-pointer -fno-strict-aliasing -pipe  -march=i486
-DUTS_MACHINE='"i386"' -c -o init/version.o init/version.c
cpp: /usr/src/linux/include/linux/compile.h: Input/output error
init/version.c:20: `UTS_VERSION' undeclared here (not in a function)
init/version.c:20: initializer element for `system_utsname.version' is not
constant
init/version.c:25: parse error before `LINUX_COMPILE_BY'
make: *** [init/version.o] Error 1

I have installed these software revisions:
GNU C  egcs-2.91.66
GNU make  3.78.1
binutils  2.9.5.0.22-6
util-linux  2.10f
modutils  2.4.2
e2fsprogs  1.19

What is the solution for this problem? On a Slackware 7.1-box with the same 
software-revisions I have no problems with compiling kernel 2.4.2.

Thanks in advance,

Theodoor Scholte

