Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317013AbSFFQ5U>; Thu, 6 Jun 2002 12:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317014AbSFFQ5T>; Thu, 6 Jun 2002 12:57:19 -0400
Received: from dsl-213-023-038-060.arcor-ip.net ([213.23.38.60]:38092 "EHLO
	starship") by vger.kernel.org with ESMTP id <S317013AbSFFQ5R>;
	Thu, 6 Jun 2002 12:57:17 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Daniel Phillips <phillips@bonn-fries.net>
To: Peter =?iso-8859-1?q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Subject: Re: [ANNOUNCE] Adeos nanokernel for Linux kernel
Date: Thu, 6 Jun 2002 18:53:34 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Oliver Xymoron <oxymoron@waste.org>, Mark Mielke <mark@mark.mielke.cc>,
        linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0206051612170.2614-100000@waste.org> <E17Fuy2-0002Fa-00@starship> <3CFF6BAE.8080406@loewe-komp.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <E17G0Vy-0002Hx-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 06 June 2002 16:03, Peter Wächtler wrote:
> Daniel Phillips wrote:
> > On Thursday 06 June 2002 10:52, Peter Wächtler wrote:
> > > LynxOS (now LynuxWorks) has some patents for priority based IO.
> > 
> > Oh, more of those one-click realtime patents ;-)  Do you have any
> > pointers?
> 
> http://www.lynuxworks.com/products/whitepapers/patentedio.php3
> 
> In the upper right corner you can see the patent number. Try
> a search for patent on this side.

This doesn't have anything to do with realtime prioritization of a block
driver.  Anyway, I didn't go as far as looking at the claims, but from
the description on the web page it looks pretty feeble.  It seems to be
concerned with management of priority of softirq handlers to avoid
priority inversion, with a rather slipshod definition of priority
inversion given on the page.  I doubt RTAI has a lot to fear from this
patent, especially as the owner has hitched its cart to the Linux horse,
and likely realizes what a bad idea it is to apply cattle prods to said
horse.

-- 
Daniel
