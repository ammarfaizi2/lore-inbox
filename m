Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281418AbRKVS5p>; Thu, 22 Nov 2001 13:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281355AbRKVS5f>; Thu, 22 Nov 2001 13:57:35 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:37898 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S281326AbRKVS5T>; Thu, 22 Nov 2001 13:57:19 -0500
Date: Thu, 22 Nov 2001 10:52:03 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Anuradha Ratnaweera <anuradha@gnu.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.15-pre9
In-Reply-To: <20011122134700.A4966@bee.lk>
Message-ID: <Pine.LNX.4.33.0111221046170.1479-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 22 Nov 2001, Anuradha Ratnaweera wrote:
>
> On Wed, Nov 21, 2001 at 10:44:30PM -0800, Linus Torvalds wrote:
> >
> > I think I'm ready to hand this over to Marcelo.
>
> Aren't you going to include Tim Schmielau's patch to handle uptime larger than
> 497 days?  It is a cool feature we always liked to have.

Quite frankly, right now I'm in "handle only bugs that can crash the
system mode". Anything that takes 497 days to see is fairly low on my
priority list. My highest priority, in fact, is to get 2.4.15 out without
any embarrassment.

Because it's not as if time stops when Marcelo takes over. I've suggested
to him that he wait for a while just to see what the real problem spots
are, but he'll have a full-time job integrating patches.

Note that I'll probably do the same thing: when I release 2.4.15, I'll at
the same time release a 2.5.0 that is identical except for version number
(that makes synchronization easier later on). And I'll probably _not_
start accepting all the big waiting patches immediately, I'd rather wait
for at least a week or two to see that there aren't any other issues.

It's much easier doing some of the IO patches in particular knowing that
the base you start out from is stable.

		Linus

