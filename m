Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313558AbSHRKWe>; Sun, 18 Aug 2002 06:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313563AbSHRKWe>; Sun, 18 Aug 2002 06:22:34 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:7923 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S313558AbSHRKWe>; Sun, 18 Aug 2002 06:22:34 -0400
Subject: Re: [PATCH] (0/4) Entropy accounting fixes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: dean gaudet <dean-list-linux-kernel@arctic.org>
Cc: Robert Love <rml@tech9.net>, Linus Torvalds <torvalds@transmeta.com>,
       Oliver Xymoron <oxymoron@waste.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0208172104420.21581-100000@twinlark.arctic.org>
References: <Pine.LNX.4.44.0208172104420.21581-100000@twinlark.arctic.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 18 Aug 2002 11:25:55 +0100
Message-Id: <1029666355.15858.5.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-08-18 at 05:06, dean gaudet wrote:
> On 17 Aug 2002, Robert Love wrote:
> 
> > [1] this is why I wrote my netdev-random patches.  some machines just
> >     have to take the entropy from the network card... there is nothing
> >     else.
> 
> many southbridges come with audio these days ... isn't it possible to get
> randomness off the adc even without anything connected to it?

Both the AMD and Intel bridges also come with high speed random number
generators (i810-rng, amd768-rng). ADC randomness itself tends to be
very suspect.


