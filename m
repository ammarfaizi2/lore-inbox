Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317393AbSGDMAb>; Thu, 4 Jul 2002 08:00:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317394AbSGDMAb>; Thu, 4 Jul 2002 08:00:31 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:32525 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317393AbSGDMAa>; Thu, 4 Jul 2002 08:00:30 -0400
Date: Thu, 4 Jul 2002 13:02:43 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Adrian Bunk <bunk@fs.tum.de>,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OKS] Kernel release management
Message-ID: <20020704130243.A11601@flint.arm.linux.org.uk>
References: <Pine.NEB.4.44.0207012045110.24810-100000@mimas.fachschaften.tu-muenchen.de> <Pine.LNX.3.96.1020702110848.27954D-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.3.96.1020702110848.27954D-100000@gatekeeper.tmr.com>; from davidsen@tmr.com on Tue, Jul 02, 2002 at 11:13:01AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2002 at 11:13:01AM -0400, Bill Davidsen wrote:
> Seems the reason this is being suggested is that lots of new stuff got
> shoved into 2.2 and 2.4 in the early stages, and they were NOT stable.

That is where davej, the "help Linus say NO!" guy comes into play.

I'm maintaining the 2.5 and 2.4 ARM trees here in parallel, and it is
*really* tough to handle.  There are several problems:

1. finding the time to build and test each kernel version on hardware
   reasonably well.

2. keeping track of what has been applied to which kernels

3. getting down-stream developers to produce patches for the stable and
   development kernels generally doesn't happen.

The net effect is I have more support for various ARM machines in 2.4 at
present than in 2.5, but 2.5 only contains my new features.

If 2.6 and 2.7 appear at the same time, you _will_ run into the same
problems across the community.  Unless people are willing to put lots
of work in to making patches apply to two widely different kernel
source trees, you could end up in the same situation.  And it's no
fun to be there.

> The maintainer can alway push really new stuff into 2.7, and Linus can
> always refuse to take a feature into 2.7 until something else is fixed in
> 2.6.

And you expect Linus to track every single feature and fix that exists in
2.6 and 2.7?

If 2.6 and 2.7 come out at the same time, I'll have to ignore one or either
of the source trees completely.  As an architecture maintainer, that would
be *bad*.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

