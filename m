Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261565AbVDQXsH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261565AbVDQXsH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 19:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261567AbVDQXsG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 19:48:06 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:58117 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261565AbVDQXrq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 19:47:46 -0400
Date: Mon, 18 Apr 2005 01:47:39 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: netdev@oss.sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] drivers/net/wan/: possible cleanups
Message-ID: <20050417234738.GY3625@stusta.de>
References: <20050327143418.GE4285@stusta.de> <1111941516.14877.325.camel@localhost.localdomain> <20050414232028.GD20400@stusta.de> <1113587392.11155.33.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1113587392.11155.33.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2005 at 06:49:56PM +0100, Alan Cox wrote:
> On Gwe, 2005-04-15 at 00:20, Adrian Bunk wrote:
> > On Sun, Mar 27, 2005 at 05:38:38PM +0100, Alan Cox wrote:
> > > On Sul, 2005-03-27 at 15:34, Adrian Bunk wrote:
> > > >   - syncppp.c: sppp_input
> > > >   - syncppp.c: sppp_change_mtu
> > > >   - z85230.c: z8530_dma_sync
> > > >   - z85230.c: z8530_txdma_sync
> > > 
> > > Please leave the z85230 ones at least. They are an intentional part of
> > > the external API for writing other 85230 card drivers.
> > 
> > If they are part of an API, why aren't the prototypes for them in any 
> > header file?
> 
> They were once. I guess that got "tided" at some point, possibly long
> ago even before submission.
>...

Are there any external drivers using these exports, and if there are, 
why aren't they in the kernel?

If there aren't and someone will at some time in the future need them, 
re-adding the exports will be trivial.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

