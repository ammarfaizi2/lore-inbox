Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264519AbUG2M2B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264519AbUG2M2B (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 08:28:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264503AbUG2M0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 08:26:55 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:25794 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264530AbUG2MZs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 08:25:48 -0400
Date: Thu, 29 Jul 2004 14:25:43 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>
Cc: corbet@lwn.net, bgerst@didntduck.org, linux-kernel@vger.kernel.org
Subject: Re: New dev model (was [PATCH] delete devfs)
Message-ID: <20040729122542.GP2349@fs.tum.de>
References: <40FEEEBC.7080104@quark.didntduck.org> <20040721231123.13423.qmail@lwn.net> <20040721235228.GZ14733@fs.tum.de> <20040722025539.5d35c4cb.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040722025539.5d35c4cb.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2004 at 02:55:39AM -0700, Andrew Morton wrote:
> Adrian Bunk <bunk@fs.tum.de> wrote:
> >
> > Changes that remove functionally like Greg's patch are hopefully 
> > still 2.7 stuff - 2.6 is a stable kernel series and smooth upgrades 
> > inside a stable kernel series are a must for many users.
> 
> I don't necessarily agree that such changes in the userspace interface
> should be tied to the kernel version number, really.  That's a three or
> four year warning period, which is unreasonably long.  Six to twelve months
> should be long enough for udev-based replacements to stabilise and
> propagate out into distributions.
> 
> That being said, mid-2005 would be an appropriate time to remove devfs.  If
> that schedule pushes things along faster than they would otherwise have
> progressed, well, good.
>...

I'm currently wondering whether part of our discussion might be about a 
non-issue:

It's true that there's not a pressing need for opening 2.7 today.

But do you assume that this will still be true one year from now?

If 2.7 will open during the next 12 months, "mid-2005" would still be 
after 2.7 opened, and such non-urgent cleanups could then go into 2.7 .

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

