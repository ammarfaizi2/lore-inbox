Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270004AbRHEUKi>; Sun, 5 Aug 2001 16:10:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269997AbRHEUK2>; Sun, 5 Aug 2001 16:10:28 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:19727 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S270002AbRHEUKO>; Sun, 5 Aug 2001 16:10:14 -0400
Date: Sun, 5 Aug 2001 15:40:39 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Michael Rothwell <rothwell@holly-springs.nc.us>
Cc: Linus Torvalds <torvalds@transmeta.com>, Mike Black <mblack@csihq.com>,
        Ben LaHaise <bcrl@redhat.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <andrewm@uow.edu.au>
Subject: Re: [RFC][DATA] re "ongoing vm suckage"
In-Reply-To: <996985193.982.7.camel@gromit>
Message-ID: <Pine.LNX.4.21.0108051540010.10618-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 5 Aug 2001, Michael Rothwell wrote:

> On 04 Aug 2001 10:08:56 -0700, Linus Torvalds wrote:
> > 
> > On Sat, 4 Aug 2001, Mike Black wrote:
> > >
> > > I'm testing 2.4.8-pre4 -- MUCH better interactivity behavior now.
> > 
> > Good.. However.. [...]  before we get too happy about the interactive thing, let's
> > remember that sometimes interactivity comes at the expense of throughput,
> > and maybe if we fix the throughput we'll be back where we started.
> 
> Could there be both interactive and throughput optimizations, and a way
> to choose one or the other at run-time? Or even just at compile time? 

You can increase the queue size (somewhere in drivers/block/ll_rw_block.c)
to get higher throughtput.


