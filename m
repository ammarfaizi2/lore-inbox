Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269932AbRHIQwS>; Thu, 9 Aug 2001 12:52:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269892AbRHIQwI>; Thu, 9 Aug 2001 12:52:08 -0400
Received: from walnut.prs.k12.nj.us ([192.152.5.216]:31625 "EHLO
	walnut.prs.k12.nj.us") by vger.kernel.org with ESMTP
	id <S269859AbRHIQvz>; Thu, 9 Aug 2001 12:51:55 -0400
Date: Thu, 9 Aug 2001 12:51:02 -0400
From: andrew_ferguson@walnut.prs.k12.nj.us
To: linux-kernel@vger.kernel.org
Subject: Compile Error in 2.4.7-ac10
Message-ID: <20010809125102.E17007@linajudo.princeton.edu>
In-Reply-To: <20010809111408.A19599@linajudo.princeton.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20010809111408.A19599@linajudo.princeton.edu>; from andrew@owsla.cjb.net on Thu, Aug 09, 2001 at 11:14:08 -0400
X-Mailer: Balsa 1.2.pre1
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
Tintin Webring: http://owsla.cjb.net/tintin/ring/
