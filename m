Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263893AbUDGRyX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 13:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263914AbUDGRyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 13:54:22 -0400
Received: from web40503.mail.yahoo.com ([66.218.78.120]:7470 "HELO
	web40503.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263893AbUDGRyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 13:54:19 -0400
Message-ID: <20040407175418.17681.qmail@web40503.mail.yahoo.com>
Date: Wed, 7 Apr 2004 10:54:18 -0700 (PDT)
From: Sergiy Lozovsky <serge_lozovsky@yahoo.com>
Subject: Re: kernel stack challenge 
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200404070244.i372iKdd003670@eeyore.valparaiso.cl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Horst von Brand <vonbrand@inf.utfsm.cl> wrote:
> Sergiy Lozovsky <serge_lozovsky@yahoo.com> said:
> > --- Timothy Miller <miller@techsource.com> wrote:
> > > Horst von Brand wrote:
> >            I would prefer to spend less time
> writing
> > actual code - this is what these high level
> languages
> > for. If performance would be most important -
> people
> > would do everything in Assembler, but they don't.
> I'd
> > better write a small Assembler subroutine which
> will
> > handle stack problems for me and benefit from
> using
> > the high level language after that.
> 
> And then there is the technology of _inventing_ a
> language tailored to the
> task at hand... even better than your list of
> high-level languages.

I started exactly with that. I found out shortly that
have no idea of functionality needed for such kind of
system. It was clear that requirments for this sytem
can change rapidly. Only general purpose language can
address this problem (if we want to save time of
development and introduction of new security models).

Example. Current security policies are 'static'. It
seems, that it would be nice to have 'dynamic'
policies (with support from security model). Now,
policy describes resources available for subsystem. It
may be useful to limit the sequence of access to
resources - 'behaviour' of subsystem. I'm not sure if
I want to implement that right away, but there is
commercial system which does exactly that already (it
was created later than VXE).

Serge.

__________________________________
Do you Yahoo!?
Yahoo! Small Business $15K Web Design Giveaway 
http://promotions.yahoo.com/design_giveaway/
