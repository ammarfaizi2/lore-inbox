Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751095AbWABWGh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbWABWGh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 17:06:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbWABWGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 17:06:37 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:27401 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751095AbWABWGh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 17:06:37 -0500
Date: Mon, 2 Jan 2006 23:06:37 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Matan Peled <chaosite@gmail.com>, linux-kernel@vger.kernel.org,
       kwall@kurtwerks.com
Subject: Re: Arjan's noinline Patch
Message-ID: <20060102220637.GJ17398@stusta.de>
References: <20060101155710.GA5213@kurtwerks.com> <20060102034350.GD5213@kurtwerks.com> <43B8FA70.2090408@gmail.com> <Pine.LNX.4.61.0601021949240.29938@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0601021949240.29938@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 02, 2006 at 07:51:15PM +0100, Jan Engelhardt wrote:

> Hi,

Hi Jan,

> I tried various kernel compilations; for fun and joy, I built a totally
> monolithic kernel with almost all options turned on. I probably won't
> boot it, heh. First, there were some modules/sourcefiles that fail to
> compile:
> 
> 	CONFIG_MTD_AMDSTD
> 	CONFIG_MTD_JEDEC
> 	CONFIG_FB_PM3
> 
> There are also some issues in drivers/net/wan/sdla_*.c that I had to
> fix before make was able to link to .tmp_vmlinux1.bin. I will post a 
> compile-fix in another thread. Now back to the inlining part. I have a
> number of flavors to show...
>...

Don't set CONFIG_CLEAN_COMPILE=n ...
 
> Jan Engelhardt

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

