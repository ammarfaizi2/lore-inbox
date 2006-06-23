Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933011AbWFWKta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933011AbWFWKta (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 06:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933008AbWFWKta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 06:49:30 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:15567 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S933012AbWFWKt3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 06:49:29 -0400
Date: Fri, 23 Jun 2006 12:48:37 +0200
From: Pavel Machek <pavel@suse.cz>
To: Marcin Juszkiewicz <openembedded@hrw.one.pl>
Cc: Richard Purdie <rpurdie@rpsys.net>, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>, metan@seznam.cz,
       arminlitzel@web.de
Subject: Re: sharp zaurus sl-5500 (collie): touchscreen now works
Message-ID: <20060623104836.GG5343@elf.ucw.cz>
References: <20060610202541.GA26697@elf.ucw.cz> <1150139307.5376.56.camel@localhost.localdomain> <20060614232814.GJ7751@elf.ucw.cz> <1150329342.9240.38.camel@localhost.localdomain> <e6ec3ad10606230320s25596353y7b238593b90051f5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6ec3ad10606230320s25596353y7b238593b90051f5@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Yesterday someone added following info into OpenZaurus FAQ [1]:

Thanks a lot for a pointer.

> >Zaurus SL-5500 MMC/SDIO technical info
> >
> >For communicating with the MMC/SDIO card SL-5500 uses the LoCoMo built-in
> >SPI controller (secondary communication protocol) and 3 LoCoMo GPIOs
> >
> >LOCOMO_SPIMD for SPI MODE
> >LOCOMO_SPICT for SPI CONTROL
> >LOCOMO_SPIST for SPI STATUS
> >LOCOMO_SPITD for SPI TRANSMIT (write)
> >LOCOMO_SPIRD for SPI RECEIVE (read)
> >
> >LOCOMO_GPIO(13) for MMC irq / card detect
> >LOCOMO_GPIO(14) for MMC write protect test bit
> >LOCOMO_GPIO(15) for MMC power
> >
> >All these registers are 16bit, and data transfers are 8bit. On resume
> >the SPI MODE is set to 0x6c14, on suspend to 0x3c14.
> >
> >Useful bits in the SPI MODE register: 0x0001, 0x0040, 0x0080.
> >Useful bits in the SPI CONTROL register: 0x0040 and 0x0080.
> >
> >For further information read the Sandisk SD card manual. A software
> >implementation of the SPI MMC/SD protocol driver can be be found at
> >http://kiel.kool.dk/mmc.c

Do you have any contact to author of this? It lacks any copyright/GPL
info :-(. Is wrt54g also sa1100-based?

> Maybe this will help.

Yes, thanks a lot.

> 1. http://openzaurus.berlios.de/FAQ
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
