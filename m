Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264910AbRGAA50>; Sat, 30 Jun 2001 20:57:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264911AbRGAA5Q>; Sat, 30 Jun 2001 20:57:16 -0400
Received: from sun2.ruf.uni-freiburg.de ([132.230.1.2]:30672 "EHLO
	sun2.ruf.uni-freiburg.de") by vger.kernel.org with ESMTP
	id <S264910AbRGAA5D>; Sat, 30 Jun 2001 20:57:03 -0400
Date: Sun, 1 Jul 2001 02:57:00 +0200 (MET DST)
From: David Thor Bragason <bragason@uni-freiburg.de>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.5 Kernel panic: Aiee, killing interrupt handler!
Message-ID: <Pine.SOL.4.30.0107010238040.23239-100000@sun2.ruf.uni-freiburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have compiled 2.4.5 four times now, and it just won't boot. I have
compiled and used every previous 2.4 kernel without problems, using the
same configuration. The compiler is gcc 2.95.2, but I also tried gcc 3.0
without success. The system crashes early in the boot process, so I
haven't been able to capture the whole error message. One of the first
things I see scroll by is "Machine Check Exception", then the last three
lines are:

>Code: [20 bytes, variable. Sometimes 20 times "%2x"]
>Kernel panic: Aiee, killing interrupt handler!
>In interrupt handler - not syncing

Now this is an old Compaq LTE 5200 laptop, Pentium 120MHz, 72MB RAM.
cat /proc/pci yields:

PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: OPTi Inc. 82C557 [Viper-M] (rev 0).
  Bus  0, device   1, function  0:
    ISA bridge: OPTi Inc. 82C558 [Viper-M ISA+IDE] (rev 0).
  Bus  0, device   2, function  0:
    VGA compatible controller: Cirrus Logic GD 7543 [Viking] (rev 0).
      Non-prefetchable 32 bit memory at 0xc0000000 [0xc0ffffff].
      Non-prefetchable 32 bit memory at 0xc1000000 [0xc1ffffff].

As I said, I had no problems with 2.4.n, n<5. I tried a 2.4.6pre kernel
(5, I think), and that *didn't work* either. I would greatly appreciate if
anyone had any suggestions regarding this. And if they could cc: it to me,
that would be great. Thanks!

David Bragason,  <bragason at uni-freiburg dot de>

