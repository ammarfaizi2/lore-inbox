Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264924AbSJOVi1>; Tue, 15 Oct 2002 17:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264926AbSJOVi0>; Tue, 15 Oct 2002 17:38:26 -0400
Received: from cmailg4.svr.pol.co.uk ([195.92.195.174]:13337 "EHLO
	cmailg4.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S264925AbSJOVi0>; Tue, 15 Oct 2002 17:38:26 -0400
Date: Tue, 15 Oct 2002 22:44:20 +0100
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>, Dave Jones <davej@suse.de>
Subject: Re: [PATCH] Device-mapper submission 6/7
Message-ID: <20021015214420.GA28738@fib011235813.fsnet.co.uk>
References: <20021015175858.GA28170@fib011235813.fsnet.co.uk> <3DAC5B47.7020206@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DAC5B47.7020206@pobox.com>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2002 at 02:15:35PM -0400, Jeff Garzik wrote:
> >[Device mapper]
> >Provide a traditional ioctl based interface to control device-mapper
> >from userland.
>
>
> If you're adding a new interface, there should be no need to add new
> ioctls and all that they entail.  Just control via a ramfs-based fs...

We originally did have a fs based interface written by Steve
Whitehouse.  However at the time (about a year ago) it wasn't obvious
that everyone would think it a good idea.  Also the code was
significantly larger than the ioctl interface.  I would be more than
happy to do away with the ioctl stuff if people are now in full
agreement that an fs interface is the way to go.

    Joe
