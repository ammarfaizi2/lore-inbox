Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130038AbRDPKLc>; Mon, 16 Apr 2001 06:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129381AbRDPKLW>; Mon, 16 Apr 2001 06:11:22 -0400
Received: from linux.kappa.ro ([194.102.255.131]:51925 "EHLO linux.kappa.ro")
	by vger.kernel.org with ESMTP id <S130038AbRDPKLP>;
	Mon, 16 Apr 2001 06:11:15 -0400
X-RAV-AntiVirus: This e-mail has been scanned for viruses on host: linux.kappa.ro
Date: Mon, 16 Apr 2001 13:10:23 +0300
From: Mircea Damian <dmircea@kappa.ro>
To: Alexander Viro <viro@math.psu.edu>
Cc: Jens Axboe <axboe@suse.de>, Arthur Pedyczak <arthur-p@home.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: loop problems continue in 2.4.3
Message-ID: <20010416131023.A19844@linux.kappa.ro>
In-Reply-To: <20010416104936.B9539@suse.de> <Pine.GSO.4.21.0104160527400.3095-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0104160527400.3095-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Mon, Apr 16, 2001 at 05:30:45AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 16, 2001 at 05:30:45AM -0400, Alexander Viro wrote:
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

But the guy said:
"
> disappers from cat /proc/mounts output, but the module 'loop' shows as
> busy and cannot be removed even though there are no more loop mounts.
"

So he has no loop mounts and he can not remove the module. This is a bug!


-- 
Mircea Damian
E-mails: dmircea@kappa.ro, dmircea@roedu.net
WebPage: http://taz.mania.k.ro/~dmircea/
