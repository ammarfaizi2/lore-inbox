Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264919AbSKJQOY>; Sun, 10 Nov 2002 11:14:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264925AbSKJQOY>; Sun, 10 Nov 2002 11:14:24 -0500
Received: from [195.223.140.107] ([195.223.140.107]:26757 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S264919AbSKJQOX>;
	Sun, 10 Nov 2002 11:14:23 -0500
Date: Sun, 10 Nov 2002 17:20:59 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Con Kolivas <conman@kolivas.net>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       marcelo@conectiva.com.br
Subject: Re: [BENCHMARK] 2.4.{18,19{-ck9},20rc1{-aa1}} with contest
Message-ID: <20021110162059.GA1278@x30.random>
References: <200211091300.32127.conman@kolivas.net> <20021110024451.GE2544@x30.random> <200211102058.46883.conman@kolivas.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211102058.46883.conman@kolivas.net>
User-Agent: Mutt/1.3.27i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 10, 2002 at 08:58:43PM +1100, Con Kolivas wrote:
> >> to do IO work. Unfortunately it is now busy starving the scheduler in the
> >> mean time, much like the 2.5 kernels did before the deadline scheduler was
> >> put in.
> Ok I fully retract the statement. I should not pass judgement on what part of 
> the kernel has changed the benchmark results, I'll just describe what the 

actually Wil pointed out to me privately you meant I/O scheduler, you
just never mentioned the name "I/O" so I mistaken if for the process
scheduler, sorry (I should have understood from the deadline adjective).
It makes sense what you said once parsed as I/O scheduler of course.

Next week I will check the changes in your tree and I'll try to
reproduce the dbench numbers on my 4-way with very high I/O and disk
bandwith and I'll let you know the numbers I get here. It maybe simply
the different elevator default values and fixes in 2.4.20rc, but I
recall that you still win compared to -r0 somewhere (according to your
numbers). It's pointless from my part to discuss this further now until
I've the whole picture of the changes you did, the whole picture on the
contest source code, and after I can reproduce every single result you
posted here. Hope to be able to comment further ASAP.

Andrea
