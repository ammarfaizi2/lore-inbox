Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261978AbSLOQLt>; Sun, 15 Dec 2002 11:11:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262038AbSLOQLt>; Sun, 15 Dec 2002 11:11:49 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:15607 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S261978AbSLOQLs>; Sun, 15 Dec 2002 11:11:48 -0500
Date: Sun, 15 Dec 2002 17:19:37 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: =?iso-8859-1?Q?Jos=E9_Luis_Tall=F3n?= <jltallon@adv-solutions.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.20: bug with radeonfb - solved
Message-ID: <20021215161937.GP27658@fs.tum.de>
References: <5.1.1.6.0.20021203004621.00b5a770@mail.adv-solutions.net> <5.1.1.6.0.20021203004621.00b5a770@mail.adv-solutions.net> <5.1.1.6.0.20021215123609.00b979e8@mail.adv-solutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5.1.1.6.0.20021215123609.00b979e8@mail.adv-solutions.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 15, 2002 at 12:55:06PM +0100, José Luis Tallón wrote:

>...
> >Does it work if you revert the patch against drivers/video/radeonfb.c
> >that is in -ac?
> >
> >Does it work in plain 2.4.20 (without the -ac patch)?
> 
> <sweating and blushing>
> Works perfect with 2.4.20 vanilla :-|
>         ( I had previously trusted Alan's patches quite blindly )
> - Chipset and DMA working
> 
> 
> Will test with -ac2 and 21-pre1 and report back, so that we can isolate the 
> bug ( quite a nasty one, I can assure you )

If -ac2 fails, could you try to to revert the -ac change to
drivers/video/radeonfb.c and check whether this cures your problem?

> Thanks again.
> 
>         J.L.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

