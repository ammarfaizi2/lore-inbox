Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262662AbSLAVsl>; Sun, 1 Dec 2002 16:48:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262664AbSLAVsl>; Sun, 1 Dec 2002 16:48:41 -0500
Received: from c16688.thoms1.vic.optusnet.com.au ([210.49.244.54]:41923 "EHLO
	mail.kolivas.net") by vger.kernel.org with ESMTP id <S262662AbSLAVsk>;
	Sun, 1 Dec 2002 16:48:40 -0500
Message-ID: <1038779765.3dea857568e16@kolivas.net>
Date: Mon,  2 Dec 2002 08:56:05 +1100
From: Con Kolivas <conman@kolivas.net>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: linux-kernel@vger.kernel.org, Rik van Riel <riel@conectiva.com.br>
Subject: Re: [PATCH] 2.4.20-rmap15a
References: <Pine.LNX.4.44L.0212011921420.15981-200000@imladris.surriel.com> <200212012236.17431.m.c.p@wolk-project.de>
In-Reply-To: <200212012236.17431.m.c.p@wolk-project.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Marc-Christian Petersen <m.c.p@wolk-project.de>:

> On Sunday 01 December 2002 22:25, you wrote:
> 
> Hi Rik,
> 
> > That was my gut feeling as well, but I guess it's a good thing
> > to quantify how much of a difference it makes.  I wonder if we
> > could convince Con to test a kernel both with and without this
> > patch and look at the difference.
> yep, would be a good idea. Con: *wake up ;)*

Sorry sleep and work intervene ;)

I have already tested it in -ck and was planning to put it into 2.4.20-ck1 when
I finished it. I'll test it in vanilla to show how it works. It made a
thunderous difference to io load.

Con

> 
> > > So, here my patch proposal. Ontop of 2.4.20-rmap15a.
> > Looks good, now lets test it.  If the patch is as needed as you
> > say we should push it to marcelo ;)
> yep, Andrew should do it. Anyway, all those patches do _not_ get rid of those
> 
> I/O pauses/stops since 2.4.19-pre6. Andrea did a good approach with his 
> lowlatency elevator, even if it drops throughput (needs more testing to 
> become equivalent to throughput w/o it) and also Con and me did a Mini 
> Lowlatency Elevator + Config option, so you can decide weather you are 
> building for serverusage where interactive "desktop performance" is not 
> needed ;) or not.
> 
> I wish I'll have the time to eleminate the broken code which went into 2.4.19
> 
> that causes those I/O stops.
> 
> *Repetition: those stopps do not occur with 2.4.18* ;)
> 
> ciao, Marc
> 
> 


