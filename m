Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316435AbSFEVqB>; Wed, 5 Jun 2002 17:46:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316446AbSFEVqA>; Wed, 5 Jun 2002 17:46:00 -0400
Received: from dsl-213-023-039-098.arcor-ip.net ([213.23.39.98]:26820 "EHLO
	starship") by vger.kernel.org with ESMTP id <S316435AbSFEVp7>;
	Wed, 5 Jun 2002 17:45:59 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Mark Mielke <mark@mark.mielke.cc>
Subject: Re: [ANNOUNCE] Adeos nanokernel for Linux kernel
Date: Wed, 5 Jun 2002 23:45:16 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Oliver Xymoron <oxymoron@waste.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0206051330060.2614-100000@waste.org> <E17Fgdc-0001dt-00@starship> <20020605165120.B25348@mark.mielke.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17Fiai-0001f6-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 05 June 2002 22:51, Mark Mielke wrote:
> On Wed, Jun 05, 2002 at 09:40:07PM +0200, Daniel Phillips wrote:
> > On Wednesday 05 June 2002 21:13, Oliver Xymoron wrote:
> > > Neither have you, at least aside from hand-waving.
> > Err.  Skipless.  Need I say more?
> 
> I'm thinking along the lines of a 2Ghz P4 box performing skipless .mp3
> playing, that is not able to compile the Linux kernel in anything less
> than 24 hours.

So, you're worried that the realtime processing is going to suck
performance?  Don't worry about that.  Really.  Take a look at how
Adeos works and add up the cycles consumed by the whole thing.  It's
insignificant.

Just handling the timer interrupt with an iret consumes more cycles by
far than all the interrupt pipeline overhead.  You're imagining
inefficiency where there is none.

> This is where this reasoning takes us. "It's skipless it must be better!"

It's definitely better to be skipless, now we want to have our cake
and eat it too.  We can.

-- 
Daniel
