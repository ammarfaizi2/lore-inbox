Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265062AbSKAPoU>; Fri, 1 Nov 2002 10:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265065AbSKAPoU>; Fri, 1 Nov 2002 10:44:20 -0500
Received: from LIGHT-BRIGADE.MIT.EDU ([18.244.1.25]:6418 "HELO
	light-brigade.mit.edu") by vger.kernel.org with SMTP
	id <S265062AbSKAPoR>; Fri, 1 Nov 2002 10:44:17 -0500
Date: Fri, 1 Nov 2002 10:50:45 -0500
From: Gerald Britton <gbritton@alum.mit.edu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: What's left over.
Message-ID: <20021101105045.A31662@light-brigade.mit.edu>
References: <20021031181252.GB24027@tapu.f00f.org> <Pine.LNX.4.44.0210311040080.1526-100000@penguin.transmeta.com> <20021031194351.GA24676@tapu.f00f.org> <apu6cd$4db$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <apu6cd$4db$1@penguin.transmeta.com>; from torvalds@transmeta.com on Fri, Nov 01, 2002 at 03:25:01PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2002 at 03:25:01PM +0000, Linus Torvalds wrote:
> The question I have is whether such external hardware is even worth it
> any more for any standard crypto work.  With a regular PCI bus
> fundamentally limiting throughput to something like a maximum of 66MB/s
> (copy-in and copy-out, and that's so theoretical that it's not even
> funny - I'd be surprised if RL throughput copying back and forth over a
> PCI bus is more than 25-30MB/s), I suspect that you can do most crypto
> faster on the CPU directly these days. 

This may be true of a typical workstation or large server, but your router
may not have such a modern CPU in it.  Crypto accelerators are likely a
much bigger win on embedded routers or other small appliances with CPUs such
as the AMD Elan or other 486 to Pentium class processors.

				-- Gerald

