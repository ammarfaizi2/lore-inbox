Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318875AbSHSMwR>; Mon, 19 Aug 2002 08:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318878AbSHSMwR>; Mon, 19 Aug 2002 08:52:17 -0400
Received: from Morgoth.esiway.net ([193.194.16.157]:21010 "EHLO
	Morgoth.esiway.net") by vger.kernel.org with ESMTP
	id <S318875AbSHSMwR>; Mon, 19 Aug 2002 08:52:17 -0400
Date: Mon, 19 Aug 2002 14:56:10 +0200 (CEST)
From: Marco Colombo <marco@esi.it>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Marco Colombo <marco@esi.it>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] (0/4) Entropy accounting fixes
In-Reply-To: <1029760150.19376.14.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0208191436170.26653-100000@Megathlon.ESI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Aug 2002, Alan Cox wrote:

> On Mon, 2002-08-19 at 11:47, Marco Colombo wrote:
> > 
> > BTW, I know you wrote the amd768-rng driver, I wonder if you have any
> > indication of how good these rng are. What is the typical output bits/
> > random bits ratio in normal applications?
> 
> It seems random. People have subjected both the intel and AMD one to
> statistical test sets. I'm not a cryptographer or a statistician so I
> can't answer usefully

Oh, ok. I've asked only because some time ago I wrote a small tool set
to get random bits from /dev/audio and feed them to /dev/random 
(ala audio-entropyd, but it does FIPS 140-2). You can configure how
many bits to account via RNDADDTOENTCNT every N bits you write to
/dev/random (I use 1/80). Since in principle it can take random data
from any source, I'd wondered if someone had an esteem of the parameter
for HRNGs. Thanks anyway.

.TM.
-- 
      ____/  ____/   /
     /      /       /			Marco Colombo
    ___/  ___  /   /		      Technical Manager
   /          /   /			 ESI s.r.l.
 _____/ _____/  _/		       Colombo@ESI.it

