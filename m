Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131809AbRCOThn>; Thu, 15 Mar 2001 14:37:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131810AbRCOThd>; Thu, 15 Mar 2001 14:37:33 -0500
Received: from [63.95.87.168] ([63.95.87.168]:9988 "HELO xi.linuxpower.cx")
	by vger.kernel.org with SMTP id <S131809AbRCOThX>;
	Thu, 15 Mar 2001 14:37:23 -0500
Date: Thu, 15 Mar 2001 14:36:11 -0500
From: Gregory Maxwell <greg@linuxpower.cx>
To: J Sloan <jjs@toyota.com>
Cc: Rik van Riel <riel@conectiva.com.br>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: How to optimize routing performance
Message-ID: <20010315143611.E30509@xi.linuxpower.cx>
In-Reply-To: <Pine.LNX.4.33.0103152304570.1320-100000@duckman.distro.conectiva> <3AB1153F.802BEBA9@toyota.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.8i
In-Reply-To: <3AB1153F.802BEBA9@toyota.com>; from jjs@toyota.com on Thu, Mar 15, 2001 at 11:17:19AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2001 at 11:17:19AM -0800, J Sloan wrote:
> Rik van Riel wrote:
> > On Thu, 15 Mar 2001, J Sloan wrote:
> >
> > > There are some scheduler patches that are not part of the
> > > main kernel tree at this point (mostly since they have yet to
> > > be optimized for the common case) which make quite a big
> > > difference under heavy load - you might want to check out:
> > >
> > >     http://lse.sourceforge.net/scheduling/
> >
> > Unrelated.   Fun, but unrelated to networking...
> 
> under high load, where the sheer numbet of interrupts
> per second begins to overwhelm the kernel, might it
[snip]
> Or are you saying that the bottleneck is somewhere
> else completely, or that there wouldn't be a bottleneck
> in this case if certain kernel parameters were correctly
> set?

The scheduler schedules tasks not interrupts. Unless it manages to thrash the
cache, the scheduler can not affect routing performance.

