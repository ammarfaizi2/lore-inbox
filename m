Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265813AbRFYAIy>; Sun, 24 Jun 2001 20:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265814AbRFYAIn>; Sun, 24 Jun 2001 20:08:43 -0400
Received: from mail2.ameuro.de ([62.208.90.8]:11027 "EHLO mail2.ameuro.de")
	by vger.kernel.org with ESMTP id <S265813AbRFYAIb>;
	Sun, 24 Jun 2001 20:08:31 -0400
Message-ID: <3B36808A.70A74B97@alarsen.net>
Date: Mon, 25 Jun 2001 02:06:12 +0200
From: Anders Larsen <anders@alarsen.net>
Organization: syst.eng. A.Larsen (http://www.alarsen.net/)
MIME-Version: 1.0
To: "Richard B. Johnson" <root@chaos.analogic.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Is it useful to support user level drivers
In-Reply-To: <Pine.LNX.3.95.1010621203455.6995A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:
> 
> On Fri, 22 Jun 2001, Anders Larsen wrote:
> 
> > "Richard B. Johnson" wrote:
> > >
> > > QNX does not have any difference between user-space and kernel space.
> > > It's not paged-virtual. It's just one big sheet of address space
> > > with no memory protection (everything is shared). All procedures
> > > to be executed are known at compile time.
> >
> > That's completely, utterly untrue.
> > QNX does indeed sport paged-virtual memory with memory protection;
> > (although QNX4 does not support swap).
> 
> Then QNX is not the QNX that I have used.

Or you haven't used it recently (= within the past 10 years)

> > User-mode interrupts are standard procedure; the deadlock problems
> > Alan has mentioned do not apply, since any running process is
> > always resident in memory.
> > Shared regions have to be explicitly created; access is *not* open
> > to anybody.
> >
> > Nothing has to be known at "compile time"; QNX is a full-featured
> > OS with dynamic loading.
> >
> 
> The QNX that I have used, advertised as QNX, and been around since
> 32-bit ix86 was available, is EXACTLY as I stated.

Dynamic loading of executables has been in QNX for as long as I know
it (fifteen years).
With the appearance of QNX version 4 some ten years ago came 32-bit
address space, full memory management/protection etc.

> > > Therefore, any piece of code can do anything it wants including
> > > handling hardware directly.
> >
> > Again not true; only privileged processes can enter kernel mode
> > to execute port I/O instructions directly.
> 
> The QNX that I have used, again is EXACTLY as stated.

It must have been an early QNX version 2, then.
QNX 2 did not have any memory protection.

> If you have used a different QNX, then QNX has either changed
> radically, or is a different company/QNX than what I used.
> And, I had a lot of good experiences with it since standard
> I/O was provided, as was boot, but it was an open book otherwise
> in which you were not prevented from doing anything you wanted
> to do, at any instant you wanted to do it.

Of course QNX has changes radically over the decades (it's been
around for some twenty years now); what I frowned at was that
you made your statements as if they would apply to the *current*
state of affairs, which they certainly do not.

cheers
Anders
-- 
"In theory there is no difference between theory and practice.
 In practice there is." - Yogi Berra
