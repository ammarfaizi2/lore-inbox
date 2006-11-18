Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756364AbWKRSaG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756364AbWKRSaG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 13:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756366AbWKRSaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 13:30:06 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:32015 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1756364AbWKRSaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 13:30:03 -0500
Date: Sat, 18 Nov 2006 19:30:01 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Ray Lee <ray-lk@madrabbit.org>
Cc: Larry Finger <Larry.Finger@lwfinger.net>,
       Johannes Berg <johannes@sipsolutions.net>,
       Joseph Fannin <jhf@columbus.rr.com>, Andrew Morton <akpm@osdl.org>,
       netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
       John Linville <linville@tuxdriver.com>, Michael Buesch <mb@bu3sch.de>,
       Bcm43xx-dev@lists.berlios.de
Subject: Re: bcm43xx regression 2.6.19rc3 -> rc5, rtnl_lock trouble?
Message-ID: <20061118183001.GY31879@stusta.de>
References: <455B63EC.8070704@madrabbit.org> <20061118112438.GB15349@nineveh.rivenstone.net> <1163868955.27188.2.camel@johannes.berg> <455F3D44.4010502@lwfinger.net> <455F4271.1060405@madrabbit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <455F4271.1060405@madrabbit.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 18, 2006 at 09:27:13AM -0800, Ray Lee wrote:
> Larry Finger wrote:
> > Johannes Berg wrote:
> >> Hah, that's a lot more plausible than bcm43xx's drain patch actually
> >> causing this. So maybe somehow interrupts for bcm43xx aren't routed
> >> properly or something...
> >>
> >> Ray, please check /proc/interrupts when this happens.
> 
> When it happens, I can't. The keyboard is entirely dead (I'm in X, perhaps at
> a console it would be okay). The only thing that works is magic SysRq. even
> ctrl-alt-f1 to get to a console doesn't work.
> 
> That said, /proc/interrupts doesn't show MSI routed things on my AMD64 laptop.
>...

If there is any interrupt related problem involved, it should be visible 
from dmesg.

Can you send the complete dmesg's from -rc3, -rc5 and -rc6?

> Ray

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

