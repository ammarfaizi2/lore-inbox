Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262426AbVCMACL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262426AbVCMACL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 19:02:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262545AbVCMACL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 19:02:11 -0500
Received: from mail.kroah.org ([69.55.234.183]:8616 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262426AbVCMACE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 19:02:04 -0500
Date: Sat, 12 Mar 2005 12:34:15 -0800
From: Greg KH <greg@kroah.com>
To: Stefan Rompf <stefan@loplof.de>
Cc: Felix von Leitner <felix-linuxkernel@fefe.de>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.11: USB broken on nforce4, ipv6 still broken, centrino speedstep even more broken than in 2.6.10
Message-ID: <20050312203415.GB11865@kroah.com>
References: <200503121124.17295.stefan@loplof.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503121124.17295.stefan@loplof.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 12, 2005 at 11:24:16AM +0100, Stefan Rompf wrote:
> Hi,
> 
> Felix von Leitner wrote:
> 
> > Did I mention that I'm really tired of you putting stones into ATI's
> > way?  You might believe you have a right to piss everyone off, after all
> > people get what they paid for.  Or maybe you think you are on a crusade
> > to promote open source software.  But if you keep alienating me (I'm a
> > software developer) like this, I spend more time working around this
> > bullshit and less time writing free software.  In the end, everyone
> > loses.  I sincerely hope some day you people are done pissing in the
> > pool and can create at least some semblance of semi-stable APIs.  This
> > house is never going to be safe for living until you stop digging around
> > the foundation.
> 
> I cannot agree more. Many developers and maintainers say they don't care about 
> binary modules - but I do have the impression a few of them care a lot by 
> doing changes in a way that they break the current NVIDIA drivers on every 
> new kernel release.

Oh no, our secret is out!  :)

> As I read now, it seems to be the same way with ATI. Even GPL drivers
> developed outside the kernel are disfigured over and over with #ifdefs
> on KERNEL_VERSION.

Then get those GPL drivers into the kernel tree, and that will not be
needed at all.

> While I fully understand that no developer wants to support binary modules, I 
> would appreciate a little less hostile behaviour. And btw., instable API 
> leads to an instable kernel because not everyone can follow the changes.

Please read Documentation/stable_api_nonesense.txt for more info on
exactly _why_ the kernel changes like this.

thanks,

greg k-h
