Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314600AbSEBPeu>; Thu, 2 May 2002 11:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314603AbSEBPet>; Thu, 2 May 2002 11:34:49 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:5180 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S314600AbSEBPes>; Thu, 2 May 2002 11:34:48 -0400
Date: Thu, 2 May 2002 17:35:22 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Message-ID: <20020502173522.F11414@dualathlon.random>
In-Reply-To: <20020502153402.A11414@dualathlon.random> <3968942217.1020327505@[10.10.2.3]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2002 at 08:18:33AM -0700, Martin J. Bligh wrote:
> > alpha is the same as mips I think. sparc would be the same too if
> > there's any discontigmem sparc. Dunno of arm. We're talking about
> > architectures needing discontigmem, 99% percent of users  doesn't need
> > discontigmem in the first place, you never need discontigmem in x86 and
> 
> That's not true. We use discontigmem on the NUMA-Q boxes for NUMA support.
> In some memory models, they're also really discontigous memory machines.

With numa-q there's a 512M hole in each node IIRC. that's fine
configuration, similar to the wildfire btw.

> At the moment I use the contig memory model (so we only use discontig for
> NUMA support) but I may need to change that in the future.

I wasn't thinking at numa-q, but regardless numa-Q fits perfectly into
the current discontigmem-numa model too as far I can see.

Andrea
