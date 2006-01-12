Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161454AbWALXOO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161454AbWALXOO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 18:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161459AbWALXOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 18:14:14 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:50692 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1161454AbWALXON (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 18:14:13 -0500
Date: Fri, 13 Jan 2006 00:14:12 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [git patches] 2.6.x net driver updates
Message-ID: <20060112231412.GB29663@stusta.de>
References: <20060112221322.GA25470@havoc.gtf.org> <Pine.LNX.4.64.0601121423120.3535@g5.osdl.org> <20060112224227.GA26888@havoc.gtf.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060112224227.GA26888@havoc.gtf.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2006 at 05:42:27PM -0500, Jeff Garzik wrote:
> On Thu, Jan 12, 2006 at 02:30:19PM -0800, Linus Torvalds wrote:
> > 
> > 
> > On Thu, 12 Jan 2006, Jeff Garzik wrote:
> > > 
> > > dann frazier:
> > >       CONFIG_AIRO needs CONFIG_CRYPTO
> > 
> > I think this is done wrong.
> > 
> > It should "select CRYPTO" rather than "depends on CRYPTO".
> 
> OK
>...

What was wrong with my patch [1] that did not only this, but also fixes 
the same bug with AIRO_CS and removes all the #ifdef's for the 
non-compiling CRYPTO=n case from the driver?

> 	Jeff

cu
Adrian

[1] http://lkml.org/lkml/2006/1/10/328

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

