Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314502AbSEHQHw>; Wed, 8 May 2002 12:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314503AbSEHQHv>; Wed, 8 May 2002 12:07:51 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:16325 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S314502AbSEHQHv>; Wed, 8 May 2002 12:07:51 -0400
Date: Wed, 8 May 2002 10:07:44 -0600
Message-Id: <200205081607.g48G7in11351@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Patrick Mochel <mochel@osdl.org>,
        Thunder from the hill <thunder@ngforever.de>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 56
In-Reply-To: <20020508091442.A16868@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King writes:
> On Tue, May 07, 2002 at 04:03:50PM -0600, Richard Gooch wrote:
> > But it's not actually broken, now that the locking is fixed.
> 
> Really?  What about the case of the missing BKL for device opens that
> you haven't really commented on?

I did comment to you, privately, saying I was waiting to see what the
consensus was on the issue of whether to move the BKL or not. I'll be
sending a patch later this week to fix it.

> Seems like devfs _still_ has locking problems.

A pretty minor one, given the comment I was responding to: "devfs is
unfixable". I've noticed that even Al has gone quiet on the "devfs
races" issue, now that the new code is in place :-)

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
