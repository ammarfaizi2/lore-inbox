Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273850AbRIRFUP>; Tue, 18 Sep 2001 01:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273853AbRIRFTz>; Tue, 18 Sep 2001 01:19:55 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:6412 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S273850AbRIRFTs>; Tue, 18 Sep 2001 01:19:48 -0400
Date: Tue, 18 Sep 2001 00:55:46 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.10-pre11
In-Reply-To: <20010918070654.Y698@athlon.random>
Message-ID: <Pine.LNX.4.21.0109180050490.7152-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 18 Sep 2001, Andrea Arcangeli wrote:

> On Tue, Sep 18, 2001 at 12:33:15AM -0300, Marcelo Tosatti wrote:
> > 
> > On Tue, 18 Sep 2001, Andrea Arcangeli wrote:
> > 
> > > On Mon, Sep 17, 2001 at 11:53:10PM -0300, Marcelo Tosatti wrote:
> > > > Don't you agree that your code can introduce new stability bugs ?
> > > 
> > > not anything that can corrupt randomly your hd.
> > 
> > Sure, the old code did not corrupt hd's randomly, did it?
> > 
> > Let me redo the question: Don't you think the old stinky and slow code was
> > reasonably stable ? :) 
> 
> As said in the other email, just check 2.4 l-k reports of this week,
> last week etc.., I've lots of private reports too. While for everybody
> 2.2.19 is working fine.

Have you seen any problem report which does not happen with anon intensive
workloads ? 

As far as I've noted, people usually report performance problems when
running anon intensive workloads. For those cases, I'm pretty sure the
swap_out() loop is the fuckup: the swap allocation code is really a _CRAP_
for the current VM.



