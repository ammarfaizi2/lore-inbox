Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261511AbSJQAki>; Wed, 16 Oct 2002 20:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261570AbSJQAki>; Wed, 16 Oct 2002 20:40:38 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:27660 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261511AbSJQAki>;
	Wed, 16 Oct 2002 20:40:38 -0400
Date: Wed, 16 Oct 2002 17:46:25 -0700
From: Greg KH <greg@kroah.com>
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>, Dave Jones <davej@suse.de>
Subject: Re: [PATCH] Device-mapper submission 6/7
Message-ID: <20021017004625.GF27285@kroah.com>
References: <20021015175858.GA28170@fib011235813.fsnet.co.uk> <3DAC5B47.7020206@pobox.com> <20021015214420.GA28738@fib011235813.fsnet.co.uk> <3DAD75AE.7010405@pobox.com> <20021016152047.GA11422@fib011235813.fsnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021016152047.GA11422@fib011235813.fsnet.co.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2002 at 04:20:47PM +0100, Joe Thornber wrote:
> 
> Yes, I was looking at libfs this morning and think it would remove a
> lot of the code from our old fs interface.  Is this going to be
> backported to 2.4 so that we can move to an fs interface there too ?

Even if it isn't, it is not that hard to create a fs in 2.4.  Take a
look at pcihpfs in drivers/hotplug/ for an example of how to do this.

thanks,

greg k-h
