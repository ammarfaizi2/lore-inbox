Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261882AbRE3TR2>; Wed, 30 May 2001 15:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261889AbRE3TRH>; Wed, 30 May 2001 15:17:07 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:38916 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S261882AbRE3TRD>;
	Wed, 30 May 2001 15:17:03 -0400
Date: Wed, 30 May 2001 16:16:55 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: Jonathan Morton <chromi@cyberspace.org>,
        Craig Kulesa <ckulesa@as.arizona.edu>, linux-kernel@vger.kernel.org
Subject: Re: Plain 2.4.5 VM
In-Reply-To: <Pine.LNX.4.33.0105301626420.410-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.21.0105301613520.13062-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 May 2001, Mike Galbraith wrote:

> I wouldn't go so far as to say totally broken (mostly because I've
> tried like _hell_ to find a better way, and [despite minor successes]
> I've not been able to come up with something which covers all cases
> that even _I_ [hw tech] can think of well).

The "easy way out" seems to be physical -> virtual
page reverse mappings, these make it trivial to apply
balanced pressure on all pages.

The downside of this measure is that it costs additional
overhead and can up to double the amount of memory we
take in with page tables. Of course, this amount is only
prohibitive if the amount of page table memory was also
prohibitively large in the first place, but ... :)

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

