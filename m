Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262733AbRE3VlT>; Wed, 30 May 2001 17:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262813AbRE3VlJ>; Wed, 30 May 2001 17:41:09 -0400
Received: from coruscant.franken.de ([193.174.159.226]:28177 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id <S262762AbRE3Vk6>; Wed, 30 May 2001 17:40:58 -0400
Date: Wed, 30 May 2001 18:34:16 -0300
From: Harald Welte <laforge@gnumonks.org>
To: Fabbione <fabbione@fabbione.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [OFF-TOPIC] 4 ports ETH cards
Message-ID: <20010530183416.P14293@corellia.laforge.distro.conectiva>
In-Reply-To: <3B135549.19CF8965@fabbione.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <3B135549.19CF8965@fabbione.net>; from fabbione@fabbione.net on Tue, May 29, 2001 at 09:52:41AM +0200
X-Operating-System: Linux corellia.laforge.distro.conectiva 2.4.3
X-Date: Today is Pungenday, the 2nd day of Confusion in the YOLD 3167
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2001 at 09:52:41AM +0200, Fabbione wrote:
> Hi all,
> 	sorry for the offtopic msg.
> 
> Can someone point me to a 4 ports fast/eth card solution for linux?

D-Link DFE-570 has a reasonable pricing and is well supported by the 
tulip driver

> I found some cards based on the DEC 21*4* chips but when
> I asked for more details I got a strange answer from the reseller
> like that this card is able to work only half-duplex and the chip has
> only one mac-address for the 4 eth cards (really strange).

nah. And even if so, you can always change the mac-address using ifconfig.

What the guy most likely wanted to say, is that there is only one EEprom
containing all mac adresses for the four tulip chips, which I have seen
on multiple boards

> Thanks a lot
> Fabbione

-- 
Live long and prosper
- Harald Welte / laforge@gnumonks.org               http://www.gnumonks.org/
============================================================================
GCS/E/IT d- s-: a-- C+++ UL++++$ P+++ L++++$ E--- W- N++ o? K- w--- O- M- 
V-- PS+ PE-- Y+ PGP++ t++ 5-- !X !R tv-- b+++ DI? !D G+ e* h+ r% y+(*)
