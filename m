Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262605AbUK0Ct0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262605AbUK0Ct0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 21:49:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262916AbUK0CFD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 21:05:03 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:4360 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262605AbUKZTgT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:36:19 -0500
Date: Thu, 25 Nov 2004 16:36:07 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Ghozlane Toumi <gtoumi@laposte.net>, Antonino Daplas <adaplas@pol.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fbdev-devel@lists.sourceforge.net
Subject: Re: [2.6 patch] sstfb.c: make some code static
Message-ID: <20041125153607.GC3537@stusta.de>
References: <20041121153646.GA2829@stusta.de> <1101336587.2571.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101336587.2571.1.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2004 at 10:49:47PM +0000, Alan Cox wrote:
> On Sul, 2004-11-21 at 15:36, Adrian Bunk wrote:
> > The patch below makes some needlessly global code static.
> 
> No it doesn't. It makes some functions static (which is fine) and adds
> some nasty messy pointless #ifdefs. It touches no variable at all.
> 
> Please check your description texts and also don't fill the kernel with
> ifdef crap. Probably the __setup stuff should be a module param new
> style too.

Yes, the description text could have been better.

The "ifdef crap" comes from the fact, that after making the functions 
static, gcc warns if they are unused.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

