Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275743AbRJ3RTX>; Tue, 30 Oct 2001 12:19:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275752AbRJ3RTN>; Tue, 30 Oct 2001 12:19:13 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:22287 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S275743AbRJ3RTG>; Tue, 30 Oct 2001 12:19:06 -0500
Date: Tue, 30 Oct 2001 09:17:31 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Victor Yodaiken <yodaiken@fsmlabs.com>
cc: Rik van Riel <riel@conectiva.com.br>, Andrea Arcangeli <andrea@suse.de>,
        Benjamin LaHaise <bcrl@redhat.com>,
        "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: please revert bogus patch to vmscan.c
In-Reply-To: <20011030095757.A9956@hq2>
Message-ID: <Pine.LNX.4.33.0110300903320.8603-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 30 Oct 2001, Victor Yodaiken wrote:
>
> You can't turn off hardware hash-chains on anything past 603, sadly enough.

Gods, I hope they have reconsidered that in their 64-bit chips. The 32-bit
hash chains may be ugly, but the architected 32/64-bit MMU stuff is just
so incredibly baroque that it makes any other MMU look positively
beautiful ("Segments? Segments shmegments. Big deal").

I still have the occasional nightmares about the IBM block diagrams
"explaining" the PowerPC MMU in their technical documentation.

There's probably a perfectly valid explanation for them, though (*).

		Linus

(*) Probably along the lines of the designers being so high on LSD that
they thought it was a really cool idea. That would certainly explain it in
a very logical fashion.

