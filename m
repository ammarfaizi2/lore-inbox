Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751364AbVLESvN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbVLESvN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 13:51:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbVLESvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 13:51:13 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:34834 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751364AbVLESvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 13:51:11 -0500
Date: Mon, 5 Dec 2005 19:51:10 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Message-ID: <20051205185110.GJ9973@stusta.de>
References: <20051203135608.GJ31395@stusta.de> <9a8748490512030629t16d0b9ebv279064245743e001@mail.gmail.com> <20051203201945.GA4182@kroah.com> <9a8748490512031948m26b04d3ds9fbc652893ead40@mail.gmail.com> <20051204115650.GA15577@merlin.emma.line.org> <20051204232454.GG8914@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051204232454.GG8914@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 04, 2005 at 03:24:54PM -0800, Greg KH wrote:
> On Sun, Dec 04, 2005 at 12:56:50PM +0100, Matthias Andree wrote:
> > The problem is the upstream breaking backwards compatibility for no good
> > reason. This can sometimes be a genuine unintended regression (aka.
> > bug), but quite often this is deliberate breakage because someone wants
> > to get rid of cruft. While the motivation is sound, breaking between
> > 2.6.N and 2.6.M must stop.
> 
> What are we breaking that people are complaining so much about?
> Specifics please.
> 
> And if you bring up udev, please see my previous comments in this thread
> about that issue.
> 
> It isn't userspace stuff that is breaking, as applications built on 2.2
> still work just fine here on 2.6 for me.
> 
> Yes we break in-kernel apis, all the time, that's fine.  See
> Documentation/stable-api-nonsense.txt for details about why we do that.
> 
> So again, specifics please?

It's the kernel-related userspace that is the problem (besides 
regressions that are simply bugs).

Be it the devfs removal, the requirement for a more recent
wpa_supplicant package or my pending removal of the obsolete
raw driver.

> thanks,
> 
> greg k-h

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

