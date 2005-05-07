Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263064AbVEGMic@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263064AbVEGMic (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 08:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263085AbVEGMic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 08:38:32 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:47628 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263064AbVEGMia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 08:38:30 -0400
Date: Sat, 7 May 2005 14:38:17 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Ganesh Venkatesan <ganesh.venkatesan@gmail.com>,
       ayyappan.veeraiyan@intel.com, ganesh.venkatesan@intel.com,
       john.ronciak@intel.com, jgarzik@pobox.com, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/net/ixgb/: possible cleanups
Message-ID: <20050507123814.GJ3590@stusta.de>
References: <20050506211834.GM3590@stusta.de> <5fc59ff3050506153523cd12dd@mail.gmail.com> <1115468645.6388.37.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1115468645.6388.37.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 07, 2005 at 02:24:04PM +0200, Arjan van de Ven wrote:
> On Fri, 2005-05-06 at 15:35 -0700, Ganesh Venkatesan wrote:
> > Adrian:
> > 
> > Some of your suggestions are already part of the driver we are
> > currently testing. This was based partly on your Feb '05 patch. We
> > will not be able to apply your patch as is since some of the changes
> > are in part of code that is shared with other drivers that are not
> > GPLd.
> 
> this sounds really bad.
> 
> Can you talk to the intel people in the ACPI group, they had a similar
> issue before but were able to resolve it by a proper dual license
> comment. It would be much preferable if people CAN do changes to the
> entire driver... what's the point of having it open source otherwise ;)

I'm not sure whether Ganesh was really talking about license issues, or 
whether the problem is that my patch #if 0's away code they use in other 
non-GPL'ed drivers.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

