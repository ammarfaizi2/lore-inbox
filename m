Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267277AbTAVBjZ>; Tue, 21 Jan 2003 20:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267275AbTAVBjZ>; Tue, 21 Jan 2003 20:39:25 -0500
Received: from [65.37.109.202] ([65.37.109.202]:44442 "EHLO
	wizardsworks.wizardsworks.org") by vger.kernel.org with ESMTP
	id <S267270AbTAVBjU>; Tue, 21 Jan 2003 20:39:20 -0500
Date: Tue, 21 Jan 2003 17:48:28 -0800 (PST)
From: Sir Ace <chandleg@wizardsworks.org>
To: linux-kernel@vger.kernel.org
Subject: kernel.h compile kaboom
Message-ID: <Pine.LNX.4.44.0301211746450.27122-100000@wizardsworks.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I was compiling on parisc, linux:

make[1]: Entering directory `/usr/src/linux-2.4.20/arch/parisc/kernel'
gcc -D__KERNEL__ -I/usr/src/linux-2.4.20/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer
-D__linux__ -pipe -fno-strength-reduce -mno-space-regs
-mfast-indirect-calls -mdisable-fpregs -ffunction-sections -march=1.1
-mschedule=7200   -nostdinc -iwithprefix include -DKBUILD_BASENAME=traps
-c -o traps.o traps.c
traps.c:125: conflicting types for `dump_stack'
/usr/src/linux-2.4.20/include/linux/kernel.h:111: previous declaration of
`dump_stack'
make[1]: *** [traps.o] Error 1
make[1]: Leaving directory `/usr/src/linux-2.4.20/arch/parisc/kernel'
make: *** [_dir_arch/parisc/kernel] Error 2

HPTux:/usr/src/linux# gcc --version
3.0.4

HPTux:/usr/src/linux# make --version
GNU Make version 3.79.1, by Richard Stallman and Roland McGrath.
Built for hppa-unknown-linux-gnu
Copyright (C) 1988, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 2000
	Free Software Foundation, Inc.
This is free software; see the source for copying conditions.
There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE.

Report bugs to <bug-make@gnu.org>.


Please help...
  -- Sir Ace

