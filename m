Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293091AbSBWEk4>; Fri, 22 Feb 2002 23:40:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293092AbSBWEkh>; Fri, 22 Feb 2002 23:40:37 -0500
Received: from c9mailgw.prontomail.com ([216.163.188.207]:43272 "EHLO
	C9Mailgw03.amadis.com") by vger.kernel.org with ESMTP
	id <S293091AbSBWEk1>; Fri, 22 Feb 2002 23:40:27 -0500
Message-ID: <3C771D29.942A07C2@starband.net>
Date: Fri, 22 Feb 2002 23:40:09 -0500
From: Justin Piszcz <war@starband.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: gcc-2.95.3 vs gcc-3.0.4
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wow, not sure if anyone here has done any benchmarks, but look at these
build times:
Kernel 2.4.17 did compile with 3.0.4, just much much slower than 2.95.3
however.

GCC 2.95.3
Boot sector 512 bytes.
Setup is 2628 bytes.
System is 899 kB
make[1]: Leaving directory `/usr/src/linux-2.4.17/arch/i386/boot'
287.28user 23.99system 5:15.81elapsed 98%CPU (0avgtext+0avgdata
0maxresident)k
0inputs+0outputs (514864major+684661minor)pagefaults 0swaps

GCC 3.0.4
Boot sector 512 bytes.
Setup is 2628 bytes.
System is 962 kB
warning: kernel is too big for standalone boot from floppy
make[1]: Leaving directory `/usr/src/linux-2.4.17/arch/i386/boot'
406.87user 28.38system 7:23.68elapsed 98%CPU (0avgtext+0avgdata
0maxresident)k
0inputs+0outputs (546562major+989237minor)pagefaults 0swaps


