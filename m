Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132316AbRDMW6s>; Fri, 13 Apr 2001 18:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132327AbRDMW6i>; Fri, 13 Apr 2001 18:58:38 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:39951 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S132316AbRDMW6Y>;
	Fri, 13 Apr 2001 18:58:24 -0400
Date: Sat, 14 Apr 2001 00:58:16 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Doug McNaught <doug@wireboard.com>, Dennis Bjorklund <db@zigo.dhs.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Data-corruption bug in VIA chipsets
Message-ID: <20010414005816.B2290@pcep-jamie.cern.ch>
In-Reply-To: <m38zl5exm0.fsf@belphigor.mcnaught.org> <E14o3k7-0002tq-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14o3k7-0002tq-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Apr 13, 2001 at 02:36:05PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> > Is this problem likely to affect 2.2.X?  I have a VIA-based board on
> > order (Tyan Trinity) and I don't plan to run 2.4 on it anytime soon
> > (it's upgrading a stock RH6.2 box).
> > 
> > Am I safe if I stay in PIO mode?
> 
> I have received exactly zero reports of 2.2 problems, and as the 2.2
> maintainer I would have expected more (I delete 2.2 + ide-patch
> reports). My suspicion is the problem requires UDMA to occur, or to
> occur with any probability.

Are you talking about IDE DMA problems on any VIA boards, or the Tyan in
particular?  I've sent several reports of sudden system death on a VIA
motherboard, that were confirmed by a few other people.  It's still
present in 2.2: Mandrake 7's installer froze, twice, until I added
"ide=nodma" (or whatever the option is).  Note, this is _without_ UDMA:
the board is not capable of UDMA.

-- Jamie
