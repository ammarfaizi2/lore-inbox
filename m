Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318562AbSHLBl6>; Sun, 11 Aug 2002 21:41:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318563AbSHLBl6>; Sun, 11 Aug 2002 21:41:58 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:64523
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S318562AbSHLBl4>; Sun, 11 Aug 2002 21:41:56 -0400
Date: Sun, 11 Aug 2002 18:37:11 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: martin@dalecki.de
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pdc20265 problem.
In-Reply-To: <3D5364C2.9030106@evision.ag>
Message-ID: <Pine.LNX.4.10.10208111834090.3940-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hey PinHead #2,

> > /src/linux-2.5.4-pristine/drivers/ide/ide-pci.c

This was before you WRECKED the functionality.
I am having to much of a laugh watching you destroy the driver and the Fin
having the suffer the pain of the reports of your global failure.

The only patch I will send you is rm -rf ./linux-2.5.X/driver/ide/

It is the only proper thing to do at this time.

Regards,

Andre Hedrick
LAD Storage Consulting Group

On Fri, 9 Aug 2002, Marcin Dalecki wrote:

> Uz.ytkownik Andre Hedrick napisa?:
> > Because I can not get a FSCKING PATCH past any of the Lead Penquins.
> > 
> > /src/linux-2.5.4-pristine/drivers/ide/ide-pci.c
> > #ifdef CONFIG_PDC202XX_FORCE
> >         {DEVID_PDC20265,"PDC20265",     PCI_PDC202XX,   ATA66_PDC202XX,
> > INIT_PDC202XX,  NULL,           {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
> > ON_BOARD,
> > 48 },
> > #else /* !CONFIG_PDC202XX_FORCE */
> >         {DEVID_PDC20265,"PDC20265",     PCI_PDC202XX,   ATA66_PDC202XX,
> > INIT_PDC202XX,  NULL,           {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
> > OFF_BOARD,
> > 48 },
> > #endif
> > 
> > But since there is the option to compile off-board as bootable, it is a
> > noop.  I have not been able to directly add code or update any kernel
> > first hand since the change in 2.5.3 and my exit of Linux Development at
> > 2.5.5.  So I really don't give a damn.
> > 
> > But what I do know is people bug me for patches and updates and ask me to
> > fix 2.5.XX on a regular bases.  Nobody takes my patches but man when crap
> > hits the fan they come running for me to put it right again.
> 
> Bullshit. First you have to send patches out at all before they can be
> accepted or rejected. As far as I'm concerned I never saw anything from
> him.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

