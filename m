Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264233AbTLaKoB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 05:44:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264241AbTLaKoB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 05:44:01 -0500
Received: from cimice4.lam.cz ([212.71.168.94]:1664 "EHLO beton.cybernet.src")
	by vger.kernel.org with ESMTP id S264233AbTLaKn6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 05:43:58 -0500
Date: Wed, 31 Dec 2003 11:43:57 +0100
From: =?iso-8859-2?Q?Karel_Kulhav=FD?= <clock@twibright.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Compatibility of Nvidia NVNET driver license with GPL
Message-ID: <20031231114357.A318@beton.cybernet.src>
References: <20031231073101.A474@beton.cybernet.src> <3FF26E8A.5070806@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3FF26E8A.5070806@pobox.com>; from jgarzik@pobox.com on Wed, Dec 31, 2003 at 01:36:58AM -0500
X-Orientation: Gay
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 31, 2003 at 01:36:58AM -0500, Jeff Garzik wrote:
> Karel Kulhavý wrote:
> > Hello
> > 
> > I faintly remember reading some article on the Net from Linus Torvalds stating
> > something like if a piece of code is written specifically for Linux kernel, it
> > must be under GPL.
> > 
> > I have got an nVidia NForce2 board and downloaded their Ethernet driver (nvnet)
> > and they say in README: "the network driver provided by NVIDIA is subject to
> > the NVIDIA software license". How is with compatibility of such a behaviour
> > with GPL of the kernel sources?
> 
> 
> Since I am not a lawyer, my engineering suggestion would be to sidestep 
> legal issues by using "forcedeth" driver, to drive your nForce NIC. 
> It's fully GPL'd, and full open source.

Suppose we would like to overcome these perpetual problems with misbehaving
manufacturers by designing a PCI network card from scratch in the soul of
free source hardware.

What are the requirements of the kernel for such a card to be cool instead of
piece of shit? How should such a card behave from PCI point of view, should it
support scatter, gather, how should interrupts be handled, what should be
programmable and what not? How should be busmastering implemented?

I am seriously thinking about designing something like that (tailored specially
for Linux) because of developping Ronja - if I included native Ronja support in
"my" network card, I could remove the superfluous circuits that implement
"bureaucracy" linke autonegotiation, TP link integrity etc. and concentrate on
raw performance. Also multiple ports could be on one card (say 4) which would
make the whole thing more nifty.

I have made to work the whole design chain from schematic design to production
of raw files for PCB manufacturers. Also seen a design of video capture
board for IDE connector so I judge implementing something on a PCI should'n
be a pain in the ass higher than moderate.

Is it possible to obtain some PCI specs without NDA's and such bullshit?
Is here anyone who has taken the PCI specs and rewritten them in their
own words?

Cl<
> 
> 	Jeff
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
