Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269354AbRHZTx3>; Sun, 26 Aug 2001 15:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270712AbRHZTxT>; Sun, 26 Aug 2001 15:53:19 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:47632 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S269354AbRHZTxH>;
	Sun, 26 Aug 2001 15:53:07 -0400
Date: Sun, 26 Aug 2001 16:52:11 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: <pcg@goof.com>, Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [resent PATCH] Re: very slow parallel read performance
In-Reply-To: <20010826193933Z16469-32384+567@humbolt.nl.linux.org>
Message-ID: <Pine.LNX.4.33L.0108261651080.5646-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Aug 2001, Daniel Phillips wrote:
> On August 26, 2001 08:39 pm, Rik van Riel wrote:
> > On Sun, 26 Aug 2001, Daniel Phillips wrote:
> >
> > > There's an obvious explanation for the high loadavg people are seeing
> > > when their systems go into thrash mode: when free is exhausted, every
> > > task that fails to get a block in __alloc_pages will become
> > > PF_MEMALLOC and start scanning.
> >
> > If you ever tested this, you'd know this is not true.
>
> Look at this, supplied by Nicolas Pitre in the thread "What version of
> the kernel fixes these VM issues?":

His kernel is running completely out of memory, with no
swap space configured.

This is very different from a system which is thrashing
because of the IO load.

regards,

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

