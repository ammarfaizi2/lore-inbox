Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316526AbSE0JZE>; Mon, 27 May 2002 05:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316527AbSE0JZD>; Mon, 27 May 2002 05:25:03 -0400
Received: from Morgoth.esiway.net ([193.194.16.157]:42762 "EHLO
	Morgoth.esiway.net") by vger.kernel.org with ESMTP
	id <S316526AbSE0JZB>; Mon, 27 May 2002 05:25:01 -0400
Date: Mon, 27 May 2002 11:24:55 +0200 (CEST)
From: Marco Colombo <marco@esi.it>
To: Austin Gonyou <austin@digitalroadkill.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.4 VM sucks. Again
In-Reply-To: <1022261405.9617.39.camel@UberGeek>
Message-ID: <Pine.LNX.4.44.0205271119430.5096-100000@Megathlon.ESI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 May 2002, Austin Gonyou wrote:

> On Fri, 2002-05-24 at 11:31, Martin J. Bligh wrote:
> > >> I'm not sure exactly what Roy was doing, but we were taking a machine
> > >> with 16Gb of RAM, and reading files into the page cache - I think we built up
> > >> 8 million buffer_heads according to slabinfo ... on a P4 they're 128 bytes each,
> > >> on a P3 96 bytes.
> > > 
> > > The buffer heads one would make sense. I only test on realistic sized systems. 
> > 
> > Well, it'll still waste valuable memory there too, though you may not totally kill it.
> > 
> > > Once you pass 4Gb there are so many problems its not worth using x86 in the
> > > long run
> > 
> I assume that you mean by "not worth using x86" you're referring to say,
> degraded performance over other platforms? Well...if you talk
> price/performance, using x86 is perfect in those terms since you can buy
> more boxes and have a more fluid architecture, rather than building a
> monolithic system. Monolithic systems aren't always the best. Just look
> at Fermilab!

Uh? There are many alpha-based clusters out there. Why do you think 
!x86 == monolithic?

.TM.
-- 
      ____/  ____/   /
     /      /       /			Marco Colombo
    ___/  ___  /   /		      Technical Manager
   /          /   /			 ESI s.r.l.
 _____/ _____/  _/		       Colombo@ESI.it

