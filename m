Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261707AbUKXDCR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261707AbUKXDCR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 22:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261708AbUKXDCQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 22:02:16 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:24836 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261700AbUKXDCK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 22:02:10 -0500
Date: Wed, 24 Nov 2004 04:02:08 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: chas@cmf.nrl.navy.mil, linux-atm-general@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, jgarzik@pobox.com,
       linux-net@vger.kernel.org
Subject: Re: [2.6 patch] small drivers/atm cleanups (fwd)
Message-ID: <20041124030208.GN2927@stusta.de>
References: <20041124020411.GL2927@stusta.de> <20041123180931.36f1a733.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041123180931.36f1a733.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2004 at 06:09:31PM -0800, Andrew Morton wrote:
> Adrian Bunk <bunk@stusta.de> wrote:
> >
> >   /*
> >  - * This routine will clock the Read_Status_reg function into the X2520
> >  - * eeprom, then pull the result from bit 16 of the NicSTaR's General Purpose 
> >  - * register.  
> >  - */
> >  -
> >  -u_int32_t
> >  -nicstar_read_eprom_status( virt_addr_t base )
> 
> I'd be inclined to whack an #if 0 around functions such as this rather than
> removing them.  Someone may come along one day and do some work on the
> driver, and nicstar_read_eprom_status() may prove to be useful to them.
>...

In this case, you also have to #if 0 rdsrtab.

Are you editing my patch or shall I send an updated patch?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

