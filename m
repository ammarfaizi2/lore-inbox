Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129093AbRBSVeW>; Mon, 19 Feb 2001 16:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129388AbRBSVeM>; Mon, 19 Feb 2001 16:34:12 -0500
Received: from front2.grolier.fr ([194.158.96.52]:2753 "EHLO front2.grolier.fr")
	by vger.kernel.org with ESMTP id <S129108AbRBSVd7> convert rfc822-to-8bit;
	Mon, 19 Feb 2001 16:33:59 -0500
Date: Mon, 19 Feb 2001 20:32:29 +0100 (CET)
From: Gérard Roudier <groudier@club-internet.fr>
To: Peter Samuelson <peter@cadcamlab.org>
cc: "Justin T. Gibbs" <gibbs@scsiguy.com>, linux-kernel@vger.kernel.org
Subject: Re: aic7xxx (and sym53c8xx) plans 
In-Reply-To: <14993.33186.622147.313411@wire.cadcamlab.org>
Message-ID: <Pine.LNX.4.10.10102192004380.469-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 19 Feb 2001, Peter Samuelson wrote:

> [Justin Gibbs]
> > I've verified the driver's functionality on 25 different cards thus
> > far covering the full range of chips from aic7770->aic7899.
> 
> That's very good to hear.  I know the temptation of only testing on new
> hardware; that's why I was concerned.
> 
> > Lots of people here at Adaptec look at me funny when I pull a PC from
> > the scrap-heap, or pull an old, discontinued card from an unused
> > marketing display for use in my lab
> 
> Heh. (:
> 
> BTW, is there really enough common ground between the whole series of
> AIC chips to justify a single huge driver?  I know they ship three
> separate NT drivers to cover this range..

LSILOGIC also ship 3 drivers to cover the 53C810 - 53C1010 range on NT.
And, btw, these chips are all PCI.

Doing so, 12 different drivers would be needed to cover 4 different O/Ses,
for example. These drivers (I spoke about both LSILOGIC and ADAPTEC
drivers for NT) obviously work for i386, but what about architecture
dependencies at source level?

May-be this is the reason some UNIX vendors seem to love UDI. :)

If you also use SYMBIOS chips, you may give a try with SYM-2. For the
moment, it replaces only 6 drivers :) as also seems to do, for the moment,
Justin's AIC7XXX-6, by the way.

The plans seem clear to me. :-)
Btw, I _do_ like a lot better the 'one driver' plan over the '12 or more'
one.

  Gérard.

