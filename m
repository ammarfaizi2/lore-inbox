Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265783AbUEZTzz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265783AbUEZTzz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 15:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265784AbUEZTzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 15:55:55 -0400
Received: from mail.kroah.org ([65.200.24.183]:35246 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265783AbUEZTzx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 15:55:53 -0400
Date: Wed, 26 May 2004 12:55:06 -0700
From: Greg KH <greg@kroah.com>
To: Zenaan Harkness <zen@freedbms.net>
Cc: linux-kernel@vger.kernel.org, debian-devel@lists.debian.org
Subject: Re: [Fwd: Re: drivers DB and id/ info registration]
Message-ID: <20040526195505.GB2588@kroah.com>
References: <1085548092.2909.60.camel@zen8100a.freedbms.net> <20040526182919.GA25978@kroah.com> <1085600051.2468.17.camel@zen8100a.freedbms.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1085600051.2468.17.camel@zen8100a.freedbms.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2004 at 05:34:11AM +1000, Zenaan Harkness wrote:
> If, when I plug in my widget, I get a dialog saying "Your Funky Widget
> X has been detected but has no driver, <click here> to send an email
> requesting support."

The kernel already spits out this information, it's up to userspace
tools to recognize it and create such a dialog if needed.  See the HAL
project for one such tool that is activly working on this.

The hotplug package already will automatically load drivers for new
devices, so that portion of what you are looking for is completed.

> it is reassuring to me that my "OS" recognizes the
> device, it is easy for me to see that there is currently no driver
> (saves me googling for how long?) and makes it easy to register my
> interest in getting support. Registration might go via this centralized
> repository then to the company, for tracking.
> 
> So of course, the question is how many companies will submit only
> device identification information?

See all of the different companies that today submit their info to the
pci sf.net site you linked to for that kind of information.

Remember, an id by itself is pointless.  We need specs and drivers that
work for those specs.  You should concentrate on that goal instead of
worrying about ids.

> Perhaps users can submit some, and surely at least _some_ companies,
> and/ or their employees, will do so too.
> 
> Still pointless?

As we are going to rip the pci.ids file out of the 2.7 kernel tree,
pretty much so :)

thanks,

greg k-h
