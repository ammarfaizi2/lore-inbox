Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422737AbWJ3Wy5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422737AbWJ3Wy5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 17:54:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422732AbWJ3Wy5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 17:54:57 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:26629 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1422737AbWJ3Wy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 17:54:56 -0500
Date: Mon, 30 Oct 2006 23:54:55 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Marc Perkel <marc@perkel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux Freezes during disk IO on Asus M2NPV-VM nVidia chipset - raid 0 related?
Message-ID: <20061030225455.GM27968@stusta.de>
References: <4546400C.1090500@perkel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4546400C.1090500@perkel.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2006 at 10:10:20AM -0800, Marc Perkel wrote:
> Trying to track down my remaining lockup problem with Linux using my 
> first AMD AM2 motherboard. It's been a nightmare, but it's getting 
> better. but I think it might be a Linux bug. But I have some specific 
> info that might lead to something.
> 
> This motherboard use nVidia GeForce 6150 chipset
> The computer seems to only freeze up during disk IO - specifically when 
> downloading using rsync.
> It also seems to lock up when writing data to a RAID 0 EXT3 filesystem. 
> I'm using software raid.
> 
> I'm currently running the stock Fedora Core 6 kernel based on 1.6.18.1

A stock ftp.kernel.org kernel with as many debug options as possible 
turned on might be a better choice.

> After several lockups I tried reformatting the partition to see if 
> perhaps the data was so screwed up that it was the problem. The reformat 
> didn't fix it.
> 
> It also seems that when it does crash that recovery isn't as clean as it 
> usually is. It seems that I have to run e2fsck manually more often than 
> usual and that it find more things to fix. Other drives that are not 
> part of raid seem to not have this issue.
> 
> I hope this is enough information to help track this down.

Unfortunately, it doesn't help at all.

Please send a complete "dmesg -s 1000000".

Please follow Lee's suggestion and report any messages you see (a 
photo with a digital camera is OK).

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

