Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131269AbRDMNfR>; Fri, 13 Apr 2001 09:35:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131300AbRDMNfH>; Fri, 13 Apr 2001 09:35:07 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:11788 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131269AbRDMNfC>; Fri, 13 Apr 2001 09:35:02 -0400
Subject: Re: Data-corruption bug in VIA chipsets
To: doug@wireboard.com (Doug McNaught)
Date: Fri, 13 Apr 2001 14:36:05 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), db@zigo.dhs.org (Dennis Bjorklund),
        linux-kernel@vger.kernel.org
In-Reply-To: <m38zl5exm0.fsf@belphigor.mcnaught.org> from "Doug McNaught" at Apr 13, 2001 09:29:59 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14o3k7-0002tq-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is this problem likely to affect 2.2.X?  I have a VIA-based board on
> order (Tyan Trinity) and I don't plan to run 2.4 on it anytime soon
> (it's upgrading a stock RH6.2 box).
> 
> Am I safe if I stay in PIO mode?

I have received exactly zero reports of 2.2 problems, and as the 2.2 maintainer
I would have expected more (I delete 2.2 + ide-patch reports). My suspicion is
the problem requires UDMA to occur, or to occur with any probability.

The real concern (as with all of these things) is going to be what the
workaround does to performance - as measured in frames/second for most folks ;)


