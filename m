Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274736AbRIUBvN>; Thu, 20 Sep 2001 21:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274739AbRIUBvE>; Thu, 20 Sep 2001 21:51:04 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:25606 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S274736AbRIUBuv>; Thu, 20 Sep 2001 21:50:51 -0400
Date: Thu, 20 Sep 2001 22:51:08 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Roger Larsson <roger.larsson@norran.net>,
        Oliver Xymoron <oxymoron@waste.org>,
        Dieter =?iso-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Stefan Westerfeld <stefan@space.twc.de>, Robert Love <rml@tech9.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: [PATCH] Preemption Latency Measurement Tool
In-Reply-To: <20010921032230.Q729@athlon.random>
Message-ID: <Pine.LNX.4.33L.0109202249370.1360-100000@duckman.distro.conectiva>
X-supervisor: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Sep 2001, Andrea Arcangeli wrote:
> On Fri, Sep 21, 2001 at 02:03:37AM +0100, Alan Cox wrote:
> > they dont get stuck doing a huge amount of pageout work for someone else.
> > Thats one thing I seem to be seeing with the 10pre11 VM.
>
> actually one feature of the 10pre11 VM is that it will avoid a
> task to give to other people the pages that it is freeing for
> itself. The previous VM didn't has such a feature. So (in theory
> :) it should be the other way around. see the implementation of
> page_alloc.c::balance_classzone().

The key word here seems to be "in theory"  ;)

Without testing the thing to death there's no way what
it really does. Yes, this can make development go at a
slower speed, but at least you'll end up with some idea
of what's going on...

regards,

Rik
--
IA64: a worthy successor to the i860.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

