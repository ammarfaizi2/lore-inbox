Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271708AbRHUOns>; Tue, 21 Aug 2001 10:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271706AbRHUOnc>; Tue, 21 Aug 2001 10:43:32 -0400
Received: from tonib-gw-old.customer.0rbitel.net ([195.24.39.218]:48132 "HELO
	mail.ludost.net") by vger.kernel.org with SMTP id <S271707AbRHUOmw>;
	Tue, 21 Aug 2001 10:42:52 -0400
Date: Tue, 21 Aug 2001 17:43:04 +0300 (EEST)
From: Vasil Kolev <lnxkrnl@mail.ludost.net>
X-X-Sender: <lnxkrnl@doom.bastun.net>
To: <linux-kernel@vger.kernel.org>
Subject: Hardware limitations, etc.
Message-ID: <Pine.LNX.4.33.0108211739100.28883-100000@doom.bastun.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I have some questions, and I don't know where to ask them, so here it
goes... ( i guess here is the right place ... )

I have a machine, for which vmstat report something like
   procs                      memory      swap          io     system
cpu
 r  b  w   swpd   free  inact active   si   so    bi    bo   in    cs us sy id
 3 25  1  48908   5264 402716 262664    0    0  2341   257 42633 28382 44 47  9
 5 14  1  48908   5616 409684 254960    0    0  2393   152 37703 26247 44 50  7

( when i run vmstat, the loadavg grows from 10 to 20 ... ), the machine is
dual Pentium3/coppermine/933, 1G ram. (booted with noapic, without that
parameter it crashes at least twice a day )
My question is - is 40k interrupts/30k context switches the maximum i can
squeeze from the machine? I need to optimize it a bit , but first I want
to locate the bottleneck, any help will be appreciated.

