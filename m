Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135443AbRDMIeW>; Fri, 13 Apr 2001 04:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135447AbRDMIeN>; Fri, 13 Apr 2001 04:34:13 -0400
Received: from agnus.shiny.it ([194.20.232.6]:47369 "EHLO agnus.shiny.it")
	by vger.kernel.org with ESMTP id <S135446AbRDMIeB>;
	Fri, 13 Apr 2001 04:34:01 -0400
Message-ID: <XFMail.010413103349.pochini@shiny.it>
X-Mailer: XFMail 1.3 [p0] on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <200104122036.f3CKa1s70637@aslan.scsiguy.com>
Date: Fri, 13 Apr 2001 10:33:49 +0200 (CEST)
From: Giuliano Pochini <pochini@shiny.it>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Subject: Re: new aic7xxx driver problems
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>> Can you elaborate on what you had to modify ?
>>
>>I just added AHC_ULTRA to the features of 7850
>>
>>AHC_AIC7850_FE        = AHC_SPIOCAP|AHC_AUTOPAUSE|AHC_TARGETMODE|AHC_ULTRA,
>
> What's the PCI id of the card you are using ?

I'm not at home. If I remember right, it reported exactly the ID
of AHC_AIC7850 card, but I have a *PowerDomain* 2930CU (the Macintosh
version of the card) so pci IDs are likely to be different from the PC
version.

>>Plain v6.1.11 hangs. It prints scsi0: blah blah scsi1: sdfdfgsg, I hear the
>>cd spinning up and nothing more.
>
> Did you apply a patch, or upgrade using the tar file?  If the latter,
> you're missing some changes to the SCSI layer that make the initial
> bus settle delay implimentation more sane.

:-/  I'll try the patch this night.


Bye.
    Giuliano Pochini ->)|(<- Shiny Network {AS6665} ->)|(<-

