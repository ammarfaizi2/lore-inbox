Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277829AbRJLTld>; Fri, 12 Oct 2001 15:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277832AbRJLTlQ>; Fri, 12 Oct 2001 15:41:16 -0400
Received: from mailrelay2.inwind.it ([212.141.54.102]:55547 "EHLO
	mailrelay2.inwind.it") by vger.kernel.org with ESMTP
	id <S277829AbRJLTlE>; Fri, 12 Oct 2001 15:41:04 -0400
Message-ID: <000d01c15356$6c2bfec0$0100a8c0@leopoldo>
From: "Fabio" <fabio.adamo@inwind.it>
To: <linux-kernel@vger.kernel.org>
Subject: BUG - Kernel 2.4.12 doesn't compile
Date: Fri, 12 Oct 2001 21:44:26 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I use a RH 7.1 ad trying to compile the kernel v. 2.4.12 i get the error you
can see here:

-----------------------------------------------------
fno-common -pipe -mpreferred-stack-boundary=2 -march=k6 -DMODULE   -c -o
share.o share.c
gcc -D__KERNEL__ -I/usr/local/src/linux-2.4.12/include -Wall -Wstrict-protot
ypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing
-fno-common -pipe -mpreferred-stack-boundary=2 -march=k6 -DMODULE   -c -o
ieee1284.o ieee1284.c
gcc -D__KERNEL__ -I/usr/local/src/linux-2.4.12/include -Wall -Wstrict-protot
ypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing
-fno-common -pipe -mpreferred-stack-boundary=2 -march=k6 -DMODULE   -c -o
ieee1284_ops.o ieee1284_ops.c
ieee1284_ops.c: In function `ecp_forward_to_reverse':
ieee1284_ops.c:365: `IEEE1284_PH_DIR_UNKNOWN' undeclared (first use in this
function)
ieee1284_ops.c:365: (Each undeclared identifier is reported only once
ieee1284_ops.c:365: for each function it appears in.)
ieee1284_ops.c: In function `ecp_reverse_to_forward':
ieee1284_ops.c:397: `IEEE1284_PH_DIR_UNKNOWN' undeclared (first use in this
function)
make[2]: *** [ieee1284_ops.o] Error 1
make[2]: Leaving directory `/usr/local/src/linux-2.4.12/drivers/parport'
make[1]: *** [_modsubdir_parport] Error 2
make[1]: Leaving directory `/usr/local/src/linux-2.4.12/drivers'
make: *** [_mod_drivers] Error 2
----------------------------------------------------

Thank you & goodbye.

Fabio Adamo


