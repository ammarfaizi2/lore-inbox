Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277316AbRJ3R40>; Tue, 30 Oct 2001 12:56:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277203AbRJ3R4Q>; Tue, 30 Oct 2001 12:56:16 -0500
Received: from hq2.fsmlabs.com ([209.155.42.199]:64006 "HELO hq2.fsmlabs.com")
	by vger.kernel.org with SMTP id <S277119AbRJ3R4K>;
	Tue, 30 Oct 2001 12:56:10 -0500
Date: Tue, 30 Oct 2001 10:51:02 -0700
From: Victor Yodaiken <yodaiken@fsmlabs.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Victor Yodaiken <yodaiken@fsmlabs.com>,
        Rik van Riel <riel@conectiva.com.br>,
        Andrea Arcangeli <andrea@suse.de>, Benjamin LaHaise <bcrl@redhat.com>,
        "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: please revert bogus patch to vmscan.c
Message-ID: <20011030105102.A10928@hq2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0110300903320.8603-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.18i
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2001 at 09:17:31AM -0800, Linus Torvalds wrote:
> I still have the occasional nightmares about the IBM block diagrams
> "explaining" the PowerPC MMU in their technical documentation.
> 
> There's probably a perfectly valid explanation for them, though (*).
> 
> 		Linus
> 
> (*) Probably along the lines of the designers being so high on LSD that
> they thought it was a really cool idea. That would certainly explain it in
> a very logical fashion.

All the studies I saw were back from the days when
cache-speed/expensive-memory-speed was close to 1. In this case, the
effect of randomizing memory fetches is no big deal. The rest
of standard PPC mmu architecture is pretty nice, but, if the Alpha
architects could decide to use the PC cmos clock as their only 
prgrammable timer, and the Itanium guys could decide to put in a single
shift-mask path, why shouldn't the IBM designers get to destroy cache
by wasting a bunch of CPU area logic?



