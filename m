Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271745AbRHURD3>; Tue, 21 Aug 2001 13:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271746AbRHURDL>; Tue, 21 Aug 2001 13:03:11 -0400
Received: from [209.202.108.240] ([209.202.108.240]:61700 "EHLO
	terbidium.openservices.net") by vger.kernel.org with ESMTP
	id <S271745AbRHURCz>; Tue, 21 Aug 2001 13:02:55 -0400
Date: Tue, 21 Aug 2001 13:02:57 -0400 (EDT)
From: Ignacio Vazquez-Abrams <ignacio@openservices.net>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Kernel Startup Delay
In-Reply-To: <027001c12a5b$e5d29be0$160e10ac@hades>
Message-ID: <Pine.LNX.4.33.0108211300040.23498-100000@terbidium.openservices.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-scanner: scanned by Inflex 1.0.7 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Aug 2001, Mark Cuss wrote:

> Hello!
>
> I am setting up a server with 4 SCSI hard disks, two of which I will jumper
> to have a delayed spin up as to not bake the power supply.  These two drives
> will contain a striping RAID.  I am concerned that the kernel will load off
> of the other drives and attempt to start this RAID before the disks have
> even spun up - is there a way to have the kernel delay its startup for a
> certain number of seconds while all the drives spin up?
>
> Any hints are greatly appreciated.
>
> Mark

I thought that this was a function of the SCSI BIOS? I know that with the
Adaptec AHA-x940xx and AIC-78x0 you can tell the card/chip to spin up the
drives after individually-configurable delays, and then continue booting the
system once all the drives have spun up. Does your card/chip have a similar
feature?

-- 
Ignacio Vazquez-Abrams  <ignacio@openservices.net>

