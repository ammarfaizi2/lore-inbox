Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289962AbSAKN5y>; Fri, 11 Jan 2002 08:57:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289961AbSAKN5p>; Fri, 11 Jan 2002 08:57:45 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:56325 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S289959AbSAKN5b>;
	Fri, 11 Jan 2002 08:57:31 -0500
Date: Fri, 11 Jan 2002 14:57:22 +0100
From: Jens Axboe <axboe@suse.de>
To: Michael Zhu <mylinuxk@yahoo.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: About block device request function
Message-ID: <20020111145722.C19814@suse.de>
In-Reply-To: <20020111135300.67270.qmail@web14911.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020111135300.67270.qmail@web14911.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11 2002, Michael Zhu wrote:
> On Thu, Jan 10 2002, Jens Axboe wrote:
> > 
> > Read drivers/block/ll_rw_blk.c:blk_get_queue() -- >
> > either a driver uses
> > the statically allocated per-major queue, or it > >
> > provides its own and
> > defines a get_queue function to return it.
> > 
> > You are still heading in the wrong direction :/
> 
> You mean that I am still in the wrong direction? I
> need to use the loop device to implement my project?

For the 3rd time, yes!

> Can you give me the right directions? Thank you very
> much.

Look at the internation crypto patches for loop, there are oodles of
examples for you to look at.

-- 
Jens Axboe

