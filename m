Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317314AbSFCI2Z>; Mon, 3 Jun 2002 04:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317313AbSFCI2Y>; Mon, 3 Jun 2002 04:28:24 -0400
Received: from [62.70.58.70] ([62.70.58.70]:16080 "EHLO mail.pronto.tv")
	by vger.kernel.org with ESMTP id <S317311AbSFCI2W>;
	Mon, 3 Jun 2002 04:28:22 -0400
Date: Mon, 3 Jun 2002 10:28:14 +0200 (CEST)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
X-X-Sender: <roy@mail.pronto.tv>
To: Kasper Dupont <kasperd@daimi.au.dk>
cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: RAID-6 support in kernel?
In-Reply-To: <3CFB1C42.A03ACABC@daimi.au.dk>
Message-ID: <Pine.LNX.4.33.0206031025400.30424-100000@mail.pronto.tv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > RAID-6 layout: http://www.acnc.com/04_01_06.html
> 
> If it is supposed to survive two arbitrary disk failures something is
> wrong with that figure. They store 12 logical sectors in 20 physical
> sectors across 4 drives. With two lost disks there are 10 physical
> sectors left from which we want to reconstruct 12 logical sectors.
> That is impossible.

Might be the diagram is wrong. Ok. But I know people like Compaq are 
already doing RAID-6.

> OTOH it is possible to construct a system with optimal capacity and
> ability to survive any chosen number of disk failures. This can be
> done using either a Reed-Soloman code or Lagrange interpolation of
> polynomials over a finite field.
> 
> However I guess those techniques would be inefficient in software.

Yeah? That's what the hardware RAID vendors all say, and I yet haven't 
seen one single test where Linux Software RAID can't beat hardware RAID. 
That is also after some testing I did on a high-end intel server at 
Compaq's lab in Oslo. How can RAID-6 be so much different?

roy

-- 
Roy Sigurd Karlsbakk, Datavaktmester

Computers are like air conditioners.
They stop working when you open Windows.

