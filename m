Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280036AbRJ3RD0>; Tue, 30 Oct 2001 12:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280032AbRJ3RDP>; Tue, 30 Oct 2001 12:03:15 -0500
Received: from hq2.fsmlabs.com ([209.155.42.199]:44550 "HELO hq2.fsmlabs.com")
	by vger.kernel.org with SMTP id <S280001AbRJ3RDF>;
	Tue, 30 Oct 2001 12:03:05 -0500
Date: Tue, 30 Oct 2001 09:57:57 -0700
From: Victor Yodaiken <yodaiken@fsmlabs.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Rik van Riel <riel@conectiva.com.br>, Andrea Arcangeli <andrea@suse.de>,
        Benjamin LaHaise <bcrl@redhat.com>,
        "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: please revert bogus patch to vmscan.c
Message-ID: <20011030095757.A9956@hq2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0110300835140.8603-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.18i
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2001 at 08:38:31AM -0800, Linus Torvalds wrote:
> > It's simply not true on eg PPC.
> 
> Now, it's not true on _all_ PPC's.
> 
> The sane PPC setups actually have a regular soft-filled TLB, and last I
> saw that actually performed _better_ than the stupid architected hash-
> chains. And for the broken OS's (ie AIX) that wants the hash-chains, you
> can always make the soft-fill TLB do the stupid thing..

You can't turn off hardware hash-chains on anything past 603, sadly enough.
So all Macs, many embedded boards, ...




