Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262033AbUAMA0u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 19:26:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262687AbUAMA0t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 19:26:49 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:36818 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262033AbUAMAZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 19:25:45 -0500
Date: Tue, 13 Jan 2004 01:25:42 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andreas Haumer <andreas@xss.co.at>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: [2.4 patch] disallow modular CONFIG_COMX
Message-ID: <20040113002541.GX9677@fs.tum.de>
References: <Pine.LNX.4.58L.0312311109131.24741@logos.cnet> <3FF2EAB3.1090001@xss.co.at> <20040111013043.GY25089@fs.tum.de> <40031EB1.5030705@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40031EB1.5030705@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 12, 2004 at 05:24:49PM -0500, Jeff Garzik wrote:
> Adrian Bunk wrote:
> >
> >CONFIG_COMX=m always gave an unresolved symbol in kernel 2.4, and it
> >seems noone is interested in properly fixing it.
> >
> >The patch below disallows a modular CONFIG_COMX.
> 
> I agree with the intent...
> 
> At this point, I am tempted to simply comment it out of the Config.in, 
> and let interested parties backport bug fixes and crap from 2.6 if they 
> would like.  The driver has had obvious bugs for a while...

In 2.6 the driver is marked BROKEN...

I only checked the compilation, if the driver compiled statically works 
I don't think it's a good idea to completely disable it.

> 	Jeff

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

