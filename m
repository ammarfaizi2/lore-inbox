Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274137AbRISSoC>; Wed, 19 Sep 2001 14:44:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274136AbRISSnm>; Wed, 19 Sep 2001 14:43:42 -0400
Received: from anime.net ([63.172.78.150]:16652 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S274135AbRISSnk>;
	Wed, 19 Sep 2001 14:43:40 -0400
Date: Wed, 19 Sep 2001 11:43:48 -0700 (PDT)
From: Dan Hollis <goemon@anime.net>
To: Linus Torvalds <torvalds@transmeta.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Re[2]: [PATCH] Athlon bug stomper. Pls apply.
In-Reply-To: <9oafeu$1o0$1@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.30.0109191141560.24917-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Sep 2001, Linus Torvalds wrote:
> It is _probably_ an undocumented performance thing, and clearing that
> bit may slow something down. But it might also change some behaviour,
> and knowing _what_ the behaviour is might be very useful for figuring
> out what it is that triggers the problem.

AFAIK noone has even tested it yet to see what it does to performance! Eg
it might slow down memory access so that athlon-optimized memcopy is now
slower than non-athlon-optimized memcopy. And if it turns out to be the
case, we might as well just use the non-athlon-optimized memcopy instead
of twiddling undocumented northbridge bits...

-Dan

-- 
[-] Omae no subete no kichi wa ore no mono da. [-]

