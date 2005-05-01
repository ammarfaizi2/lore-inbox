Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261608AbVEANau@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261608AbVEANau (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 09:30:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261611AbVEANat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 09:30:49 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:263 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261608AbVEANal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 09:30:41 -0400
Date: Sun, 1 May 2005 15:30:40 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Ed Tomlinson <tomlins@cam.org>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc3-mm1
Message-ID: <20050501133040.GB3592@stusta.de>
References: <20050429231653.32d2f091.akpm@osdl.org> <Pine.LNX.4.61.0504301700470.3559@montezuma.fsmlabs.com> <20050430161032.0f5ac973.rddunlap@osdl.org> <200505010909.38277.tomlins@cam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505010909.38277.tomlins@cam.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 01, 2005 at 09:09:37AM -0400, Ed Tomlinson wrote:
>...
> Actually you can look at this either way.  Consider, you ask someone to test mm and
> they have not built a kernel before.  So they have to:
> 
> download a base kernel, untar it.
> download a RCx patch and apply it
> download the mm patch and apply it
> take their current /proc/config.gz and place it in the current dir as .config
> make oldconfig
> make and install the kernel
> 
> using cogito in a few weeks this will translate to
> 
> install a distro package for cogito, which will probably give you the option of downloading the kernel.
> export an RCx directory treedownload the mm patch and apply it
> take their current /proc/config.gz and place it in the current dir as .config
> make oldconfig
> make and install the kernel
> 
> Which is a simpler process...   Its just different.   
>...


How much bandwith does this require?

Currently, 2.6.12-rc3-mm1 requires 3.7 MB for the -rc3 patch (which can 
be used for several -mm patches) plus 2.6 MB for the -mm patch.

The 47 MB download for 2.6.11 are required only once for the many -mm 
kernels between 2.6.11 and 2.6.12.

Looking at these numbers, the average download required for every -mm 
kernel is currently far below 10 MB.


> Ed Tomlinson

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

