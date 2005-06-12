Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262624AbVFLPMi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262624AbVFLPMi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 11:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262623AbVFLPMi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 11:12:38 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:2319 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262622AbVFLPMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 11:12:15 -0400
Date: Sun, 12 Jun 2005 17:12:07 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Armin Schindler <armin@melware.de>
Cc: Ed Tomlinson <tomlins@cam.org>, Greg K-H <greg@kroah.com>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove devfs_mk_cdev() function from the kernel tree
Message-ID: <20050612151207.GQ3770@stusta.de>
References: <11184761113499@kroah.com> <Pine.LNX.4.61.0506121042420.30907@phoenix.one.melware.de> <200506120929.03212.tomlins@cam.org> <Pine.LNX.4.61.0506121543200.15593@phoenix.one.melware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0506121543200.15593@phoenix.one.melware.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 12, 2005 at 03:51:19PM +0200, Armin Schindler wrote:
> On Sun, 12 Jun 2005, Ed Tomlinson wrote:
> > On Sunday 12 June 2005 04:44, Armin Schindler wrote:
> > > It didn't follow the development, is devfs now obsolete in kernel?
> > > If not, these funktions still makes sense.
> > > 
> > Armin,
> > 
> > From Documentation/feature-removal-schedule.txt
> > 
> > What:   devfs
> > When:   July 2005
> > Files:  fs/devfs/*, include/linux/devfs_fs*.h and assorted devfs
> >         function calls throughout the kernel tree
> > Why:    It has been unmaintained for a number of years, has unfixable
> >         races, contains a naming policy within the kernel that is
> >         against the LSB, and can be replaced by using udev.
> > Who:    Greg Kroah-Hartman <greg@kroah.com>
> > 
> > This should not a surprise to anyone...
> 
> I know the status of devfs, but I never thought the removal will be
> done in the middle of a stable line...

According to the current development model, 2.6 is a development 
kernel...

> Armin

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

