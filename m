Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314082AbSEAXYD>; Wed, 1 May 2002 19:24:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314123AbSEAXYC>; Wed, 1 May 2002 19:24:02 -0400
Received: from zok.SGI.COM ([204.94.215.101]:38292 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S314082AbSEAXYB>;
	Wed, 1 May 2002 19:24:01 -0400
Date: Wed, 1 May 2002 16:23:43 -0700
From: Jesse Barnes <jbarnes@sgi.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: discontiguous memory platforms
Message-ID: <20020501232343.GA1214171@sgi.com>
Mail-Followup-To: Andrea Arcangeli <andrea@suse.de>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20020426192711.D18350@flint.arm.linux.org.uk> <E171aOa-0001Q6-00@starship> <20020429153500.B28887@dualathlon.random> <E172K9n-0001Yv-00@starship> <20020501042341.G11414@dualathlon.random> <20020501180547.GA1212440@sgi.com> <20020502011750.M11414@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2002 at 01:17:50AM +0200, Andrea Arcangeli wrote:
> so ia64 is one of those archs with a ram layout with huge holes in the
> middle of the ram of the nodes? I'd be curious to know what's the

Well, our ia64 platform is at least, but I think there are others.

> hardware advantage of designing the ram layout in such a way, compared
> to all other numa archs that I deal with. Also if you know other archs
> with huge holes in the middle of the ram of the nodes I'd be curious to
> know about them too. thanks for the interesting info!

AFAIK, some MIPS platforms (both NUMA and non-NUMA) have memory
layouts like this too.  I've never done hardware design before, so I'm
not sure if there's a good reason for such layouts.  Ralf or Daniel
might be able to shed some more light on that...

Jesse
