Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274766AbRJAInf>; Mon, 1 Oct 2001 04:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274777AbRJAInY>; Mon, 1 Oct 2001 04:43:24 -0400
Received: from stuwopc24.stuwo.fh-wilhelmshaven.de ([139.13.209.24]:9363 "EHLO
	neo.konqui.de") by vger.kernel.org with ESMTP id <S274766AbRJAInK>;
	Mon, 1 Oct 2001 04:43:10 -0400
Date: Mon, 1 Oct 2001 10:43:36 +0200
From: Rainer Wiener <rainer@konqui.de>
To: Linux-Kernel-ML <linux-kernel@vger.kernel.org>
Subject: Compile problem with 2.4.10-ac1
Message-ID: <20011001104336.A20121@konqui.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22i
X-GPG-Fingerprint: 11C4 1354 5C28 A80C 6125  A634 646D DE09 6558 1999
X-Operating-System: Debian GNU/Linux Sid (Linux 2.4.9-ac18)
X-Homepage: http://www.konqui.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I just want to compile the 2.4.10-ac1 kernel. But it stops with this
message:

make[2]: Entering directory /usr/src/linux-2.4.10-ac1/kernel'
gcc -D__KERNEL__ -I/usr/src/linux-2.4.10-ac1/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=athlon     -c -o timer.o timer.c
timer.c:35: conflicting types for xtime'
/usr/src/linux-2.4.10-ac1/include/linux/sched.h:556: previous
declaration of xtime'
make[2]: *** [timer.o] Fehler 1
make[2]: Leaving directory /usr/src/linux-2.4.10-ac1/kernel'
make[1]: *** [first_rule] Fehler 2
make[1]: Leaving directory /usr/src/linux-2.4.10-ac1/kernel'
make: *** [_dir_kernel] Fehler 2

I try to find the error by my self. But I can not fix it. So has
anyone a idea?

cu
Rainer
-- 
Darth Vader:
	I find your lack of faith disturbing.
