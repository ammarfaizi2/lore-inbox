Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292282AbSBBNwi>; Sat, 2 Feb 2002 08:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292288AbSBBNw1>; Sat, 2 Feb 2002 08:52:27 -0500
Received: from brick.kernel.dk ([195.249.94.204]:44692 "EHLO
	burns.home.kernel.dk") by vger.kernel.org with ESMTP
	id <S292282AbSBBNwT>; Sat, 2 Feb 2002 08:52:19 -0500
Date: Sat, 2 Feb 2002 14:52:06 +0100
From: Jens Axboe <axboe@suse.de>
To: arjan@fenrus.demon.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: crc32 and lib.a (was Re: [PATCH] nbd in 2.5.3 does
Message-ID: <20020202145206.C4934@suse.de>
In-Reply-To: <20020202135749.B4934@suse.de> <m16X01j-000OVeC@amadeus.home.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m16X01j-000OVeC@amadeus.home.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 02 2002, arjan@fenrus.demon.nl wrote:
> In article <20020202135749.B4934@suse.de> you wrote:
> >> include/linux/blk.h
> >> 
> >>         Changed NR_REQUEST from 256 to 16.  This reduces the number of
> >>         requests that can be queued.  The size of the queue is reduced
> >>         from 16K to 1K.
> 
> > You can do even more than this -- I dunno what I/O interface these
> > embedded system generally uses (the mtd stuff?)
> 
> the MTD stuff wants CONFIG_BLOCKLAYER ;)
> flash + jffs2 doesn't need any blocklayer at all ;)

Right, that was exactly my point...

-- 
Jens Axboe

