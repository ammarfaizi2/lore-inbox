Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267291AbTBDPle>; Tue, 4 Feb 2003 10:41:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267289AbTBDPle>; Tue, 4 Feb 2003 10:41:34 -0500
Received: from franka.aracnet.com ([216.99.193.44]:16785 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267291AbTBDPld>; Tue, 4 Feb 2003 10:41:33 -0500
Date: Tue, 04 Feb 2003 07:50:59 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Dave Jones <davej@suse.de>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] gcc 2.95 vs 3.21 performance
Message-ID: <172980000.1044373858@[10.10.2.4]>
In-Reply-To: <20030204132048.D16744@suse.de>
References: <336780000.1044313506@flay> <20030204132048.D16744@suse.de>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  > People keep extolling the virtues of gcc 3.2 to me, which I'm
>  > reluctant to switch to, since it compiles so much slower. But
>  > it supposedly generates better code, so I thought I'd compile
>  > the kernel with both and compare the results. This is gcc 2.95
>  > and 3.2.1 from debian unstable on a 16-way NUMA-Q. The kernbench
>  > tests still use 2.95 for the compile-time stuff.
>  > 
>  > The results below leaves me distinctly unconvinced by the supposed 
>  > merits of modern gcc's. Not really better or worse, within experimental
>  > error. But much slower to compile things with.
> 
> What kernel was kernbench compiling ? The reason I'm asking is that
> 2.5s (and more recent 2.4.21pre's) will use -march flags for more
> aggressive optimisation on newer gcc's.
> If you want to compare apples to apples, make sure you choose
> something like i386 in the processor menu, and then it'll always
> use -march=i386 instead of getting fancy with things like -march=pentium4

Kernbench compiles 2.4.17, because I'm old, slow and lazy, and that
was what was around when I started doing this test ;-)

But the point is still the same ... even if it is doing more agressive
optimisation, it's not actually buying us anything (at least for the kernel)

M.

