Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290627AbSBLAPD>; Mon, 11 Feb 2002 19:15:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290620AbSBLAOn>; Mon, 11 Feb 2002 19:14:43 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:35334 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S290625AbSBLAOh>; Mon, 11 Feb 2002 19:14:37 -0500
Subject: Re: A7M266-D works?
To: whitney@math.berkeley.edu
Date: Tue, 12 Feb 2002 00:28:14 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <200202112304.g1BN4vh01697@adsl-209-76-109-63.dsl.snfc21.pacbell.net> from "Wayne Whitney" at Feb 11, 2002 03:04:57 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16aQnu-00006k-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Check PCI register 0x4C if bits 1 and 2 are clear your board is not
> > running in a PCI compliant mode and anything may happen. 
> 
> The PCI quirk fixup you posted (reproduced below) uses the test
> "(pcic&6)!=6", so do you mean to say "if bit 1 or bit 2 is clear"?

If either bit is clear then the board (according the the AMD 762 BIOS
manual from www.amd.com) is not in PCI compliant mode

> > see corruption and failures. Most devices don't have that dependancy
> > but a few do - and break horribly.
> 
> Might this cause random hard lockups under a compute intensive load?

Hard to say. 

> Since the fixup applies to the AMD762 northbridge, common to the 760MP
> and 760MPX chipsets, this discussion applies to all SMP Athlon
> motherboards at present, is that right?

I believe so. 

> Lastly, do you know whether the reason that the A7M266-D comes with a
> PCI USB2 card is that the USB support of the AMD768 southbridge is
> borked?  Both the Tyan S2466 and the MSI K7D Master come with PCI USB
> cards.

My guess too - but I don't know
