Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280043AbRJ3RIP>; Tue, 30 Oct 2001 12:08:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280039AbRJ3RIA>; Tue, 30 Oct 2001 12:08:00 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:14093 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S280023AbRJ3RHY>;
	Tue, 30 Oct 2001 12:07:24 -0500
Date: Tue, 30 Oct 2001 15:07:37 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Benjamin LaHaise <bcrl@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: please revert bogus patch to vmscan.c
In-Reply-To: <20011030180023.L1340@athlon.random>
Message-ID: <Pine.LNX.4.33L.0110301506010.2963-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Oct 2001, Andrea Arcangeli wrote:

> again from the cache with a minor fault, IMHO there's no way such tlb
> flush removal can make a difference in a DBMS workload on a sanely
> setup machine, I'm amazed you think it can make a difference.

You seem to be hammering on the DBMS scenario because Ben
chose a bad example, without taking a step back and realising
that his point is valid, though mostly with other examples.

Linus came up with a more efficient way to make sure we
get to see (and clear) the accessed bits, lets use that one
and get on with life.

regards,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/

http://www.surriel.com/		http://distro.conectiva.com/

