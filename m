Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313789AbSEASGF>; Wed, 1 May 2002 14:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313790AbSEASGE>; Wed, 1 May 2002 14:06:04 -0400
Received: from rj.SGI.COM ([192.82.208.96]:5836 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S313789AbSEASGC>;
	Wed, 1 May 2002 14:06:02 -0400
Date: Wed, 1 May 2002 11:05:47 -0700
From: Jesse Barnes <jbarnes@sgi.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Message-ID: <20020501180547.GA1212440@sgi.com>
Mail-Followup-To: Andrea Arcangeli <andrea@suse.de>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20020426192711.D18350@flint.arm.linux.org.uk> <E171aOa-0001Q6-00@starship> <20020429153500.B28887@dualathlon.random> <E172K9n-0001Yv-00@starship> <20020501042341.G11414@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 01, 2002 at 04:23:41AM +0200, Andrea Arcangeli wrote:
> What's the advantage? And after you can have more than one mem_map,
> after you added this "vector", then each mem_map will match a
> discontigmem pgdat. Tell me a numa machine where there's an hole in the
> middle of a node. The holes are always intra-node, never within the
> nodes themself. So the nonlinear-numa should fallback to the stright

Just FYI, there _are_ many NUMA machines with memory holes in the
middle of a node.  Check out the discontig patch at
http://sf.net/projects/discontig for more info.

Jesse
