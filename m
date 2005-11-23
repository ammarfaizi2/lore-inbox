Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932422AbVKWU5N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932422AbVKWU5N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 15:57:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932458AbVKWU5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 15:57:13 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:35601 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932421AbVKWU5L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 15:57:11 -0500
Date: Wed, 23 Nov 2005 21:57:10 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
       linux-pm@lists.osdl.org, akpm@osdl.org
Subject: Re: [Patch 0/6] Remove Deprecated PM Interface from Obsolete Sound Drivers
Message-ID: <20051123205710.GW3963@stusta.de>
References: <Pine.LNX.4.50.0511231114340.14446-100000@monsoon.he.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0511231114340.14446-100000@monsoon.he.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 12:23:25PM -0800, Patrick Mochel wrote:
> 
> Hi there.

Hi Patrick,

> This is a series of 6 patches that remove the old, deprecated power
> management interface from a variety of old OSS drivers, most of them
> marked OBSOLETE and scheduled for removal in January 2006.
> 
> These patches facilitate the removal of the ancient PM interface by
> reducing the number of in-kernel users to 3:
> 
> 	drivers/net/3c509.c
> 	drivers/net/irda/ali-ircc.c
> 	drivers/serial/68328serial.c
>...
> Does any one have any objections to these patches?

I'd say the obsolete OSS drivers are the least problem, it would be more  
interesting to get the code fixed that will still be present two months  
from now.

Looking at the current state of 2.6.15, I doubt your patches would make 
it into Linus' tree earlier than the complete removal of the drivers.

> Thanks,
> 
> 	Pat
>...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

