Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263265AbTCNHtS>; Fri, 14 Mar 2003 02:49:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263267AbTCNHtS>; Fri, 14 Mar 2003 02:49:18 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:4840 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S263265AbTCNHtR>;
	Fri, 14 Mar 2003 02:49:17 -0500
Date: Fri, 14 Mar 2003 08:59:57 +0100
From: Jens Axboe <axboe@suse.de>
To: Oleg Drokin <green@namesys.com>
Cc: Oleg Drokin <green@linuxhacker.ru>, alan@redhat.com,
       linux-kernel@vger.kernel.org, viro@math.psu.edu
Subject: Re: [2.4] init/do_mounts.c::rd_load_image() memleak
Message-ID: <20030314075957.GX836@suse.de>
References: <20030313210144.GA3542@linuxhacker.ru> <20030313220308.A28040@flint.arm.linux.org.uk> <20030314105032.A17568@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030314105032.A17568@namesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 14 2003, Oleg Drokin wrote:
> Hello!
> 
> On Thu, Mar 13, 2003 at 10:03:08PM +0000, Russell King wrote:
> 
> > > +	if (buf)
> > > +		kfree(buf);
> > kfree(NULL); is valid - you don't need this check.
> 
> Almost every place I can think of does just this, so I do not see why this
> particular piece of code should be different.

Since when has that been a valid argument? :)

-- 
Jens Axboe

