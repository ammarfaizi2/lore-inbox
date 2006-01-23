Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964839AbWAWXyS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964839AbWAWXyS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 18:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932430AbWAWXyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 18:54:18 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:60173 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932426AbWAWXyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 18:54:18 -0500
Date: Tue, 24 Jan 2006 00:54:16 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jody McIntyre <scjody@modernduck.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] update the i386 defconfig
Message-ID: <20060123235416.GD3590@stusta.de>
References: <20060119201046.GY19398@stusta.de> <20060120040326.GF13178@conscoop.ottawa.on.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060120040326.GF13178@conscoop.ottawa.on.ca>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2006 at 11:03:27PM -0500, Jody McIntyre wrote:
> On Thu, Jan 19, 2006 at 09:10:46PM +0100, Adrian Bunk wrote:
> > [...]
> >  #
> >  # IEEE 1394 (FireWire) support
> >  #
> > -CONFIG_IEEE1394=y
> 
> Boo.  1394 good.  I suggest the above plus:
> 
> CONFIG_IEEE1394_SBP2=y
> CONFIG_IEEE1394_RAWIO=y

As the patch description said, the i386 defconfig hasn't been updated 
for some time, and I'm therefore updating it with the semantics "the 
kernel that successfully runs on my computer".

I have no problem if someone wants to maintain the i386 defconfig with a 
different semantics, but as long as noone steps up to maintain it, 
I plan to occasionally update it with the semantics "my .config".

> Cheers,
> Jody

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

