Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264476AbUAJAqf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 19:46:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264490AbUAJAqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 19:46:35 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:7636 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264476AbUAJAqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 19:46:33 -0500
Date: Sat, 10 Jan 2004 01:46:25 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Matt Mackall <mpm@selenic.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.1-rc1-tiny2
Message-ID: <20040110004625.GB25089@fs.tum.de>
References: <20040106054859.GA18208@waste.org> <3FFA56D6.6040808@cyberone.com.au> <20040106064607.GB18208@waste.org> <3FFA5ED3.6040000@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FFA5ED3.6040000@cyberone.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 06, 2004 at 06:08:03PM +1100, Nick Piggin wrote:
> 
> Matt Mackall wrote:
> 
> >On Tue, Jan 06, 2004 at 05:33:58PM +1100, Nick Piggin wrote:
> >>Have you considered Adrian Bunk's CPU selection rationalisation work?
> >>
> >
> >Vaguely aware of it.
> >
> 
> Basically, because the types of x86 cpus are only partially ordered,
> and a the CPU selection somehow tries to follow the rule "this CPU or
> higher", there ends up being a bit of stuff included which doesn't
> need to be. Not sure what the savings add up to though...
>...

Some savings are possible as a side effect of my patch (the main goal 
is to make the selection of multiple CPUs more user friendly).

I'll send the patch and 2 proof of concept space saving patches as 
replies to this mail.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

