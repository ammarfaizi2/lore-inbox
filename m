Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265523AbTBCXTJ>; Mon, 3 Feb 2003 18:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266939AbTBCXTI>; Mon, 3 Feb 2003 18:19:08 -0500
Received: from chaos.analogic.com ([204.178.40.224]:921 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S265523AbTBCXTI>; Mon, 3 Feb 2003 18:19:08 -0500
Date: Mon, 3 Feb 2003 18:31:56 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: gcc 2.95 vs 3.21 performance
In-Reply-To: <336780000.1044313506@flay>
Message-ID: <Pine.LNX.3.95.1030203182417.7651A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Feb 2003, Martin J. Bligh wrote:

> People keep extolling the virtues of gcc 3.2 to me, which I'm
> reluctant to switch to, since it compiles so much slower. But
> it supposedly generates better code, so I thought I'd compile
> the kernel with both and compare the results. This is gcc 2.95
> and 3.2.1 from debian unstable on a 16-way NUMA-Q. The kernbench
> tests still use 2.95 for the compile-time stuff.
>
[SNIPPED tests...]

Don't let this get out, but egcs-2.91.66 compiled FFT code
works about 50 percent of the speed of whatever M$ uses for
Visual C++ Version 6.0  I was awfully disheartened when I
found that identical code executed twice as fast on M$ than
it does on Linux. I tried to isolate what was causing the
difference. So I replaced 'hypot()' with some 'C' code that
does sqrt(x^2 + y^2) just to see if it was the 'C' library.
It didn't help. When I find out what type (section) of code
is running slower, I'll report. In the meantime, it's fast
enough, but I don't like being beat by M$.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


