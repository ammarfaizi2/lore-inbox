Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265337AbSKFOHi>; Wed, 6 Nov 2002 09:07:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265339AbSKFOHi>; Wed, 6 Nov 2002 09:07:38 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:56227 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S265337AbSKFOHh>;
	Wed, 6 Nov 2002 09:07:37 -0500
Date: Wed, 6 Nov 2002 15:13:56 +0100
From: Jens Axboe <axboe@suse.de>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 vi .config ; make oldconfig not working
Message-ID: <20021106141356.GF9609@suse.de>
References: <20021105165024.GJ13587@suse.de> <3DC7FB11.10209@pobox.com> <20021105171409.GA1137@suse.de> <3DC7FD95.5000903@pobox.com> <20021105172110.GB1830@suse.de> <Pine.LNX.4.44.0211061457370.13258-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211061457370.13258-100000@serv>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06 2002, Roman Zippel wrote:
> Hi,
> 
> On Tue, 5 Nov 2002, Jens Axboe wrote:
> 
> > > >axboe@burns:[.]linux-2.5-deadline-rbtree $ grep CONFIG_NFSD_V4 < .config
> > > >641:CONFIG_NFSD_V4=y
> > > >axboe@burns:[.]linux-2.5-deadline-rbtree $ vi .config
> > > >axboe@burns:[.]linux-2.5-deadline-rbtree $ grep CONFIG_NFSD_V4 < .config
> > > >641:CONFIG_NFSD_V4=n
> > > >
> > > 
> > > '=n' is wrong, that should be "# CONFIG_NFSD_V4 is not set" still...
> > 
> > Why is that wrong? It worked before.
> 
> It was not documented and I only implemented that was documented. :)
> It's of course no problem to change that.

Thanks, patch from Petr is perfect :-)

-- 
Jens Axboe

