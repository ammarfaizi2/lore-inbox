Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265880AbRGDQ1e>; Wed, 4 Jul 2001 12:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265905AbRGDQ1Z>; Wed, 4 Jul 2001 12:27:25 -0400
Received: from sun2.ruf.uni-freiburg.de ([132.230.1.2]:44162 "EHLO
	sun2.ruf.uni-freiburg.de") by vger.kernel.org with ESMTP
	id <S265880AbRGDQ1J>; Wed, 4 Jul 2001 12:27:09 -0400
Date: Wed, 4 Jul 2001 18:27:08 +0200 (MET DST)
From: David Thor Bragason <bragason@uni-freiburg.de>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.6: Machine Check Exception:  0x  106BE0  (type 0x   9).
Message-ID: <Pine.SOL.4.30.0107041820070.27099-100000@sun2.ruf.uni-freiburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I wrote to this list the other day about how I didn't get 2.4.5 to boot on
my Compaq LTE 5200 laptop. This is a Pentium 120MHz, 72MB RAM with an
OPTi Viper chipset. The strange thing is, all kernels up to 2.4.4
(inclusive) compile and run flawlessly on this machine. Only when I tried
to upgrade to 2.4.5 did I get what looks like a hardware problem, and the
machine does not boot. There is nothing wrong with the kernel
configuration, and I tried gcc 2.95, 3.0, and, to be absolutely sure,
2.91.66 (the recommended compiler). I then had the same problem with a
2.4.6pre kernel, and, today, with the 2.4.6.

The error message I'm getting now is:

CPU#0:  Machine Check Exception:  0x  106BE0  (type 0x   9).

This line is repeated over and over again (with the spaces).

There are some lines that fly by before that, though, and I went to some
lengths trying to capture them the other day. (They scroll by too fast to
be seen.) First I tried to set CONFIG_LP_CONSOLE and pass the appropriate
line to lilo, but nothing came out of
the printer. Then I tried lkcd (the kernel debugging patch/tool), but it
seems that the machine hangs too early in the boot process for that tool
to work. If the message above doesn't mean anything to anyone, I guess
I'll have to rent a videocamera and tape my laptop trying to boot :)

I stress that 2.4.4 still compiles and runs without a problem. Does this
make any sense for a hardware problem? Was there any new hardware (cpu)
check introduced in 2.4.5? I'd be very grateful for any tips,
and could you please cc: them to me, as I don't subscribe to this
list. Thanks!

David Bragason,  <bragason at uni-freiburg dot de>


