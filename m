Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132657AbRDCGsv>; Tue, 3 Apr 2001 02:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132654AbRDCGsl>; Tue, 3 Apr 2001 02:48:41 -0400
Received: from Campbell.cwx.net ([216.17.176.12]:15 "EHLO campbell.cwx.net")
	by vger.kernel.org with ESMTP id <S132624AbRDCGs2>;
	Tue, 3 Apr 2001 02:48:28 -0400
Date: Tue, 3 Apr 2001 00:47:01 -0600
From: Allen Campbell <lkml@campbell.cwx.net>
To: Simon Garner <sgarner@expio.co.nz>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Asus CUV4X-D, 2.4.3 crashes at boot
Message-ID: <20010403004701.A9943@const.>
In-Reply-To: <E14kCnK-0006pa-00@the-village.bc.nu> <011f01c0bbc5$ffc92e60$1400a8c0@expio.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <011f01c0bbc5$ffc92e60$1400a8c0@expio.net.nz>; from sgarner@expio.co.nz on Tue, Apr 03, 2001 at 10:40:36AM +1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 03, 2001 at 10:40:36AM +1200, Simon Garner wrote:
> From: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
> 
> > > I've seen the exact same behavior with my CUV4X-D (2x1GHz) under
> > > 2.4.2 (debian woody).  In addition, the kernel would sometimes hang
> > > around NMI watchdog enable.  At least, I think it's trying to
> >
> > Known problem. Thats one reason why -ac trees had nmi watchdog turned off.
> 
> It still crashes with nmi_watchdog turned off.
> 
> Running with noapic fixes it but then the system crashes if you access the
> RTC with hwclock (and probably creates a hundred other problems...).
> 
> How can I get this chipset/motherboard supported properly under Linux? I'm
> happy to test patches etc. on the box. *pleading*

Patience is likely to be effective.  The chipset isn't exactly rare
being on SMP boards from Gigabyte, MSI, Tyan and Asus, and likely
others.  I'm betting it will be fixed soon enough.  UP and 2.2.x
kernels worked fine here if you're really desperate.  OTOH, the
board is stable once you get past the boot problems... What sort
of production system needs frequent unattended boots?

Sorry about this, I just don't remember signing any paychecks for
what I know is likely to be a non-issue probably before the next
time I actually have to do something drastic, like reboot.

-- 
  Allen Campbell       |  Lurking at the bottom of the
  allenc@verinet.com   |   gravity well, getting old.
