Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264955AbSKEROi>; Tue, 5 Nov 2002 12:14:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264965AbSKEROi>; Tue, 5 Nov 2002 12:14:38 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:10902 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S264955AbSKEROh>;
	Tue, 5 Nov 2002 12:14:37 -0500
Date: Tue, 5 Nov 2002 18:21:10 +0100
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 vi .config ; make oldconfig not working
Message-ID: <20021105172110.GB1830@suse.de>
References: <20021105165024.GJ13587@suse.de> <3DC7FB11.10209@pobox.com> <20021105171409.GA1137@suse.de> <3DC7FD95.5000903@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DC7FD95.5000903@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05 2002, Jeff Garzik wrote:
> Jens Axboe wrote:
> 
> > 
> >
> >Hmmm:
> >
> >axboe@burns:[.]linux-2.5-deadline-rbtree $ grep CONFIG_NFSD_V4 < .config
> >641:CONFIG_NFSD_V4=y
> >axboe@burns:[.]linux-2.5-deadline-rbtree $ vi .config
> >axboe@burns:[.]linux-2.5-deadline-rbtree $ grep CONFIG_NFSD_V4 < .config
> >641:CONFIG_NFSD_V4=n
> >
> 
> '=n' is wrong, that should be "# CONFIG_NFSD_V4 is not set" still...

Why is that wrong? It worked before.

> or, just delete it.  that's what I do :)  the configurator will 
> re-prompt for it, and I hit 'n'

I don't want a prompt for y/n, I just set it to no!

> yeah, nfsd build is still broken here too :)

:-)

-- 
Jens Axboe

