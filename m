Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261622AbSJJPbe>; Thu, 10 Oct 2002 11:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261629AbSJJPbe>; Thu, 10 Oct 2002 11:31:34 -0400
Received: from h66-38-216-165.gtconnect.net ([66.38.216.165]:60165 "HELO
	innerfire.net") by vger.kernel.org with SMTP id <S261622AbSJJPbd>;
	Thu, 10 Oct 2002 11:31:33 -0400
Date: Thu, 10 Oct 2002 11:37:18 -0400 (EDT)
From: Gerhard Mack <gmack@innerfire.net>
To: Erik Andersen <andersen@codepoet.org>
cc: Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Mark Mielke <mark@mark.mielke.cc>,
       Giuliano Pochini <pochini@denise.shiny.it>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] O_STREAMING - flag for optimal streaming I/O
In-Reply-To: <20021010032950.GA11683@codepoet.org>
Message-ID: <Pine.LNX.4.44.0210101136400.12614-100000@innerfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Oct 2002, Erik Andersen wrote:

> On Thu Oct 10, 2002 at 12:20:02AM +0100, Jamie Lokier wrote:
> > Mark Mielke wrote:
> > >     2) Pages should not be candidates for dropping if the pages belong
> > >        to the first few pages of a file. (First = 2? 4? 8?) The theory
> > >        being, that somebody could begin reading the file again from the
> > >        beginning.
> >
> > This breaks the benefit of using O_STREAMING to read a lot of small
> > files once, as you might do when grepping the kernel tree for example.
>
> I don't think grep is a very good candidate for O_STREAMING.  I
> usually want the stuff I grep to stay in cache.  O_STREAMING is
> much better suited to applications like ogle, vlc, xine, xmovie,
> xmms etc since there is little reason for the OS to cache things
> like songs and movies you aren't likely to hear/see again any
> time soon.

Personally I would settle for updatedb being converted.

	Gerhard

--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.

