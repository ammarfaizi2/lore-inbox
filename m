Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280970AbRKYSXd>; Sun, 25 Nov 2001 13:23:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280969AbRKYSXY>; Sun, 25 Nov 2001 13:23:24 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:34058 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S280970AbRKYSXL>; Sun, 25 Nov 2001 13:23:11 -0500
Date: Sun, 25 Nov 2001 10:17:15 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
cc: Dominik Kubla <kubla@sciobyte.de>, <marcelo@conectiva.com.br>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.16-pre1
In-Reply-To: <20011125151543.57a1159c.skraw@ithnet.com>
Message-ID: <Pine.LNX.4.33.0111251007140.9377-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 25 Nov 2001, Stephan von Krawczynski wrote:
>
> The "problem" effectively arises from _fast_ releasing "stable" versions.

Actually, I think that is just the _symptom_ of the basic issue: I do not
like being a maintainer.

Let's face it, we had similar problems in 2.2.x, for all the same reasons:
I'm simply not a good maintainer, because I'm too impatient and get too
bored with it.

The fact that I've held on to 2.4.x for too long, mostly due to the VM
problems, really doesn't help. That just makes me _less_ likely to be
careful. Especially when the last known VM problem was fixed (ie the
Oracle highmem deadlock), I had a very strong urge to just "get the d*mn
thing out to Marcelo".

I'm much happier doing development, and what I'm best at for Linux is at
doing the "hard decisions" - and not necessarily because of technical
reasons, but simply because I _can_ make them without too many people
grumbling. An example of this is to do the VM reorg in the first place,
something that at the time a lot of people disagreed with.

But I'm not a good, careful, maintainer. I never claim to be.

I bet you'll see better, more consistent quality from Marcelo.

		Linus

