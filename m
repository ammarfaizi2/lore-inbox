Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267992AbRHQSRI>; Fri, 17 Aug 2001 14:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268071AbRHQSQ6>; Fri, 17 Aug 2001 14:16:58 -0400
Received: from cobae1.consultronics.on.ca ([205.210.130.26]:28826 "EHLO
	cobae1.consultronics.on.ca") by vger.kernel.org with ESMTP
	id <S267992AbRHQSQq>; Fri, 17 Aug 2001 14:16:46 -0400
Date: Fri, 17 Aug 2001 14:17:00 -0400
From: Greg Louis <glouis@dynamicro.on.ca>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.8-ac6 ad1848 module failed at init
Message-ID: <20010817141700.A1502@athame.dynamicro.on.ca>
Reply-To: Greg Louis <glouis@dynamicro.on.ca>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20010817080330.A613@athame.dynamicro.on.ca> <E15XiRS-0007Ed-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <E15XiRS-0007Ed-00@the-village.bc.nu>
Organization: Dynamicro Consulting Limited
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20010817 (Fri) at 1309:34 +0100, Alan Cox wrote:
> > module ad1848 built but failed at init with "No device found."
> > 
> > I reverted, by copying ad1848.c from the -ac4 tree, and the resulting
> > module loaded successfully, and seems to be functioning correctly.
> 
> Is your card plug and play ?

No, the params are selected among a limited set of combinations with
DIP switches.  The trix module load instruction goes
insmod trix io=0x530 irq=9 dma=3 dma2=0 sb_io=0x220 sb_dma=1 \
  sb_irq=7 mpu_io=0x370 mpu_irq=5

-- 
| G r e g  L o u i s          | gpg public key:      |
|   http://www.bgl.nu/~glouis |   finger greg@bgl.nu |
