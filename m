Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131988AbRDWVLl>; Mon, 23 Apr 2001 17:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131990AbRDWVLc>; Mon, 23 Apr 2001 17:11:32 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:39692 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S131988AbRDWVLZ>; Mon, 23 Apr 2001 17:11:25 -0400
Date: Mon, 23 Apr 2001 23:11:14 +0200 (CEST)
From: axel <axel@rayfun.org>
To: linux-kernel@vger.kernel.org
Subject: compile error 2.4.4pre6: inconsistent operand constraints in an
 `asm'
Message-ID: <Pine.LNX.4.21.0104232306020.4230-100000@neon.rayfun.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo,

after having had trouble with compilation due to old gcc version, i have
updated to gcc 3.0 and received the following error:

gcc -D__KERNEL__ -I/usr/src/linux-2.4.4pre6/include -Wall
-Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe
-mpreferred-stack-boundary=2 -march=i586    -DEXPORT_SYMTAB -c sys.c
sys.c: In function `sys_gethostname':
/usr/src/linux-2.4.4pre6/include/asm/rwsem.h:142: inconsistent operand
constraints in an `asm'
make[2]: *** [sys.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.4.4pre6/kernel'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.4pre6/kernel'
make: *** [_dir_kernel] Error 2

I'm very thankful for any help,

Regards,
Axel Siebenwirth

