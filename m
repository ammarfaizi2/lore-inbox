Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315721AbSEZEUh>; Sun, 26 May 2002 00:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315720AbSEZEUh>; Sun, 26 May 2002 00:20:37 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:11027 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315718AbSEZEUf>; Sun, 26 May 2002 00:20:35 -0400
Date: Sat, 25 May 2002 21:20:32 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Oliver Xymoron <oxymoron@waste.org>
cc: Robert Schwebel <robert@schwebel.de>, <linux-kernel@vger.kernel.org>
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
In-Reply-To: <Pine.LNX.4.44.0205252159380.2614-100000@waste.org>
Message-ID: <Pine.LNX.4.44.0205252116240.1028-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 25 May 2002, Oliver Xymoron wrote:
>
> I'm sure you know this route is not very useful - there's practically
> nothing that we can push across the hard RT divide anyway. We can't do
> meaningful filesystem I/O, memory allocation, networking, or VM fiddling -
> what's left?

Atomic memory allocation, for one. Potentially very useful.

> Cleaning up soft RT latencies will make the vast majority of people who
> think they want hard RT happy anyway.

I certainly personally agree with you, but the hard-liners don't.
Remember: it took the hard-RT community a long time to accept radical new
things like CPU caches, and some of them _still_ like the ability to lock
down cachelines..

		Linus


