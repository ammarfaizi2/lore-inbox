Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262239AbRETUd7>; Sun, 20 May 2001 16:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262238AbRETUdt>; Sun, 20 May 2001 16:33:49 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:182 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262235AbRETUdi>;
	Sun, 20 May 2001 16:33:38 -0400
Date: Sun, 20 May 2001 16:33:36 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Russell King <rmk@arm.linux.org.uk>,
        Richard Gooch <rgooch@ras.ucalgary.ca>,
        Matthew Wilcox <matthew@wil.cx>, Andrew Clausen <clausen@gnu.org>,
        Ben LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code
In-Reply-To: <E151ZTj-0002pT-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.21.0105201615530.8940-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 20 May 2001, Alan Cox wrote:

> > Linus, as much as I'd like to agree with you, you are hopeless optimist.
> > 90% of drivers contain code written by stupid gits.
                   ^^^^^^^
> 
> I think thats a very arrogant and very mistaken view of the problem. 90%
> of the driver are written by people who are

written by != contain code written by. Stuff initally written by sane
people tends to get all sorts of crap into it. Unfortunately.

The problem being: very few people actually read the code in drivers/*.
And crap accumulates. The messier it is, the faster it gets shitted.

So relying on the people finding crappy ->write() instances and ridiculing
the authors in public is... well, somewhat naive. There's more than enough
crap already and that simply doesn't happen. It _can_ be done, but it will
take more than just having the code sitting there.

