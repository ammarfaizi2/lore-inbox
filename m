Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269610AbRHADJa>; Tue, 31 Jul 2001 23:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269611AbRHADJU>; Tue, 31 Jul 2001 23:09:20 -0400
Received: from ffke-campus-gw.mipt.ru ([194.85.82.65]:56719 "EHLO
	www.2ka.mipt.ru") by vger.kernel.org with ESMTP id <S269610AbRHADJQ>;
	Tue, 31 Jul 2001 23:09:16 -0400
Message-Id: <200108010309.f7139nY03951@www.2ka.mipt.ru>
Date: Wed, 1 Aug 2001 08:08:49 +0400
From: John Polyakov <johnpol@2ka.mipt.ru>
To: linux-kernel@vger.kernel.org
Subject: Fw: Troubless with compiling 2.4.7-ac1 kernel with kdb
Reply-To: johnpol@2ka.mipt.ru
X-Mailer: stuphead ver. 0.5.3 (Wiskas) (GTK+ 1.2.7; Linux 2.4.7-ac1; i686)
Organization: MIPT
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hello.

While i was trying to compile my 2.4.7-ac1 kernel with kdb support, I've get this error and warnings:

---------------------------------------
In file included from /usr/src/linux/include/net/checksum.h:33,
from /usr/src/linux/include/linux/raid/md.h:34,
from init/main.c:24:
/usr/src/linux/include/asm/checksum.h:72:30: warning: multi-line string literals are deprecated
/usr/src/linux/include/asm/checksum.h:72:30: warning: multi-line string literals are deprecated
/usr/src/linux/include/asm/checksum.h:72:30: warning: multi-line string literals are deprecated
/usr/src/linux/include/asm/checksum.h:72:30: warning: multi-line string literals are deprecated

And many, many times.... :(
-------------------------------------
make[2]: *** [kdbmain.o] Error 1
make[2]: Leavind directory `/usr/src/linux/kdb'
make[1]: *** [first_rule] Error 2
make[1]: Leavind directory `/usr/src/linux/kdb'
make: *** [_dir_kdb] Error 2
make: Leavind directory `/usr/src/linux'
-------------------------------------
kdbmain.c:71: conflicting types for `kdb_nextline'
/usr/src/linux/inclumake[2]: *** [kdbmain.o] Error 1
make[2]: Leavind directory `/usr/src/linux/kdb'
make[1]: *** [first_rule] Error 2
make[1]: Leavind directory `/usr/src/linux/kdb'
make: *** [_dir_kdb] Error 2
make: Leavind directory `/usr/src/linux'

de/linux/kdbprivate.h:70: previous declaration of `kdb_nextline'
make[2]: *** [kdbmain.o] Error 1
make[2]: Leavind directory `/usr/src/linux/kdb'
make[1]: *** [first_rule] Error 2
make[1]: Leavind directory `/usr/src/linux/kdb'
make: *** [_dir_kdb] Error 2
make: Leavind directory `/usr/src/linux'

It was asked some minutes ago in 
kdb@oss.sgi.com list, and Keith Owens <kaos@melbourne.sgi.com> advice me to ask this question in linux-kernel mail-list.

I'm doing this.

Thanks in advance.
---
WBR. //s0mbre
