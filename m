Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264989AbSKERVU>; Tue, 5 Nov 2002 12:21:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265013AbSKERVT>; Tue, 5 Nov 2002 12:21:19 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:55702 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S264989AbSKERVP>;
	Tue, 5 Nov 2002 12:21:15 -0500
Date: Tue, 5 Nov 2002 18:27:47 +0100
From: Jens Axboe <axboe@suse.de>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 vi .config ; make oldconfig not working
Message-ID: <20021105172747.GD1830@suse.de>
References: <20021105165024.GJ13587@suse.de> <3DC7FB11.10209@pobox.com> <20021105171409.GA1137@suse.de> <1036517201.5601.0.camel@localhost.localdomain> <20021105172617.GC1830@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021105172617.GC1830@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05 2002, Jens Axboe wrote:
> On Tue, Nov 05 2002, Arjan van de Ven wrote:
> > On Tue, 2002-11-05 at 18:14, Jens Axboe wrote:
> > 
> > > axboe@burns:[.]linux-2.5-deadline-rbtree $ grep CONFIG_NFSD_V4 < .config
> > > 641:CONFIG_NFSD_V4=y
> > > axboe@burns:[.]linux-2.5-deadline-rbtree $ vi .config
> > > axboe@burns:[.]linux-2.5-deadline-rbtree $ grep CONFIG_NFSD_V4 < .config
> > > 641:CONFIG_NFSD_V4=n
> > 
> > =n never worked...
> 
> You're wrong, it's always worked. I've never used anything but that.

2.5.44:

axboe@burns:[.]/kernel/iosched/linux-2.5 $ grep NFSD_V4 < .config
750:CONFIG_NFSD_V4=y
axboe@burns:[.]/kernel/iosched/linux-2.5 $ vi .config
axboe@burns:[.]/kernel/iosched/linux-2.5 $ grep NFSD_V4 < .config
750:CONFIG_NFSD_V4=n
axboe@burns:[.]/kernel/iosched/linux-2.5 $ grep NFSD_V4 < .config
750:# CONFIG_NFSD_V4 is not set

Bingo, perfect.

-- 
Jens Axboe

