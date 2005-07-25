Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261486AbVGYVQO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261486AbVGYVQO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 17:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261490AbVGYVQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 17:16:14 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:46603 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261486AbVGYVQN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 17:16:13 -0400
Date: Mon, 25 Jul 2005 23:16:04 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Gaspar Bakos <gbakos@cfa.harvard.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: elvtune with 2.6 kernels (under FC3)
Message-ID: <20050725211604.GG3160@stusta.de>
References: <Pine.SOL.4.58.0507251629130.2429@titan.cfa.harvard.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOL.4.58.0507251629130.2429@titan.cfa.harvard.edu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2005 at 04:31:56PM -0400, Gaspar Bakos wrote:

> Hi,


Hi Gaspar,


> I am cc-ing this to the kernel list, a i have the suspicion that it may
> be a kernel related feature.
> 
> --------------
> I noticed that elvtune does not work on FC3 with a 2.6.12.3
> (self-compiled, pristine) kernel. I also tried it with other 2.6.* kernels.
> 
> elvtune /dev/sde
> ioctl get: Invalid argument
> 
> In fact, I get the same message for all disks, either those on a 3ware
> controller, or SATA disks directly attached to the motherboard.
> The hw is a dual opteron mb with 4Gb RAM.
> 
> Did this command become obsoleted?
> Is there alternativ?


util-linux >= 2.12h gives you a better error message:


# elvtune /dev/hda
ioctl get: Invalid argument

elvtune is only useful on older kernels;
for 2.6 use IO scheduler sysfs tunables instead..
# 


> Cheers
> Gaspar


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

