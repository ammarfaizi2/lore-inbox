Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750809AbVKSUnW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbVKSUnW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 15:43:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbVKSUnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 15:43:22 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:50693 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750802AbVKSUnV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 15:43:21 -0500
Date: Sat, 19 Nov 2005 21:43:20 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Mark Lord <lkml@rtr.ca>
Cc: jgarzik@pobox.com, tulip-users@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] remove drivers/net/tulip/xircom_tulip_cb.c
Message-ID: <20051119204319.GN16060@stusta.de>
References: <20051118033306.GP11494@stusta.de> <437E56EA.8070103@rtr.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <437E56EA.8070103@rtr.ca>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2005 at 05:34:18PM -0500, Mark Lord wrote:
> Adrian Bunk wrote:
> >This patch removes the obsolete drivers/net/tulip/xircom_tulip_cb.c 
> >driver.
> >
> >Is there any reason why it should be kept?
> 
> Yes.  It is the only driver that works
> without lockups on Xircom Cardbus cards.
> Or so has been the case any time I've tried
> the alternatives.
> 
> Is there any good reason to nuke it?

- there's a more recent driver for the same hardware
- the driver uses the deprecated virt_to_bus/bus_to_virt we want to get 
  rid of

Can you give me a pointer to your bug report containing more details 
regarding the problems you had with the xircom_cb driver?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

