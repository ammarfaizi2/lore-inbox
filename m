Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286396AbRLJVdA>; Mon, 10 Dec 2001 16:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286394AbRLJVcx>; Mon, 10 Dec 2001 16:32:53 -0500
Received: from mpdr0.detroit.mi.ameritech.net ([206.141.239.206]:45770 "EHLO
	mailhost.det.ameritech.net") by vger.kernel.org with ESMTP
	id <S284710AbRLJVcX>; Mon, 10 Dec 2001 16:32:23 -0500
Date: Mon, 10 Dec 2001 16:30:31 -0500 (EST)
From: volodya@mindspring.com
Reply-To: volodya@mindspring.com
To: Rik van Riel <riel@conectiva.com.br>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: mm question
In-Reply-To: <Pine.LNX.4.33L.0112101617300.4755-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.20.0112101627330.18429-100000@node2.localnet.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 10 Dec 2001, Rik van Riel wrote:

> On Mon, 10 Dec 2001 volodya@mindspring.com wrote:
> > On Mon, 10 Dec 2001, Rik van Riel wrote:
> 
> > > Even if you have a handle on a physical page, you don't know
> > > what processes are using the page, nor if there are additional
> > > users besides the processes.
> >
> > Well, what does kernel do when it runs out of memory ? For example
> > when I mmap a large file and start reading it back and force ?
> 
> For the full horror, see mm/vmscan.c, do_try_to_free_memory()

Wonderful !This is the kind of advice I was looking for :))

So if I copy it over to, say, do_try_to_free_region_memory1() and start
hacking - will this violate some grand scheme of kernel development ?
I.e. is there anything inherently wrong with two different kswapd going on ?

                   thanks !

                          Vladimir Dergachev

> 
> cheers,
> 
> Rik
> -- 
> DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/
> 
> http://www.surriel.com/		http://distro.conectiva.com/
> 

