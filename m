Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263752AbTKYXpX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 18:45:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263765AbTKYXpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 18:45:23 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:5867 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263752AbTKYXpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 18:45:19 -0500
Date: Wed, 26 Nov 2003 00:45:11 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Patch 3/5] dm: make v4 of the ioctl interface the default
Message-ID: <20031125234510.GG12662@fs.tum.de>
References: <20031125162451.GA524@reti> <20031125163313.GD524@reti> <3FC387A0.8010600@backtobasicsmgmt.com> <20031125170503.GG524@reti> <20031125172949.GE17907@wiggy.net> <20031125201825.B27307@uk.sistina.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031125201825.B27307@uk.sistina.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 25, 2003 at 08:18:25PM +0000, Alasdair G Kergon wrote:
> On Tue, Nov 25, 2003 at 06:29:49PM +0100, Wichert Akkerman wrote:
> > 'last few months' is extremely short for a migration path. Can't we
> > ditch the v1 interface in 2.7 and allow people to migrate slowly?
> 
> People still using LVM2/device-mapper userspace components that 
> don't support v4 really should upgrade them to fix some significant
> (unrelated) issues with those old versions.
>...

The point is IMHO a different one:

Kill the v1 interface before 2.6.0 or in 2.7 .

It's never a good idea to remove something inside a stable kernel series
(e.g. the DRI support for XFree86 4.0 will never be removed from 2.4).

> Alasdair

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

