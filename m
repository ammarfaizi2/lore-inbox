Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263310AbSJOSxj>; Tue, 15 Oct 2002 14:53:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264021AbSJOSxj>; Tue, 15 Oct 2002 14:53:39 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:58376 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S263310AbSJOSxd>;
	Tue, 15 Oct 2002 14:53:33 -0400
Date: Tue, 15 Oct 2002 11:59:32 -0700
From: Greg KH <greg@kroah.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Joe Thornber <joe@fib011235813.fsnet.co.uk>,
       Linux Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>, Dave Jones <davej@suse.de>
Subject: Re: [PATCH] Device-mapper submission 6/7
Message-ID: <20021015185932.GA15420@kroah.com>
References: <20021015175858.GA28170@fib011235813.fsnet.co.uk> <3DAC5B47.7020206@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DAC5B47.7020206@pobox.com>
User-Agent: Mutt/1.4i
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

I second that idea.

With libfs now in 2.5, it's quite easy to make such a filesystem.

greg k-h
