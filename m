Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318211AbSIOTcI>; Sun, 15 Sep 2002 15:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318215AbSIOTcI>; Sun, 15 Sep 2002 15:32:08 -0400
Received: from dsl-213-023-020-240.arcor-ip.net ([213.23.20.240]:26496 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318211AbSIOTcG>;
	Sun, 15 Sep 2002 15:32:06 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB changes for 2.5.34
Date: Sun, 15 Sep 2002 21:35:39 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, David Brownell <david-b@pacbell.net>,
       Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       Greg KH <greg@kroah.com>, <linux-usb-devel@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0209151220360.1393-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0209151220360.1393-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17qfBE-00008c-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 15 September 2002 21:26, Linus Torvalds wrote:
> On Sun, 15 Sep 2002, Daniel Phillips wrote:
> > 
> > I use UML all the time.  It's great, but it doesn't work for SMP debugging.
> 
> That should not be something fundamental, though. It should be perfectly 
> doable with threading. "SMOP".

Jeff and I occasionally kick this around and it always ends with "yeah,
not hard at all, when I have more time on my hands than I know what to
do with maybe I'll do that", or words to that effect.  It's understandable
why Jeff hasn't gotten around to doing it, given the workload he's had
just maintaining UML in both the 2.4 and 2.5 kernel series.  Plus Jeff
does not get paid of any of this.

Now that it's integrated, nice things like that can happen, and maybe
we won't have to impose on Jeff to do 100% of the work on UML in the
future.  (Well, actually I did about 0.00001% of the work on UML, to
wit, a patch to change the bogus virtual contents of ptes to "physical"
addresses, bringing UML in line with the other arches in that regard.
<- part of my new policy of making sure everybody knows about every
little contribution I make.)

> Yeah, and gdb (not to mention all the grapical nice stuff) sucks in a
> threaded environment. At least it used to. 

It still does.  That's yet another source of irritation.

-- 
Daniel
