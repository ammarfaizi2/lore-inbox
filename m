Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751549AbWAOAnR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751549AbWAOAnR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 19:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751524AbWAOAnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 19:43:17 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:47626 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751330AbWAOAnQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 19:43:16 -0500
Date: Sun, 15 Jan 2006 01:43:15 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, saw@saw.sw.com.sg,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] remove drivers/net/eepro100.c
Message-ID: <20060115004315.GW29663@stusta.de>
References: <20060105181826.GD12313@stusta.de> <43BD6C03.2080605@pobox.com> <20060105210444.GA5878@xi.wantstofly.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060105210444.GA5878@xi.wantstofly.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2006 at 10:04:44PM +0100, Lennert Buytenhek wrote:
> On Thu, Jan 05, 2006 at 01:57:07PM -0500, Jeff Garzik wrote:
> 
> > >This patch removes the obsolete drivers/net/eepro100.c driver.
> > >
> > >Is there any known problem in e100 still preventing us from removing 
> > >this driver (it seems noone was able anymore to verify the ARM problem)?
> > 
> > Still waiting to see if e100 in -mm works on ARM.
> 
> e100 seems to work okay on the (modern) ARM CPUs I've tried.  The case
> where e100 failed but eepro100 worked was (I think) on older ARM hardware,
> and I'm not sure whether that kind of hardware is used anymore..

Jeff, is this enough to accept my patch?

> cheers,
> Lennert

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

