Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318255AbSHSKnz>; Mon, 19 Aug 2002 06:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318256AbSHSKnz>; Mon, 19 Aug 2002 06:43:55 -0400
Received: from Morgoth.esiway.net ([193.194.16.157]:15887 "EHLO
	Morgoth.esiway.net") by vger.kernel.org with ESMTP
	id <S318255AbSHSKny>; Mon, 19 Aug 2002 06:43:54 -0400
Date: Mon, 19 Aug 2002 12:47:44 +0200 (CEST)
From: Marco Colombo <marco@esi.it>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] (0/4) Entropy accounting fixes
In-Reply-To: <1029666355.15858.5.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0208191220260.26653-100000@Megathlon.ESI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Aug 2002, Alan Cox wrote:

> On Sun, 2002-08-18 at 05:06, dean gaudet wrote:
> > On 17 Aug 2002, Robert Love wrote:
> > 
> > > [1] this is why I wrote my netdev-random patches.  some machines just
> > >     have to take the entropy from the network card... there is nothing
> > >     else.
> > 
> > many southbridges come with audio these days ... isn't it possible to get
> > randomness off the adc even without anything connected to it?
> 
> Both the AMD and Intel bridges also come with high speed random number
> generators (i810-rng, amd768-rng). ADC randomness itself tends to be
> very suspect.

BTW, I know you wrote the amd768-rng driver, I wonder if you have any
indication of how good these rng are. What is the typical output bits/
random bits ratio in normal applications?

.TM.
-- 
      ____/  ____/   /
     /      /       /			Marco Colombo
    ___/  ___  /   /		      Technical Manager
   /          /   /			 ESI s.r.l.
 _____/ _____/  _/		       Colombo@ESI.it

