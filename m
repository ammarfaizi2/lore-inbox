Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269892AbRHIQ7k>; Thu, 9 Aug 2001 12:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269994AbRHIQ7a>; Thu, 9 Aug 2001 12:59:30 -0400
Received: from adsl-151-204-73-220.delval.adsl.bellatlantic.net ([151.204.73.220]:6736
	"EHLO linajudo.owsla.net") by vger.kernel.org with ESMTP
	id <S269981AbRHIQ7U>; Thu, 9 Aug 2001 12:59:20 -0400
Date: Thu, 9 Aug 2001 11:14:08 -0400
From: Andrew Ferguson <andrew@owsla.cjb.net>
To: linux-kernel@vger.kernel.org
Subject: Compile Error in 2.4.7-ac10
Message-ID: <20010809111408.A19599@linajudo.princeton.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.1.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Attempting to compile the last several 2.4.7-ac kernels (not sure when it
started, sorry) has led to the following errors:

make[1]: Entering directory `/usr/src/linux/arch/i386/kernel'
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
  -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
  -pipe  -march=i586    -c -o traps.o traps.c
{standard input}: Assembler messages:
{standard input}:451: Error: suffix or operands invalid for `jmp'
{standard input}:537: Error: suffix or operands invalid for `jmp'
{standard input}:621: Error: suffix or operands invalid for `jmp'
{standard input}:705: Error: suffix or operands invalid for `jmp'
{standard input}:795: Error: suffix or operands invalid for `jmp'
{standard input}:870: Error: suffix or operands invalid for `jmp'
{standard input}:952: Error: suffix or operands invalid for `jmp'
{standard input}:1023: Error: suffix or operands invalid for `jmp'
{standard input}:1094: Error: suffix or operands invalid for `jmp'
{standard input}:1165: Error: suffix or operands invalid for `jmp'
{standard input}:1236: Error: suffix or operands invalid for `jmp'
{standard input}:1316: Error: suffix or operands invalid for `jmp'
make[1]: *** [traps.o] Error 1
make[1]: Leaving directory `/usr/src/linux/arch/i386/kernel'
make: *** [_dir_arch/i386/kernel] Error 2

Lines 283-286 in the file arch/i386/kernel/traps.c are the source of this
problem. I can give more information as needed. Thanks.

_________________________________________________
Andrew Ferguson
http://owsla.cjb.net | andrew@owsla.cjb.net
AfterStep WM Project: http://www.afterstep.org
