Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750748AbWDSSH0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbWDSSH0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 14:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750773AbWDSSH0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 14:07:26 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:4371 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750748AbWDSSHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 14:07:25 -0400
Date: Wed, 19 Apr 2006 20:07:24 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Muli Ben-Yehuda <muli@il.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] mark virt_to_bus/bus_to_virt as __deprecated on i386
Message-ID: <20060419180724.GD25047@stusta.de>
References: <20060418220715.GO11582@stusta.de> <20060419051355.GI4825@rhun.haifa.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060419051355.GI4825@rhun.haifa.ibm.com>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2006 at 08:13:55AM +0300, Muli Ben-Yehuda wrote:
> On Wed, Apr 19, 2006 at 12:07:15AM +0200, Adrian Bunk wrote:
> > virt_to_bus/bus_to_virt are long deprecated, mark them as __deprecated 
> > on i386.
> 
> You should probably update Documentation/ while you're at it.

Which file under Documentation/ are you referring to?

> Also, IIRC Xen uses virt_to_phys to return guest physical addresses
> and virt_to_bus to return machine physical addresses, so the
> difference is useful at least in some scenarios.

Solving this should be easy.

And this still doesn't make it right for architecture independent 
drivers to use virt_to_bus/bus_to_virt.

> Cheers,
> Muli

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

