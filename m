Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262620AbSLAVeW>; Sun, 1 Dec 2002 16:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262646AbSLAVeW>; Sun, 1 Dec 2002 16:34:22 -0500
Received: from mailout03.sul.t-online.com ([194.25.134.81]:26838 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S262620AbSLAVeV> convert rfc822-to-8bit; Sun, 1 Dec 2002 16:34:21 -0500
Content-Type: text/plain; charset=US-ASCII
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: WOLK - Working Overloaded Linux Kernel
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.20-rmap15a
Date: Sun, 1 Dec 2002 22:41:04 +0100
User-Agent: KMail/1.4.3
References: <Pine.LNX.4.44L.0212011921420.15981-200000@imladris.surriel.com>
In-Reply-To: <Pine.LNX.4.44L.0212011921420.15981-200000@imladris.surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212012236.17431.m.c.p@wolk-project.de>
Cc: Rik van Riel <riel@conectiva.com.br>, Con Kolivas <conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 01 December 2002 22:25, you wrote:

Hi Rik,

> That was my gut feeling as well, but I guess it's a good thing
> to quantify how much of a difference it makes.  I wonder if we
> could convince Con to test a kernel both with and without this
> patch and look at the difference.
yep, would be a good idea. Con: *wake up ;)*

> > So, here my patch proposal. Ontop of 2.4.20-rmap15a.
> Looks good, now lets test it.  If the patch is as needed as you
> say we should push it to marcelo ;)
yep, Andrew should do it. Anyway, all those patches do _not_ get rid of those 
I/O pauses/stops since 2.4.19-pre6. Andrea did a good approach with his 
lowlatency elevator, even if it drops throughput (needs more testing to 
become equivalent to throughput w/o it) and also Con and me did a Mini 
Lowlatency Elevator + Config option, so you can decide weather you are 
building for serverusage where interactive "desktop performance" is not 
needed ;) or not.

I wish I'll have the time to eleminate the broken code which went into 2.4.19 
that causes those I/O stops.

*Repetition: those stopps do not occur with 2.4.18* ;)

ciao, Marc


