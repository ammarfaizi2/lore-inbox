Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277730AbRJIOn0>; Tue, 9 Oct 2001 10:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277731AbRJIOnR>; Tue, 9 Oct 2001 10:43:17 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:16432 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S277730AbRJIOnD>; Tue, 9 Oct 2001 10:43:03 -0400
Date: Tue, 9 Oct 2001 16:42:54 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: pre6 VM issues
Message-ID: <20011009164254.F15943@athlon.random>
In-Reply-To: <20011009163126.D15943@athlon.random> <Pine.LNX.4.21.0110091112110.5604-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0110091112110.5604-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Tue, Oct 09, 2001 at 11:13:07AM -0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2001 at 11:13:07AM -0200, Marcelo Tosatti wrote:
> 
> 
> On Tue, 9 Oct 2001, Andrea Arcangeli wrote:
> 
> > I guess you're not interested to test my patches since they're not in
> > the mainline direction though.
> 
> Why they are not in the mainline direction ?
> 
> Are they hackish ? 

IMHO the other way around, first of all I'm not using the infinite loop,
and I dropped a few bits ready for doing a few different things in the
next days like selecting the process to kill in function of the
allocation rate and by collecting away exclusive pages in get_swap_page
etc...

I'll release the stuff soon as usual in separate patches easily readable
and mergeable, because as said I cannot find anything wrong anymore in
the allocator with my testing resources. Of course I'd really like if
you could test it on the 16G box, but as said it won't test the approch
to the allocator faliure fixes that is been implemented in mainline
which I understood you're working on at the moment.

Andrea
