Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261692AbVGIS4D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261692AbVGIS4D (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 14:56:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261693AbVGIS4D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 14:56:03 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:28173 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261692AbVGIS4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 14:56:00 -0400
Date: Sat, 9 Jul 2005 20:55:57 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Ben Collins <bcollins@debian.org>
Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>,
       linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       scjody@modernduck.com
Subject: Re: [2.6 patch] drivers/ieee1394/: schedule unused EXPORT_SYMBOL's for removal
Message-ID: <20050709185557.GI28243@stusta.de>
References: <20050709030734.GD28243@stusta.de> <200507090722.j697Mcrv015292@einhorn.in-berlin.de> <20050709075035.GA20151@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050709075035.GA20151@phunnypharm.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 09, 2005 at 03:50:35AM -0400, Ben Collins wrote:

> Can we, instead of removing these, wrap then in a "Export full API" config
> option? I've already got several reports from external projects that are

This will end in all distributions having this option enabled resulting 
in no change compared to todays status quo.

> using most of these exported symbols, and I'd hate to make it harder on
> them to use our drivers (for internal projects or otherwise).

What are these external projects?

Is they are internal projects, re-adding the EXPORT_SYMBOL's should be 
trivial for them.

If they aren't only internal internal project, why can't they simply be 
merged (making all discussions about removal of the EXPORT_SYMBOL's they 
use obsolete)?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

