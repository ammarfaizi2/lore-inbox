Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264654AbSLQEan>; Mon, 16 Dec 2002 23:30:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264657AbSLQEan>; Mon, 16 Dec 2002 23:30:43 -0500
Received: from smtp802.mail.sc5.yahoo.com ([66.163.168.181]:43294 "HELO
	smtp802.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id <S264654AbSLQEan>; Mon, 16 Dec 2002 23:30:43 -0500
From: "Joseph D. Wagner" <wagnerjd@prodigy.net>
To: "Linux Kernel" <linux-kernel@vger.kernel.org>
Subject: Problem using "make config/xconfig" with 2.4.20 on Redhat 7.3
Date: Mon, 16 Dec 2002 22:38:38 -0600
Message-ID: <000001c2a586$2feb5db0$e50f3941@joe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I must be doing something wrong, but I can't figure out what.

I've downloaded kernel version 2.4.20 from http://www.kernel.org and copied
it to the /usr/src/linux-2.4.20 directory, but when I do "make xconfig" (or
any other "make" for that matter, it exits with error code 2.

I figure there is some Redhat-specific tweaking I must do to compile a
generic kernel from http://www.kernel.org on a Redhat system, but I have no
idea what that specific tweaking is.  The people at the Redhat-devel list
were of no help so I'm turning to you guys.

Could someone help me, please?

BTW, I'm using Redhat Linux 7.3.

Here's my output from "make xconfig":

rm -f include/asm
( cd include ; ln -sf asm-i386 asm)
make -C scripts kconfig.tk
make[1]: Entering directory `/usr/src/linux-2.4.20/scripts'
cat header.tk >> ./kconfig.tk
./tkparse < ../arch/i386/config.in >> kconfig.tk
-: 6: unknown command
make[1]: *** [kconfig.tk] Error 1
make[1]: Leaving directory `/usr/src/linux-2.4.20/scripts'
make: *** [xconfig] Error 2

TIA

Joseph Wagner

