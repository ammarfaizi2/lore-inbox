Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbVEBWBJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbVEBWBJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 18:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261172AbVEBWBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 18:01:09 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:45072 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261169AbVEBWAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 18:00:33 -0400
Date: Tue, 3 May 2005 00:00:30 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Setting the hardware clock together with the system one(was: Re: [patch 1/1] x86_64: make string func definition work as intended)
Message-ID: <20050502220030.GN3592@stusta.de>
References: <20050501190851.5FD5B45EBB@zion> <20050501155327.GX3592@stusta.de> <200505022136.42202.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505022136.42202.blaisorblade@yahoo.it>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2005 at 09:36:41PM +0200, Blaisorblade wrote:
> On Sunday 01 May 2005 17:53, Adrian Bunk wrote:
> > On Sun, May 01, 2005 at 09:08:51PM +0200, blaisorblade@yahoo.it wrote:
> > >...                    ^^^^^^^^^^^^^^^^
> >
> > Please correct the time settings on your computer.
> I'm doing it by hand at every reboot. Just discovered this stupid Gentoo 
> default setting:
> 
> # If you want to sync the system clock to the hardware clock during
> # shutdown, then say "yes" here.
> 
> CLOCK_SYSTOHC="no"
> 
> In other words, the kernel does not auto-adjusts the hardware clock? Well, 
> that's not nice... (maybe only the Gentoo setting).

Besides such issues, it might also be an option to set the time using 
NTP information at boot time or (if network is started later) when 
starting your internet connection.

> Regards.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

