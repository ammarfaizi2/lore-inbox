Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267199AbRGYWud>; Wed, 25 Jul 2001 18:50:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267220AbRGYWuX>; Wed, 25 Jul 2001 18:50:23 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:31090 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S267199AbRGYWuR>; Wed, 25 Jul 2001 18:50:17 -0400
Date: Thu, 26 Jul 2001 00:49:57 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Richard Gooch <rgooch@ras.ucalgary.ca>,
        Chris Friesen <cfriesen@nortelnetworks.com>,
        Jeff Dike <jdike@karaya.com>,
        user-mode-linux-user <user-mode-linux-user@lists.sourceforge.net>,
        linux-kernel <linux-kernel@vger.kernel.org>, Jan Hubicka <jh@suse.cz>
Subject: Re: user-mode port 0.44-2.4.7
Message-ID: <20010726004957.F32148@athlon.random>
In-Reply-To: <20010724020413.A29561@athlon.random> <Pine.LNX.4.33.0107240849240.29354-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0107240849240.29354-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Jul 24, 2001 at 09:04:28AM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tue, Jul 24, 2001 at 09:04:28AM -0700, Linus Torvalds wrote:
> 
> On Tue, 24 Jul 2001, Andrea Arcangeli wrote:
> > On Mon, Jul 23, 2001 at 05:47:04PM -0600, Richard Gooch wrote:
> > > I don't think it should be allowed to do that. That's a whipping
> >
> > it is allowed to do that, period. This is not your choice or my choice.
> > You may ask gcc folks not to do that and I think they just do.
> 
> Stop this stupid argument.

I will if Honza assures me that no future version of gcc will cause me to
crash if I don't declare xtime volatile and I play with it while it can
change under me (which seems not the case from his last email).

Of course I know that this is more a theorical thing and that if we
consider that a bug we have also many other bugs of the same kind.

Honza? Do you assure me that? In case you don't, could you suggest
another way besides volatile and spinlocks around the access to the
variable to avoid gcc to get confused?

Andrea
