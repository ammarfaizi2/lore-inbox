Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262000AbSIYVBm>; Wed, 25 Sep 2002 17:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262001AbSIYVBl>; Wed, 25 Sep 2002 17:01:41 -0400
Received: from web20301.mail.yahoo.com ([216.136.226.82]:27294 "HELO
	web20301.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S262000AbSIYVBi>; Wed, 25 Sep 2002 17:01:38 -0400
Message-ID: <20020925210654.24630.qmail@web20301.mail.yahoo.com>
Date: Wed, 25 Sep 2002 14:06:54 -0700 (PDT)
From: DragonK <dragon_krome@yahoo.com>
Subject: Linux 2.4.x Kernel Bug - Problem found
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Two days ago I've sent you a mail regarding my problem
with the Kernel 2.4(5).x boot hangs.

I'd like to thank the kind people who answered me
back, I really appreciate their efforts.

I have two news: one good, one bad :)
The good one is that I've found the cause of the
kernel lock-up (er...sort of).

Tha bad one is that I can't do anything about it.
I had an ideea and disabled in my BIOS all caches,
floppy controller, ports and other stuff...
Surprise! Kernel 2.4.18 booted (in 10 mins :). No
lock-up!!

Ok...I went back into the BIOS and enabled internal
cache. Boot again...Guess what? :(
Nothing...dead.

So, at least on my system, there is a problem with the
cache. I don't think that the cache memory
itself is bad, since I don't experience random
failures or reboots...

What should I do? If there will be a patch for this,
where would I find it?
Please help!

BIOS Details:
AMI BIOS Release 11/16/97 S
BIOS Mainboard ID:
51-0505-001437-00111111-071595-M1531/43-001_10_TX_PRO-H

I have upgraded/downgraded the BIOS a couple of times
and this doesen't solve the problem.

Thank you.


PS: Here are some details about the CPU and PCIs, for
more info.
processor       : 0
vendor_id       : CyrixInstead
cpu family      : 5
model           : 4
model name      : 6x86L 2x Core/Bus Clock
stepping        : 2
fdiv_bug        : no
hlt_bug         : no
sep_bug         : no
f00f_bug        : no
coma_bug        : yes
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu de cx8 mtrr
bogomips        : 149.50

00:00.0 Host bridge: Acer Laboratories Inc. [ALi]
M1531 [Aladdin IV] (rev b2)
        Subsystem: Acer Laboratories Inc. [ALi]:
Unknown device 1531
        Flags: bus master, slow devsel, latency 32

00:02.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533
PCI to ISA Bridge [Aladdin IV] (rev b4)
        Flags: bus master, medium devsel, latency 0

00:03.0 Communication controller: CONEXANT: Unknown
device 1085 (rev 08)
        Subsystem: CONEXANT: Unknown device 1085
        Flags: bus master, medium devsel, latency 64,
IRQ 11
        Memory at ef7e0000 (32-bit, non-prefetchable)
        I/O ports at eff0
        Capabilities: [40] Power Management version 2
00:06.0 VGA compatible controller: S3 Inc. 86c764/765
[Trio32/64/64V+] (prog-if 00 [VGA])
        Flags: medium devsel
        Memory at ef800000 (32-bit, non-prefetchable)
        Expansion ROM at ef7f0000 [disabled]

00:0b.0 IDE interface: Acer Laboratories Inc. [ALi]
M5229 IDE (rev 20) (prog-if fa)
        Flags: bus master, medium devsel, latency 32
        I/O ports at ffa0

__________________________________________________
Do you Yahoo!?
New DSL Internet Access from SBC & Yahoo!
http://sbc.yahoo.com
