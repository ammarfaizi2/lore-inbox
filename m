Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271870AbRIIECr>; Sun, 9 Sep 2001 00:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271869AbRIIECh>; Sun, 9 Sep 2001 00:02:37 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:1296 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S271871AbRIIEC1>; Sun, 9 Sep 2001 00:02:27 -0400
Date: Sat, 8 Sep 2001 20:58:26 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@math.psu.edu>
Subject: Re: linux-2.4.10-pre5
In-Reply-To: <20010909053015.L11329@athlon.random>
Message-ID: <Pine.LNX.4.33.0109082051040.1161-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 9 Sep 2001, Andrea Arcangeli wrote:
>
> I wish the cache coherency logic would be simpler but just doing
> something unconditionally it's going to break things in one way or
> another as far I can tell.

I'd rather fix that, then.

Otherwise we'll just end up carrying broken baggage around forever. Which
is not the way to do things.

Anyway, at this point this definitely sounds like a 2.5.x patch. Which I
always pretty much assumed it would be anyway.

		Linus

