Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131563AbRDPQij>; Mon, 16 Apr 2001 12:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131562AbRDPQid>; Mon, 16 Apr 2001 12:38:33 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:30734 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S131508AbRDPQiL>;
	Mon, 16 Apr 2001 12:38:11 -0400
Date: Mon, 16 Apr 2001 18:37:53 +0200
From: Jens Axboe <axboe@suse.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: Arthur Pedyczak <arthur-p@home.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: loop problems continue in 2.4.3
Message-ID: <20010416183753.H9539@suse.de>
In-Reply-To: <20010416104936.B9539@suse.de> <Pine.GSO.4.21.0104160527400.3095-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0104160527400.3095-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Mon, Apr 16, 2001 at 05:30:45AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 16 2001, Alexander Viro wrote:
> 
> 
> On Mon, 16 Apr 2001, Jens Axboe wrote:
> 
> > > I can mount the same file on the same mountpoint more than once. If I
> > > mount a file twice (same file on the same mount point)
> > 
> > This is a 2.4 feature
> 
> Ability to losetup different loop devices to the same underlying
> file is a bug, though. Not that it was new, though...

It's also so close to 'doctor it hurts' that I don't think that's a big
deal. Besides, if we later on want to have size limitited loop on files
(some have already expressed wishes in this direction), we'll do this
anyway.

-- 
Jens Axboe

