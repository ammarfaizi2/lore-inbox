Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751341AbVKAWOU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbVKAWOU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 17:14:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbVKAWOU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 17:14:20 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:55816 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751341AbVKAWOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 17:14:19 -0500
Date: Tue, 1 Nov 2005 22:14:11 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: Pavel Machek <pavel@ucw.cz>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Make spitz compile again
Message-ID: <20051101221410.GA21034@flint.arm.linux.org.uk>
Mail-Followup-To: Richard Purdie <rpurdie@rpsys.net>,
	Pavel Machek <pavel@ucw.cz>, LKML <linux-kernel@vger.kernel.org>
References: <20051031134255.GA8093@elf.ucw.cz> <1130773530.8353.39.camel@localhost.localdomain> <20051101200516.GA7172@elf.ucw.cz> <1130881612.8489.33.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1130881612.8489.33.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2005 at 09:46:52PM +0000, Richard Purdie wrote:
> On Tue, 2005-11-01 at 21:05 +0100, Pavel Machek wrote:
> > Hi!
> > 
> > > > This is what I needed to do after update to latest linus
> > > > kernel. Perhaps it helps someone. 
> > > > 
> > > > Signed-off-by: Pavel Machek <pavel@suse.cz>
> > > > 
> > > > , but it is against Richard's tree merged into my tree, so do not
> > > > expect to apply it over mainline. Akita code movement is needed if I
> > > > want to compile kernel without akita support...
> > > 
> > > This is an update of my tree against 2.6.14-git3:
> > > 
> > > http://www.rpsys.net/openzaurus/temp/total-2.6.14-git3-r0.patch.gz
> > 
> > I did compile fixing, but it still will not boot. With neither my
> > config, not with yours. Just blank screen. Any ideas?
> > 
> > > http://www.rpsys.net/openzaurus/temp/total-2.6.14-git3-r0-defconfig-cxx00
> 
> I've worked out a patch to revert the change that broke things for c7x0:
> 
> http://www.rpsys.net/openzaurus/patches/revert_bootmem-r0.patch
> 
> I'd be interested to know if this helps your spitz kernel as its gets
> c7x0 working again. Obviously the next step is to work out why this
> breaks things but reverting it gets my Zaurus dev tree working again
> which stops users c7x0 complaining :)

You need to at least follow my suggestion in order to move forward on
this.  You're the only ones seeing a problem so far.

Maybe when other folk try it out some pattern will emerge.

Shame this couldn't have been done a month ago though when I wrote the
patch and it was fresh in my mind.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
