Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131348AbRDMOC7>; Fri, 13 Apr 2001 10:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131347AbRDMOCw>; Fri, 13 Apr 2001 10:02:52 -0400
Received: from [216.151.155.121] ([216.151.155.121]:1803 "EHLO
	belphigor.mcnaught.org") by vger.kernel.org with ESMTP
	id <S131348AbRDMOCl>; Fri, 13 Apr 2001 10:02:41 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: db@zigo.dhs.org (Dennis Bjorklund), linux-kernel@vger.kernel.org
Subject: Re: Data-corruption bug in VIA chipsets
In-Reply-To: <E14o3k7-0002tq-00@the-village.bc.nu>
From: Doug McNaught <doug@wireboard.com>
Date: 13 Apr 2001 10:02:30 -0400
In-Reply-To: Alan Cox's message of "Fri, 13 Apr 2001 14:36:05 +0100 (BST)"
Message-ID: <m3y9t4ew3t.fsf@belphigor.mcnaught.org>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) XEmacs/21.1 (20 Minutes to Nikko)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

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

This is good to know.  I'll stay away from UDMA and the ide-patches
until things seem clearer then.

> The real concern (as with all of these things) is going to be what the
> workaround does to performance - as measured in frames/second for most folks ;)

Well, this is a compile server (and will have a lot of RAM) so running 
PIO for a while shouldn't have much impact.

Thanks, Alan.

-Doug
