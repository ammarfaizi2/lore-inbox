Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286278AbRLJRE1>; Mon, 10 Dec 2001 12:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286311AbRLJRES>; Mon, 10 Dec 2001 12:04:18 -0500
Received: from mpdr0.detroit.mi.ameritech.net ([206.141.239.206]:37336 "EHLO
	mailhost.det.ameritech.net") by vger.kernel.org with ESMTP
	id <S286278AbRLJREE>; Mon, 10 Dec 2001 12:04:04 -0500
Date: Mon, 10 Dec 2001 12:02:11 -0500 (EST)
From: volodya@mindspring.com
Reply-To: volodya@mindspring.com
To: Rik van Riel <riel@conectiva.com.br>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: mm question
In-Reply-To: <Pine.LNX.4.33L.0112101448120.4755-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.20.0112101201290.17803-100000@node2.localnet.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 10 Dec 2001, Rik van Riel wrote:

> On Mon, 10 Dec 2001 volodya@mindspring.com wrote:
> > On Mon, 10 Dec 2001, Rik van Riel wrote:
> > > On Mon, 10 Dec 2001, Alan Cox wrote:
> > >
> > > > > I was hoping for something more elegant, but I am not adverse to writing
> > > > > my own get_free_page_from_range().
> > > >
> > > > Thats not a trivial task.
> > >
> > > Especially because we never quite know the users of a
> > > physical page, so moving data around is somewhat hard.
> >
> > I don't want to move them - I just want to collect all that are free
> > and then try to free some more.
> 
> I could put it on the TODO list for my VM stuff, but it's
> not exactly near the top of the list so it might take quite
> a while more before I get around to this...

Thanks, but I was more hoping for the advice on how I can make it myself.. 
the same way as bt848 driver has its own memory allocation functions.

                                      Vladimir Dergachev

> 
> http://linuxvm.bkbits.net/
> 
> cheers,
> 
> Rik
> -- 
> DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/
> 
> http://www.surriel.com/		http://distro.conectiva.com/
> 

