Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261482AbRE3Q1L>; Wed, 30 May 2001 12:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261487AbRE3Q1C>; Wed, 30 May 2001 12:27:02 -0400
Received: from unityhill.com ([207.106.123.146]:52608 "EHLO mail.newearth.org")
	by vger.kernel.org with ESMTP id <S261482AbRE3Q0y>;
	Wed, 30 May 2001 12:26:54 -0400
Date: Wed, 30 May 2001 12:26:51 -0400 (EDT)
From: Michael David <michael@newearth.org>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.5 panic while starting aic7xxx 
In-Reply-To: <200105301519.f4UFJ2U53164@aslan.scsiguy.com>
Message-ID: <Pine.LNX.4.32.0105301225570.2618-100000@sapphire.newearth.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The "rebuild firmware" option was the right answer in this
case. It is now working.

> Date: Wed, 30 May 2001 09:19:02 -0600
> From: Justin T. Gibbs <gibbs@scsiguy.com>
> To: Michael David <michael@newearth.org>
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: 2.4.5 panic while starting aic7xxx
>
> >SCSI subsystem driver Revision: 1.00
> >PCI: Found IRQ 11 for device 00:0c.0
> >scsi0: Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.1.13
> >        <Adaptec 2940 Ultra2 SCSI adapter>
> >        aic7890/91: Ultra2 Wide Channel A, SCSI Id=7, 32/255 SCBs
> >ahc_intr: AWAITING_MSG for an SCB that does not have a waiting message
> >SCSIID = 7, target_mask = 1
> >Kernel panic: SCB = 3, SCB Control = 40, MSG_OUT = 80 SCB flags = 6000
> >In interrupt handler - not syncing
>
> This looks like the firmware file is not in sync with the rest
> of the driver.  Depending on the host environment, you may be
> able to rebuild the firmware yourself.  Just check the box in
> the kernel config section for the aic7xxx driver to rebuild
> the firmware.

-- 
Michael V. David, AAO (Acronym Assignment Officer), NewEarth Swedenborg BBS
michael@newearth.org - http://www.newearth.org/~michael - Penguin 2.4.3-XFS
"Never apply a Star Trek solution to a Babylon 5 problem" -- Nicholas C. Weaver

