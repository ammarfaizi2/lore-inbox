Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132475AbQKDGjv>; Sat, 4 Nov 2000 01:39:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132484AbQKDGjl>; Sat, 4 Nov 2000 01:39:41 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:16904 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132475AbQKDGjd>; Sat, 4 Nov 2000 01:39:33 -0500
Date: Fri, 3 Nov 2000 22:39:15 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Thomas Sailer <sailer@ife.ee.ethz.ch>, linux-kernel@vger.kernel.org
Subject: Re: Poll and OSS API
In-Reply-To: <3A03AA33.3D0A61A@mandrakesoft.com>
Message-ID: <Pine.LNX.4.10.10011032237270.25382-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 4 Nov 2000, Jeff Garzik wrote:
> > So fix the stupid API.
> > 
> > The above is just idiocy.
> 
> We're pretty much stuck with the API, until we look at merging ALSA in
> 2.5.x.  Broken API or not, OSS is a mature API, and there are
> spec-correct apps that depend on this behavior.

Considering that about 100% of the sound drivers do not follow that
particular API damage anyway (they can't, as has been pointed out: the
driver doesn't even receive enough information to be _able_ to follow the 
documented API), I doubt that there are all that many programs that depend
on it.

Yes, some drivers apparently _try_ to follow the spec to some degree, but
we should just change the documentation asap.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
