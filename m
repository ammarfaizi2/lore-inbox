Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132035AbQK2Udt>; Wed, 29 Nov 2000 15:33:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132074AbQK2Udj>; Wed, 29 Nov 2000 15:33:39 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:57078 "EHLO
        brutus.conectiva.com.br") by vger.kernel.org with ESMTP
        id <S132035AbQK2UdX>; Wed, 29 Nov 2000 15:33:23 -0500
Date: Wed, 29 Nov 2000 18:02:15 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Andrea Arcangeli <andrea@suse.de>
cc: Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>, Andries.Brouwer@cwi.nl,
        Tigran Aivazian <tigran@veritas.com>, linux-kernel@vger.kernel.org
Subject: Re: corruption
In-Reply-To: <20001129202728.A811@athlon.random>
Message-ID: <Pine.LNX.4.21.0011291758090.5302-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2000, Andrea Arcangeli wrote:
> On Wed, Nov 29, 2000 at 05:05:20PM -0200, Rik van Riel wrote:
> > To be honest, I have a big problem with micro optimisations
> > that prevent the big optimisations from happening.
> > 
> > Would it be an idea to explicitly comment such dangerous
> > micro optimisations so people implementing the big optimisations
> > later on won't run into nasty surprises?
> 
> Did you read the code we're talking about?

This particular piece of code may be a bad example of
my "complaint", but I guess we can just as easily take
something like shrink_mmap() as our example ...

regards,

Rik
--
Hollywood goes for world dumbination,
	Trailer at 11.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
