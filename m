Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271845AbRHUT5z>; Tue, 21 Aug 2001 15:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271844AbRHUT5p>; Tue, 21 Aug 2001 15:57:45 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:31136 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S271845AbRHUT5c>; Tue, 21 Aug 2001 15:57:32 -0400
Date: Tue, 21 Aug 2001 13:57:14 -0600
Message-Id: <200108211957.f7LJvEt20846@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Luca Montecchiani <m.luca@iname.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [FAQ?] More ram=less performance (maximum cacheable RAM)
In-Reply-To: <3B82B988.50DE308A@iname.com>
In-Reply-To: <3B82B988.50DE308A@iname.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luca Montecchiani writes:
> I've recently updated my K6-2 from 128 to 256mbytes (2x128 pc133 dimms)
> compiling kernel take now 13 minutes instead of 9 minutes :(
> 
> Ram is so cheap and socket7 is far from the death, time for a FAQ?
> 
> Here some description from http://9-muses.com/freak/reviews/super7.shtml :
> The Level2 Cache determines the board's maximum cacheable RAM. 
> Boards equipped with 512k can cache up to 128MB of RAM while
> those equipped with 1MB can handle up to 256MB of RAM. If you're using all
> of the RAM cacheable by the the L2 cache, performance is enhanced. Once you
> go above the maximum cacheable RAM, performance is lost. What this means to
> you is the more cache the better. For some users, 64MB or even 128MB of RAM
> is enough, but who knows, somewhere down the road, you might want to upgrade
> to 256MB. It's nice to know your board can handle the extra memory without
> worrying about losing performance.
> 
> More technical information can be found here :
> http://www.pcguide.com/ref/mbsys/cache/char_Cacheability.htm
> 
> Patch and other info about non cacheable ram here :
> http://www.keryan.org/brad/slram/

Er, are you sure about this? The problem isn't the size of your cache,
it's the size of your TAG RAM. That's a different beast.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
