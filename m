Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271017AbRH1OST>; Tue, 28 Aug 2001 10:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271068AbRH1OSJ>; Tue, 28 Aug 2001 10:18:09 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:31501 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S271017AbRH1ORy>; Tue, 28 Aug 2001 10:17:54 -0400
Date: Tue, 28 Aug 2001 07:15:17 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Alexander Viro <viro@math.psu.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
In-Reply-To: <E15bgl2-0005oW-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0108280713480.8418-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 28 Aug 2001, Alan Cox wrote:
>
> The unfortunate thing is that its min and max as opposed to typed_min and
> typed_max (with min/max set up to error), since its now a nightmare to
> maintain compatibility between two allegedly stable releases of the same
> kernel, as well as with 2.2

Note that 2.2.x does not HAVE a "min/max" function, so that cannot be an
issue.

Yes, some drivers and filesystems did their own private version, but if
they are maintained in both 2.2.x and 2.4.x, then it's obviously very easy
for them to change their private version to match the 2.4.x tree, so I
think this particular argument is rather bogus.

		Linus

