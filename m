Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272682AbRIPTbn>; Sun, 16 Sep 2001 15:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272718AbRIPTbd>; Sun, 16 Sep 2001 15:31:33 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:34309 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S272717AbRIPTbZ>; Sun, 16 Sep 2001 15:31:25 -0400
Date: Sun, 16 Sep 2001 12:30:39 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Rik van Riel <riel@conectiva.com.br>,
        Tonu Samuel <tonu@please.do.not.remove.this.spam.ee>,
        <linux-kernel@vger.kernel.org>
Subject: Re: vm rewrite ready [Re: broken VM in 2.4.10-pre9]
In-Reply-To: <20010916211934.C1315@athlon.random>
Message-ID: <Pine.LNX.4.33.0109161229140.8286-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 16 Sep 2001, Andrea Arcangeli wrote:
>
> as said it is quite a major change, it discards most of the the 2.4 vm
> that I don't agree with, it is basically an evolution of the classzone
> patch.

That is the wrong direction to go into.

We'll be completely screwed on NuMA with the classzone patch. I've said so
before, I'll say so again.

The basic approach of the classzone patch is _wrong_, in making global
decisions where no "globality" exists.

I bet that the improvements are from other things, not from classzone
itself. An dI will bet that if we start doing classzones, we'll regret it
a LOT in a few years.

		Linus

