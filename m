Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266974AbRG1RpW>; Sat, 28 Jul 2001 13:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267040AbRG1RpM>; Sat, 28 Jul 2001 13:45:12 -0400
Received: from congress194.linuxsymposium.org ([209.151.18.194]:3588 "EHLO
	mobilix.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S266974AbRG1Ro4>; Sat, 28 Jul 2001 13:44:56 -0400
Date: Sat, 28 Jul 2001 13:44:05 -0400
Message-Id: <200107281744.f6SHi5d00829@mobilix.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Matthew Gardiner <kiwiunixman@yahoo.co.nz>,
        "Philip R. Auld" <pauld@egenera.com>,
        kernel <linux-kernel@vger.kernel.org>
Subject: Re: binary modules (was Re: ReiserFS / 2.4.6 / Data Corruption)
In-Reply-To: <3B62E80A.C732C3F5@mandrakesoft.com>
In-Reply-To: <E15QWto-0007r1-00@the-village.bc.nu>
	<3B62E80A.C732C3F5@mandrakesoft.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Jeff Garzik writes:
> Alan Cox wrote:
> > The Linux freevxfs module is read only currently. Veritas apparently will be
> > releasing the genuine article for Linux but binary only with all the mess
> > that entails
> 
> Isn't that a violation of the GPL, to release binary modules?

Linus said it's OK. I know Alan doesn't agree, but that's life :-)
The king penguin has spoken.

I don't see the need to be bloody-minded on this issue. If a vendor
wants to go through the pain of tracking kernel drift and having to
compile modules for many different versions, then let them. Given how
much trouble it is, why bother them with legal threats?

The right answer for vendors who want to ship binary modules is to
ship an Open Source interface layer which shields the vendor from
kernel drift (since users will be able to build the interface layer if
they need to, without waiting for the vendor).
I guess that would also shield them from unhelpful legal threats.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
