Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751155AbVJBXhy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbVJBXhy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 19:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbVJBXhy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 19:37:54 -0400
Received: from mail22.sea5.speakeasy.net ([69.17.117.24]:10933 "EHLO
	mail22.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1751141AbVJBXhy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 19:37:54 -0400
Date: Sun, 2 Oct 2005 16:37:52 -0700 (PDT)
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
cc: Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
In-Reply-To: <20051002230545.GI6290@lkcl.net>
Message-ID: <Pine.LNX.4.58.0510021637260.28193@shell2.speakeasy.net>
References: <20051002204703.GG6290@lkcl.net> <Pine.LNX.4.63.0510021704210.27456@cuia.boston.redhat.com>
 <20051002230545.GI6290@lkcl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Oct 2005, Luke Kenneth Casson Leighton wrote:

> On Sun, Oct 02, 2005 at 05:05:42PM -0400, Rik van Riel wrote:
> > On Sun, 2 Oct 2005, Luke Kenneth Casson Leighton wrote:
> >
> > > and, what is the linux kernel?
> > >
> > > it's a daft, monolithic design that is suitable and faster on
> > > single-processor systems, and that design is going to look _really_
> > > outdated, really soon.
> >
> > Linux already has a number of scalable SMP synchronisation
> > mechanisms.
>
>  ... and you are tied in to the decisions made by the linux kernel
>  developers.
>
>  whereas, if you allow something like a message-passing design (such as
>  in the port of the linux kernel to l4), you have the option to try out
>  different underlying structures - _without_ having to totally redesign
>  the infrastructure.
>
>  several people involved with the l4linux project have already done
>  that: as i mentioned in the original post, there are about three or
>  four different and separate l4 microkernels available for download
>  (GPL) and one of them is ported to stacks of different architectures,
>  and one of them is SMP capable and even includes a virtual machine
>  environment.
>
>  and they're only approx 30-40,000 lines each, btw.
>
>
>  also, what about architectures that have features over-and-above SMP?
>
>  in the original design of SMP it was assumed that if you have
>  N processors that you have N-way access to memory.
>
>  what if, therefore, someone comes up with an architecture that is
>  better than or improves greatly upon SMP?

Like NUMA?

>  they will need to make _significant_ inroads into the linux kernel
>  code, whereas if, say, you oh i dunno provide hardware-accelerated
>  parallel support for a nanokernel (such as l4) which just _happens_
>  to be better than SMP then running anything which is l4 compliant gets
>  the benefit.
>
>
>  the reason i mention this is because arguments about saying "SMP is it,
>  SMP is great, SMP is everything, we're improving our SMP design" don't
>  entirely cut it, because SMP has limitations that don't scale properly
>  to say 64 or 128 processors: sooner or later someone's going to come up
>  with something better than SMP and all the efforts focussed on making
>  SMP better in the linux kernel are going to look lame.
>
>  l.
>
>  p.s. yes i do know of a company that has improved on SMP.
>
> -

-Vadim Lobanov
