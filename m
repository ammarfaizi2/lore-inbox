Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274884AbRIVBBg>; Fri, 21 Sep 2001 21:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274885AbRIVBBZ>; Fri, 21 Sep 2001 21:01:25 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:10726 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S274884AbRIVBBM>;
	Fri, 21 Sep 2001 21:01:12 -0400
Date: Fri, 21 Sep 2001 21:01:33 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: swapoff() behaviour
In-Reply-To: <Pine.LNX.4.33.0109211754010.1052-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0109212059500.9760-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 21 Sep 2001, Linus Torvalds wrote:

> 
> On Fri, 21 Sep 2001, Alexander Viro wrote:
> >
> > In other words, during the last 4 years quite a few pieces of mm/swapfile.c
> > had been a dead code.  Looks like we either need to restore old behaviour
> > or perform the amputation.  Snippet above is not the only place of that
> > kind.
> >
> > Linus, it's your call.
> 
> Well, considering that it's been four years, and we haven't had a single
> complaint - and that it was found now only due to code walkthrough - I
> strongly suggest we just kill the code that can't be reached and has no
> meaning.

OK, consider it done.  I'll send patch tonight.

