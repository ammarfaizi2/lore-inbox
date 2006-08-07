Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750823AbWHGRz7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbWHGRz7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 13:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbWHGRz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 13:55:58 -0400
Received: from ns2.suse.de ([195.135.220.15]:23698 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750823AbWHGRz6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 13:55:58 -0400
Date: Mon, 7 Aug 2006 10:55:11 -0700
From: Greg KH <greg@kroah.com>
To: "D. Hazelton" <dhazelton@enter.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PCI Resource Allocation Error
Message-ID: <20060807175511.GB7868@kroah.com>
References: <200608071034.28366.dhazelton@enter.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608071034.28366.dhazelton@enter.net>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2006 at 10:34:27AM -0400, D. Hazelton wrote:
> After using 2.6.8 and 2.6.11 for a *long* time I decided to upgrade. When I 
> first tried using 2.6.15 I tested a vanilla kernel and ran into the following 
> message in the dmesg:
> 
> PCI: Failed to allocate mem resource #6:20000@f0000000 for 0000:01:00.0
> 
> Since I'm running FC4 I figured that a fix might have made it into the distro 
> supplied kernel, so I again upgraded, this time to 2.6.17-1.2142_FC4. I see 
> the same message in the dmesg output, so I'm certain that it hasn't been 
> fixed.
> 
> This is definately caused by my graphics card, an  NVidia GeForce 5200, just 
> because that's the PCI ID of the AGP port.
> 
> I know a lot of you will tell me to file a report with RedHat, but after 
> checking the LKML archives I see this problem was introduced around 2.6.13 
> and though I saw some patches to fix this, I'm pretty certain they were 
> either for x86-64 or were not ever merged.

Even with this message, does the hardware still work properly?

thanks,

greg k-h
