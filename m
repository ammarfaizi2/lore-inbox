Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261604AbUEFR04@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261604AbUEFR04 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 13:26:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261597AbUEFR04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 13:26:56 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:53459 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261610AbUEFR0w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 13:26:52 -0400
Date: Thu, 6 May 2004 19:26:45 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Antonio Dolcetta <adolcetta@infracom.it>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc3-mm2
Message-ID: <20040506172645.GS9636@fs.tum.de>
References: <20040505013135.7689e38d.akpm@osdl.org> <20040506165304.6376fed1@simbad> <20040506081258.569d696e.akpm@osdl.org> <20040506175630.6adb6016@simbad>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040506175630.6adb6016@simbad>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 06, 2004 at 05:56:30PM +0200, Antonio Dolcetta wrote:
> On Thu, 6 May 2004 08:12:58 -0700
> Andrew Morton <akpm@osdl.org> wrote:
> 
> > Antonio Dolcetta <adolcetta@infracom.it> wrote:
> > >
> > > something has broken the b44 module,
> > >  modprobe b44 fails with:
> > >  FATAL: Error inserting b44 (/lib/modules/2.6.6-rc3-mm2/kernel/drivers/net/b44.ko): Unknown symbol in module, or unknown parameter (see dmesg)
> > > 
> > >  dmesg contains the line:
> > >  b44: Unknown symbol generic_mii_ioctl
> > 
> > Please config that your .config does not set CONFIG_MII?
> > 
> > 
> 
> I enabled the Media Independent Interface and it works perfectly
> Sorry for the noise

Why sorry?

You found a bug in the kernel, and Andrew has posted a patch to fix this 
bug in future kernel releases.

> 	Antonio

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

