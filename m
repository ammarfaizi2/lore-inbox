Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288752AbSBDIAj>; Mon, 4 Feb 2002 03:00:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288747AbSBDIAa>; Mon, 4 Feb 2002 03:00:30 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:33796 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S288742AbSBDIAS>;
	Mon, 4 Feb 2002 03:00:18 -0500
Date: Mon, 4 Feb 2002 08:59:29 +0100
From: Jens Axboe <axboe@suse.de>
To: Manuel McLure <manuel@mclure.org>
Cc: linux-kernel@vger.kernel.org, Andre Hedrick <andre@linuxdiskcert.org>
Subject: Re: 2.4.17 Oops when trying to mount ATAPI CDROM
Message-ID: <20020204085929.P29553@suse.de>
In-Reply-To: <20020202170244.A12338@ulthar.internal> <Pine.LNX.4.10.10202021715180.26613-100000@master.linux-ide.org> <20020203102109.C12338@ulthar.internal> <20020203103216.E12338@ulthar.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020203103216.E12338@ulthar.internal>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 03 2002, Manuel McLure wrote:
> 
> On 2002.02.03 10:21 Manuel McLure wrote:
> > 
> > On 2002.02.02 22:04 Andre Hedrick wrote:
> > >
> > > Manuel,
> > >
> > > Would you be kind enough to be a little more specific on the hardware?
> > > The attached devices bu make model and real vender if known.
> > kml/
> > 
> > The CD-ROM is detected as a Pioneer CD-ROM ATAPI Model DR-A24X 0104 - I
> > haven't opened the case to look at it but I do recall that it is
> > definitely a 24X Pioneer ATAPI CDROM.
> > 
> 
> Some more information - if I boot without "hdc=noprobe hdc=cdrom", I don't 
> get the oops whel loading the "ide-cd" module - instead I get
> 
> hdc: set_drive_speed_status: status=0x00 { }
> hdc: lost interrupt
> hdc: ATAPI 20X CD-ROM drive, 128kB Cache, DMA
> Uniform CD-ROM driver Revision: 3.12
> hdc: lost interrupt
> hdc: lost interrupt
> hdc: lost interrupt
> 
> The module eventually finishes initializing but is not usable due to the 
> "lost interrupt"s.

That particular Pioneer model has never worked well in Linux. I have on
here that at least sort-of works when noprobe is used (the Linux
detection probe really screws it up).

My recommandation -- get another drive. The oops would be nice to have
fixed, but don't expect this drive to ever work well.

-- 
Jens Axboe

