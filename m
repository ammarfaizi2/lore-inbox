Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286137AbRLTFtB>; Thu, 20 Dec 2001 00:49:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286139AbRLTFsv>; Thu, 20 Dec 2001 00:48:51 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:30480 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S286137AbRLTFsk>; Thu, 20 Dec 2001 00:48:40 -0500
Date: Wed, 19 Dec 2001 21:47:18 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "David S. Miller" <davem@redhat.com>
cc: <cs@zip.com.au>, <billh@tierra.ucsd.edu>, <bcrl@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linux-aio@kvack.org>
Subject: Re: aio
In-Reply-To: <20011219.185847.77651573.davem@redhat.com>
Message-ID: <Pine.LNX.4.33.0112192136300.19214-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 19 Dec 2001, David S. Miller wrote:
>
> Not precisely my thrust, which is that AIO is not important to any
> significant population of Linux users, it is "nook and cranny" in
> scope.  And that those "nook and cranny" folks who really find it
> important can get paid implementation+support of AIO.

I disagree - we can probably make the aio by Ben quite important. Done
right, it becomes a very natural way of doing event handling, and it could
very well be rather useful for many things that use select loops right
now.

So I actually like the thing as it stands now. What I don't like is how
it's been handled, with people inside Oracle etc working with it, but
_not_ people on the kernel mailing list. I don't worry about the code
nearly as much as I worry about people starting to clique together.

		Linus

