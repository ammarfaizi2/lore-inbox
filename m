Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129068AbQJ3XJM>; Mon, 30 Oct 2000 18:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129659AbQJ3XJC>; Mon, 30 Oct 2000 18:09:02 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:8199 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129068AbQJ3XIt>; Mon, 30 Oct 2000 18:08:49 -0500
Date: Mon, 30 Oct 2000 15:08:14 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Keith Owens <kaos@ocs.com.au>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test10-pre7
In-Reply-To: <39FDFE0A.BB9691E6@mandrakesoft.com>
Message-ID: <Pine.LNX.4.10.10010301507130.1085-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 30 Oct 2000, Jeff Garzik wrote:
> > 
> > What would be wrong with just splitting it the other way, ie make OX_OBJS
> > be the expanded (but not ordered) list?
> > 
> > That should take care of it, no?
> 
> As an aside:  remember you mentioned we should try to go 100% OX_OBJS
> anyway, eliminating O_OBJS completely...

The only problem is that those unfortunate people without tons of
CPU-power would get really fed up with the extra "made depend" overhead.

So as a less drastic step we should just make it more of a hint, and less
of a design that impacts the link-order..

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
