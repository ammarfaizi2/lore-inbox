Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132027AbRDCQf0>; Tue, 3 Apr 2001 12:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132039AbRDCQfQ>; Tue, 3 Apr 2001 12:35:16 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:52190 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S132027AbRDCQfE>;
	Tue, 3 Apr 2001 12:35:04 -0400
Date: Tue, 3 Apr 2001 12:34:18 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        Andries.Brouwer@cwi.nl, torvalds@transmeta.com, hpa@transmeta.com,
        linux-kernel@vger.kernel.org, tytso@MIT.EDU
Subject: Re: Larger dev_t
In-Reply-To: <200104031605.f33G5D604937@mobilix.atnf.CSIRO.AU>
Message-ID: <Pine.GSO.4.21.0104031214270.17127-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 3 Apr 2001, Richard Gooch wrote:

> However, a large number of people run devfs on small to large systems,
> and these "races" aren't causing problems. People tell me it's quite
> stable. I run devfs on my systems, and not once have I had a problem
> due to devfs "races". So I feel it's quite unfair to paint such a dire
> picture (I'm referring to Martin's comments here, not Alan's).

And _that_ approach is the reason why I absolutely refuse to run your code
on any of my boxen.  Sorry.  If devfs (without serious cleanup) will become
mandatory I'll fork the tree - better backporting patches to Linus' one than
depending on current devfs.  You've been sitting on known (and easily fixable)
bugs and asking to leave fixing them to you for what, 10 months already?
Furrfu...  You are maintainer of that code.  You keep insisting on having
everything and a kitchen sink in the devfs and refuse to split the
functionality into reasonable pieces.  Essentially you are saying that it's
all or nothing deal.  Fine with me - out of these options I certainly
prefer the latter.
								Al

