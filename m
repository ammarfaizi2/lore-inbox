Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261834AbVAERGc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261834AbVAERGc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 12:06:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbVAERGc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 12:06:32 -0500
Received: from kepler.fjfi.cvut.cz ([147.32.6.11]:61332 "EHLO
	kepler.fjfi.cvut.cz") by vger.kernel.org with ESMTP id S261834AbVAERGM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 12:06:12 -0500
Date: Wed, 5 Jan 2005 18:06:09 +0100 (CET)
From: Martin Drab <drab@kepler.fjfi.cvut.cz>
To: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: APIC/LAPIC hanging problems on nForce2 system.
In-Reply-To: <41DC1AD7.7000705@gmx.de>
Message-ID: <Pine.LNX.4.60.0501051757300.25946@kepler.fjfi.cvut.cz>
References: <Pine.LNX.4.60.0501051604200.24191@kepler.fjfi.cvut.cz>
 <41DC1AD7.7000705@gmx.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 5 Jan 2005, Prakash K. Cheemplavam wrote:

> Martin Drab schrieb:
> > Hi,
> > 
> > I'm witnessing a total freeze on my system when the APIC and LAPIC are
> > enabled in kernel 2.6.10-bk7.
> 
> Do you know whether your bios already contains the C1 halt disconnect
> fix? I couldn't find this line in your dmesg:

Aha! That might be the problem. Because there is still the factory BIOS, 
which is F11. I'll try the current F20 when I get home and I'll let you 
know.

> PCI: nForce2 C1 Halt Disconnect fixup

OK, I'll check it out.

> Did it occur with earlier kernels? If yes, this is a regression.

Well as I said, with the native Mandrake kernel 2.6.8.1-12mdk everything 
was OK. First vanilla kernel I tried on this MB was somthing about 
2.6.9-rc2 if I remember correctly and it allready had the problem, and all 
subsequent ones had it as well.

> Try as workaround if
> 
> athcool off

OK, I'll try that.

> makes your system stable. If yes, you need above fix activated.

OK, I'll take a look at it and let you know of the results (hopefully in
few hours).

Thanks,
Martin
