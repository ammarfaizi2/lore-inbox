Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261301AbRESU2N>; Sat, 19 May 2001 16:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261291AbRESU2D>; Sat, 19 May 2001 16:28:03 -0400
Received: from thimm.dialup.fu-berlin.de ([160.45.217.207]:35590 "EHLO
	pua.physik.fu-berlin.de") by vger.kernel.org with ESMTP
	id <S261288AbRESU15>; Sat, 19 May 2001 16:27:57 -0400
Date: Sat, 19 May 2001 22:27:37 +0200
From: Axel Thimm <Axel.Thimm@physik.fu-berlin.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Au-Ja <doelf@au-ja.de>, Yiping Chen <YipingChen@via.com.tw>,
        support@msi.com.tw, info@msi-computer.de, support@via-cyrix.de,
        John R Lenton <john@grulic.org.ar>
Subject: VIA politics (was: VIA's Southbridge bug: Latest (pseudo-)patch)
Message-ID: <20010519222737.A5510@pua.nirvana>
In-Reply-To: <20010519110721.A1415@pua.nirvana> <E1519KE-0008Vg-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E1519KE-0008Vg-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sat, May 19, 2001 at 05:11:30PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 19, 2001 at 05:11:30PM +0100, Alan Cox wrote:
> > This are the latest suggestions for handling the VIA Southbridge bug as
> > derived from the hardware site www.au-ja.de (Many thanks to doelf).
> 
> I'd rather people left this except for the obvious fixed that were done for
> non VIA northbridge combinations until 2.5. 2.4 is not an appropriate place
> to play with possibly disk corrupting PCI hacks without documentation.
> 
> What is pathetic is that VIA have yet to place anything in the public domain
> giving correct workarounds. People are picking at BIOSes praying to spot all
> the changes (which may not be in the PCI registers even) because a vendor
> hasn't got the decency to admit they screwed up and then to issue proper
> fixes

these are my feelings, too. But I try to be an optimist - this is the reason
for the extended Cc: list, maybe it might trigger some change of those
politics. Note that Yiping Chen <YipingChen@via.com.tw> had contacted this
list a few weeks ago to ask how to contribute drivers to Linux, indicating
perhaps a first step towards VIA going public domain.

Placing more documentation in the public domain would also help Linux
construct the right pirq routing tables, which is also a showstopper for
certain KT133A setups.

> If it had been a manufacturer in most respectable areas of business they'd
> be recalling and reissuing components, and paying for the end resllers to
> notify each customer

Let's hope VIA will indeed change politics. Either the bug is not fixable and
VIA should recall, or the bug/fix should be cleanly documented. Currently VIA
is hoping to survive this fiasco by not drawing too much attention ("it was
the SB"), but this may become a boomerang (I for my part will try to have the
motherboard replaced after having been haunted for the last 6 weeks).

At the very end there are us, the user, who would not want to wait for 2.5
(speak 2.6 for the common user ...). Of course Linux is not to blame, but it
is indeed a big user community hit by this.

Regards, Axel.
-- 
Axel.Thimm@physik.fu-berlin.de
