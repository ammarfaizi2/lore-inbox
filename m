Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261476AbTIKTMw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 15:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261484AbTIKTMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 15:12:52 -0400
Received: from mx6.mail.ru ([194.67.23.26]:10771 "EHLO mx6.mail.ru")
	by vger.kernel.org with ESMTP id S261476AbTIKTMm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 15:12:42 -0400
Date: Thu, 11 Sep 2003 20:51:56 +0200 (CEST)
From: Guennadi Liakhovetski <lyakh@mail.ru>
Reply-To: Guennadi Liakhovetski <g.liakhovetski@web.de>
To: Russell King <rmk@arm.linux.org.uk>
cc: Jamie Lokier <jamie@shareable.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Virtual alias cache coherency results (was: x86, ARM, PARISC,
 PPC, MIPS and Sparc folks please run this)
In-Reply-To: <20030910233951.Q30046@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0309112045450.5655-100000@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam: Not detected
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello


On Wed, 10 Sep 2003, Russell King wrote:

> Tests need to be run on a larger proportion of the following:
>
> *	ARM720
> 	ARM920
> 	ARM922
> 	ARM925
> 	ARM926
> 	ARM1020
> 	ARM1022
> 	ARM1026
> *	StrongARM-110	(DEC/Intel)
> 	StrongARM-1100	(DEC/Intel)
> *	StrongARM-1110	(Intel)
> *	Xscale		(Intel)
> 	PXA		(Intel)
>
> And so far, there are only results for 4 of these devices, with some
> revisions of StrongARM-110's passing and others failing.

If I got it right, you are saying, that you only have results for the
CPUs, marked with stars in the above list. Then, I'll _repeat_ what I've
sent to the thread:

<quote>

Date: Mon, 1 Sep 2003 21:09:57 +0200 (CEST)
From: Guennadi Liakhovetski
Reply-To: Guennadi Liakhovetski <g.liakhovetski@web.de>
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, Jamie Lokier <jamie@shareable.org>,
     Paul J.Y. Lahaie <pjlahaie@steamballoon.com>
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this

On

Processor       : Intel XScale-PXA250 rev 3 (v5l)
BogoMIPS        : 397.31
Features        : swp half thumb fastmult edsp
CPU implementor : 0x69
CPU architecture: 5TE
CPU variant     : 0x0
CPU part        : 0x290
CPU revision    : 3
Cache type      : undefined 5
Cache clean     : undefined 5
Cache lockdown  : undefined 5
Cache unified   : Harvard
I size          : 32768
I assoc         : 32
I line length   : 32
I sets          : 32
D size          : 32768
D assoc         : 32
D line length   : 32
D sets          : 32

and

Processor       : StrongARM-1100 rev 9 (v4l)
BogoMIPS        : 127.38
Features        : swp half 26bit fastmult

version 3 of the test consistently reports "Too slow".

</quote>

Both with 2.4.19-rmk7 (pxa with -pxa1) kernels. SA is a Shannon, PXA is a
Triton.

Guennadi
---
Guennadi Liakhovetski



