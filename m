Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317012AbSHTMrM>; Tue, 20 Aug 2002 08:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317017AbSHTMrM>; Tue, 20 Aug 2002 08:47:12 -0400
Received: from p50839280.dip.t-dialin.net ([80.131.146.128]:40711 "EHLO
	calista.inka.de") by vger.kernel.org with ESMTP id <S317012AbSHTMrL>;
	Tue, 20 Aug 2002 08:47:11 -0400
Date: Tue, 20 Aug 2002 14:51:27 +0200
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] (0/4) Entropy accounting fixes
Message-ID: <20020820125127.GA13017@lina.inka.de>
References: <Pine.LNX.4.44.0208172104420.21581-100000@twinlark.arctic.org> <E17gKXF-0008Ax-00@sites.inka.de> <20020818114858.A13115@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020818114858.A13115@linux-mips.org>
User-Agent: Mutt/1.4i
From: Bernd Eckenfels <ecki@lina.inka.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 18, 2002 at 11:48:58AM +0200, Ralf Baechle wrote:
> On Sun, Aug 18, 2002 at 09:31:41AM +0200, Bernd Eckenfels wrote:
> 
> > dean gaudet <dean-list-linux-kernel@arctic.org> wrote:
> > > many southbridges come with audio these days ... isn't it possible to get
> > > randomness off the adc even without anything connected to it?
> > 
> > they also come with RNGs.
> 
> I know of one soundcard RND that is simply implemented as a small
> mask programmed ROM full of random numbers.  That's good enough for
> audio purposes but doesn't even qualify for /dev/urandom's use ...

I am taking about southbridges with random sources, not about soundchips :)

They can be used to contribute some bits to the entropy pool. I dont think
they are the only source one should trust. But the specs say that they are
no PNRG, and I havent heared about too disasterous results from statistical
tests. So they are better than ethernet drivers, anyway.

Greetings
Bernd
-- 
  (OO)      -- Bernd_Eckenfels@Wendelinusstrasse39.76646Bruchsal.de --
 ( .. )  ecki@{inka.de,linux.de,debian.org} http://home.pages.de/~eckes/
  o--o     *plush*  2048/93600EFD  eckes@irc  +497257930613  BE5-RIPE
(O____O)  When cryptography is outlawed, bayl bhgynjf jvyy unir cevinpl!
