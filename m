Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262737AbTGAQxN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 12:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262861AbTGAQxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 12:53:13 -0400
Received: from filesrv1.system-techniques.com ([199.33.245.55]:54662 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id S262737AbTGAQxM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 12:53:12 -0400
Date: Tue, 1 Jul 2003 13:07:30 -0400 (EDT)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: Larry McVoy <lm@bitmover.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bkbits.net is down
In-Reply-To: <20030701145041.GA18394@work.bitmover.com>
Message-ID: <Pine.LNX.4.56.0307011306090.1716@filesrv1.baby-dragons.com>
References: <20030621135812.GE14404@work.bitmover.com>
 <20030621190944.GA13396@work.bitmover.com> <20030622002614.GA16225@work.bitmover.com>
 <20030623053713.GA6715@work.bitmover.com> <20030625013302.GB2525@work.bitmover.com>
 <20030626231752.E5633@ucw.cz> <20030626212102.GA19056@work.bitmover.com>
 <1056711200.3174.23.camel@dhcp22.swansea.linux.org.uk>
 <20030627145727.GB18676@work.bitmover.com> <1056728645.3174.48.camel@dhcp22.swansea.linux.org.uk>
 <20030701145041.GA18394@work.bitmover.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello Larry ,  The inserted eamil was dropped on the list awhile
	back .  See after .sig .  JimL

On Tue, 1 Jul 2003, Larry McVoy wrote:
> Does anyone know how to enable caching on a mylex AcceleRAID 170 (aka
> DAC960) SCSI controller?  We've got the bkbits.net data mirrored at
> rackspace.com but the controllers are read and write cache disabled.
> I read the driver source and it doesn't offer this ability via the
> /proc configuration space which is where I would have expected it.
> Is this a bios only thing?
-- 
       +------------------------------------------------------------------+
       | James   W.   Laferriere | System    Techniques | Give me VMS     |
       | Network        Engineer |     P.O. Box 854     |  Give me Linux  |
       | babydr@baby-dragons.com | Coudersport PA 16915 |   only  on  AXP |
       +------------------------------------------------------------------+
On Mon, 5 Feb 2001, Dan Jones wrote:
> Date: Mon, 05 Feb 2001 17:28:05 -0800
> From: Dan Jones <djones@valinux.com>
> To: octave klaba <oles@ovh.net>
> Cc: "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>
> Subject: Re: DAC960 & cache
>
> octave klaba wrote:
> >
> > Hello,
> >
> > On Mylex 170 we have, the read/write cache disabled.
> > How can I switch it on ? Since we have it with raid-1
> > and the hd has the cache too, do we lose the data if
> > the server caches ?
> >
> > Thanks
> > Octave
> >
> > DAC960#0:   Logical Drives:
> > DAC960#0:     /dev/rd/c0d0: RAID-1, Online, 35807232 blocks
> > DAC960#0:                   Logical Device Initialized, BIOS Geometry:
> > 255/63
> > DAC960#0:                   Stripe Size: 64KB, Segment Size: 8KB
> > DAC960#0:                   Read Cache Disabled, Write Cache Disabled
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-raid" in
> > the body of a message to majordomo@vger.kernel.org
>
> The cache policy can be switched via the Mylex firmware. Check out
> Mylex's searchable FAQ. Try searching on enable cache. The
> instructions cover the DACCF firmware. EzAssist will be different:
>
> http://mylex.custhelp.com/cgi-bin/mylex.cfg/php/enduser/home.php
>
> The A170 doesn't have a battery, so remember to allow the cache to
> flush before resetting or power cycling your system:
> --
> Dan Jones, Manager, Storage Products          VA Linux Systems
> V:(510)687-6737 F:(510)683-8602               47071 Bayside Parkway
> djones@valinux.com                            Fremont, CA 94538
