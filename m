Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265327AbSKFOAR>; Wed, 6 Nov 2002 09:00:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265332AbSKFOAR>; Wed, 6 Nov 2002 09:00:17 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:35589 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S265327AbSKFOAP>; Wed, 6 Nov 2002 09:00:15 -0500
Date: Wed, 6 Nov 2002 15:06:41 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Jens Axboe <axboe@suse.de>
cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 vi .config ; make oldconfig not working
In-Reply-To: <20021105172110.GB1830@suse.de>
Message-ID: <Pine.LNX.4.44.0211061457370.13258-100000@serv>
References: <20021105165024.GJ13587@suse.de> <3DC7FB11.10209@pobox.com>
 <20021105171409.GA1137@suse.de> <3DC7FD95.5000903@pobox.com>
 <20021105172110.GB1830@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 5 Nov 2002, Jens Axboe wrote:

> > >axboe@burns:[.]linux-2.5-deadline-rbtree $ grep CONFIG_NFSD_V4 < .config
> > >641:CONFIG_NFSD_V4=y
> > >axboe@burns:[.]linux-2.5-deadline-rbtree $ vi .config
> > >axboe@burns:[.]linux-2.5-deadline-rbtree $ grep CONFIG_NFSD_V4 < .config
> > >641:CONFIG_NFSD_V4=n
> > >
> > 
> > '=n' is wrong, that should be "# CONFIG_NFSD_V4 is not set" still...
> 
> Why is that wrong? It worked before.

It was not documented and I only implemented that was documented. :)
It's of course no problem to change that.

bye, Roman

