Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265457AbRF1A2w>; Wed, 27 Jun 2001 20:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265459AbRF1A2n>; Wed, 27 Jun 2001 20:28:43 -0400
Received: from altus.drgw.net ([209.234.73.40]:49930 "EHLO altus.drgw.net")
	by vger.kernel.org with ESMTP id <S265457AbRF1A2c>;
	Wed, 27 Jun 2001 20:28:32 -0400
Date: Wed, 27 Jun 2001 19:27:13 -0500
From: Troy Benjegerdes <hozer@drgw.net>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: Pavel Machek <pavel@suse.cz>, Rik van Riel <riel@conectiva.com.br>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: spindown
Message-ID: <20010627192713.K8027@altus.drgw.net>
In-Reply-To: <20010615152306.B37@toy.ucw.cz> <20010618222131.A26018@paranoidfreak.co.uk> <20010619124627.A202@bug.ucw.cz> <20010621180701.B4523@pcep-jamie.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010621180701.B4523@pcep-jamie.cern.ch>; from lk@tantalophile.demon.co.uk on Thu, Jun 21, 2001 at 06:07:01PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2001 at 06:07:01PM +0200, Jamie Lokier wrote:
> Pavel Machek wrote:
> > > Isn't this why noflushd exists or is this an evil thing that shouldn't
> > > ever be used and will eventually eat my disks for breakfast?
> > 
> > It would eat your flash for breakfast. You know, flash memories have
> > no spinning parts, so there's nothing to spin down.
> 
> Btw Pavel, does noflushd work with 2.4.4?  The noflushd version 2.4 I
> tried said it couldn't find some kernel process (kflushd?  I don't
> remember) and that I should use bdflush.  The manual says that's
> appropriate for older kernels, but not 2.4.4 surely.

Yes, noflushd works with 2.4.x. I'm running it on an ibook with 
debian-unstable.

And as a word of warning: while running noflushd, make sure you 'sync' a 
few times after an 'apt-get dist-upgrade' that upgrades damn near 
everything before doing something that crashes the kernel. This WILL eat 
your ext2fs for breakfast.

-- 
Troy Benjegerdes | master of mispeeling | 'da hozer' |  hozer@drgw.net
-----"If this message isn't misspelled, I didn't write it" -- Me -----
"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's 
why I draw cartoons. It's my life." -- Charles Shulz
