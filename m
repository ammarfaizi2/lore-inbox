Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289836AbSAPDGq>; Tue, 15 Jan 2002 22:06:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289835AbSAPDGh>; Tue, 15 Jan 2002 22:06:37 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:4876 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289839AbSAPDGV>; Tue, 15 Jan 2002 22:06:21 -0500
Date: Tue, 15 Jan 2002 19:06:05 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>, <dhowells@redhat.com>,
        <linux-kernel@vger.kernel.org>, <akpm@zip.com.au>
Subject: Re: [PATCH] need_resched abstraction
In-Reply-To: <20020116140335.694c2bfa.rusty@rustcorp.com.au>
Message-ID: <Pine.LNX.4.33.0201151904120.1357-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 16 Jan 2002, Rusty Russell wrote:
> On Tue, 15 Jan 2002 04:29:54 -0500
> Jeff Garzik <jgarzik@mandrakesoft.com> wrote:
>
> > Call me picky but I like the name cond_resched()   ;-)
>
> ... And I prefer maybe_schedule().

I made everybody unhappy by changing the names of _both_ "cond_yield()"
and "need_yield()". So there.

My tree calls them "cond_resched()" and "need_resched()" respectively.

Nyaah, nyaah, nyaah.

	Linus "management skill: saying 'Nyaah' really load" Torvalds

