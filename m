Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269868AbRHZUBt>; Sun, 26 Aug 2001 16:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271514AbRHZUBk>; Sun, 26 Aug 2001 16:01:40 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:4873 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S269868AbRHZUBT>; Sun, 26 Aug 2001 16:01:19 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Rik van Riel <riel@conectiva.com.br>
Subject: Re: [resent PATCH] Re: very slow parallel read performance
Date: Sun, 26 Aug 2001 22:08:07 +0200
X-Mailer: KMail [version 1.3.1]
Cc: <pcg@goof.com>, Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L.0108261651080.5646-100000@imladris.rielhome.conectiva>
In-Reply-To: <Pine.LNX.4.33L.0108261651080.5646-100000@imladris.rielhome.conectiva>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010826200133Z16190-32385+242@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 26, 2001 09:52 pm, Rik van Riel wrote:
> On Sun, 26 Aug 2001, Daniel Phillips wrote:
> > On August 26, 2001 08:39 pm, Rik van Riel wrote:
> > > On Sun, 26 Aug 2001, Daniel Phillips wrote:
> > >
> > > > There's an obvious explanation for the high loadavg people are seeing
> > > > when their systems go into thrash mode: when free is exhausted, every
> > > > task that fails to get a block in __alloc_pages will become
> > > > PF_MEMALLOC and start scanning.
> > >
> > > If you ever tested this, you'd know this is not true.
> >
> > Look at this, supplied by Nicolas Pitre in the thread "What version of
> > the kernel fixes these VM issues?":
> 
> His kernel is running completely out of memory, with no
> swap space configured.

No, he's streaming mp3's:

> > > > My test consist in compiling gcc 3.0 while some MP3s are continously playing
> > > > in the background.  The gcc build goes pretty far along until both the mp3
> > > > player and the gcc build completely jam.

--
Daniel
