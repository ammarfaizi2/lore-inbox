Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935436AbWK2HgI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935436AbWK2HgI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 02:36:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935467AbWK2HgH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 02:36:07 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:38407 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S935436AbWK2HgE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 02:36:04 -0500
Date: Wed, 29 Nov 2006 08:36:09 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>, netdev@vger.kernel.org
Subject: Re: 2.6.19-rc6-mm1: drivers/net/chelsio/: unused code
Message-ID: <20061129073609.GA11084@stusta.de>
References: <20061123021703.8550e37e.akpm@osdl.org> <20061124001731.GO3557@stusta.de> <20061127102455.362fe88f@dxpl.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061127102455.362fe88f@dxpl.pdx.osdl.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2006 at 10:24:55AM -0800, Stephen Hemminger wrote:
> On Fri, 24 Nov 2006 01:17:31 +0100
> Adrian Bunk <bunk@stusta.de> wrote:
> 
> > On Thu, Nov 23, 2006 at 02:17:03AM -0800, Andrew Morton wrote:
> > >...
> > > Changes since 2.6.19-rc5-mm2:
> > >...
> > > +chelsio-22-driver.patch
> > >...
> > >  netdev updates
> > 
> > It is suspicious that the following newly added code is completely unused:
> >   drivers/net/chelsio/ixf1010.o
> >     t1_ixf1010_ops
> >   drivers/net/chelsio/mac.o
> >     t1_chelsio_mac_ops
> >   drivers/net/chelsio/vsc8244.o
> >     t1_vsc8244_ops
> > 
> > cu
> > Adrian
> > 
> 
> All that is gone in later version. I reposted new patches
> after -mm2 was done.

It seems these patches didn't make it into 2.6.19-rc6-mm2 ?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

