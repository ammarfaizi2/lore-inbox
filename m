Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132892AbRDPJbM>; Mon, 16 Apr 2001 05:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132893AbRDPJbC>; Mon, 16 Apr 2001 05:31:02 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:31699 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S132892AbRDPJas>;
	Mon, 16 Apr 2001 05:30:48 -0400
Date: Mon, 16 Apr 2001 05:30:45 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Jens Axboe <axboe@suse.de>
cc: Arthur Pedyczak <arthur-p@home.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: loop problems continue in 2.4.3
In-Reply-To: <20010416104936.B9539@suse.de>
Message-ID: <Pine.GSO.4.21.0104160527400.3095-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 16 Apr 2001, Jens Axboe wrote:

> > I can mount the same file on the same mountpoint more than once. If I
> > mount a file twice (same file on the same mount point)
> 
> This is a 2.4 feature

Ability to losetup different loop devices to the same underlying
file is a bug, though. Not that it was new, though...

