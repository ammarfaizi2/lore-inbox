Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273854AbRIRFcq>; Tue, 18 Sep 2001 01:32:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273856AbRIRFcg>; Tue, 18 Sep 2001 01:32:36 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:38706 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S273854AbRIRFca>; Tue, 18 Sep 2001 01:32:30 -0400
Date: Tue, 18 Sep 2001 07:32:48 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.10-pre11
Message-ID: <20010918073248.G698@athlon.random>
In-Reply-To: <20010918070654.Y698@athlon.random> <Pine.LNX.4.21.0109180050490.7152-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0109180050490.7152-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Tue, Sep 18, 2001 at 12:55:46AM -0300
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2001 at 12:55:46AM -0300, Marcelo Tosatti wrote:
> 
> 
> On Tue, 18 Sep 2001, Andrea Arcangeli wrote:
> 
> > On Tue, Sep 18, 2001 at 12:33:15AM -0300, Marcelo Tosatti wrote:
> > > 
> > > On Tue, 18 Sep 2001, Andrea Arcangeli wrote:
> > > 
> > > > On Mon, Sep 17, 2001 at 11:53:10PM -0300, Marcelo Tosatti wrote:
> > > > > Don't you agree that your code can introduce new stability bugs ?
> > > > 
> > > > not anything that can corrupt randomly your hd.
> > > 
> > > Sure, the old code did not corrupt hd's randomly, did it?
> > > 
> > > Let me redo the question: Don't you think the old stinky and slow code was
> > > reasonably stable ? :) 
> > 
> > As said in the other email, just check 2.4 l-k reports of this week,
> > last week etc.., I've lots of private reports too. While for everybody
> > 2.2.19 is working fine.
> 
> Have you seen any problem report which does not happen with anon intensive
> workloads ? 

of course, all the mysql/postgres db reports I got were non anon
intensive I assume, I assume they had enough ram, they all said 2.2 was
fine.

> As far as I've noted, people usually report performance problems when
> running anon intensive workloads. For those cases, I'm pretty sure the
> swap_out() loop is the fuckup: the swap allocation code is really a _CRAP_
> for the current VM.

I don't think that was the case, 2.2 has the same swap_out loop.

Andrea
