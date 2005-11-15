Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965060AbVKOWvd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965060AbVKOWvd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 17:51:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965059AbVKOWvd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 17:51:33 -0500
Received: from mail.kroah.org ([69.55.234.183]:44204 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965060AbVKOWvc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 17:51:32 -0500
Date: Tue, 15 Nov 2005 14:30:58 -0800
From: Greg KH <gregkh@suse.de>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [RFC] HOWTO do Linux kernel development - take 2
Message-ID: <20051115223057.GA12986@suse.de>
References: <20051115210459.GA11363@kroah.com> <9a8748490511151421g2eb40cebyee78a88991867ac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490511151421g2eb40cebyee78a88991867ac@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2005 at 11:21:03PM +0100, Jesper Juhl wrote:
> On 11/15/05, Greg KH <gregkh@suse.de> wrote:
> > Here's an updated version of the "HOTO do Linux kernel development"
> > document that I've been working on.
> >
> [snip]
> > Here is a list of some of the different kernel trees available:
> >   git trees:
> >     - Kbuild development tree, Sam Ravnborg <sam@ravnborg.org>
> >         kernel.org:/pub/scm/linux/kernel/git/sam/kbuild.git
> >
> >     - ACPI development tree, Len Brown <len.brown@intel.com>
> >         kernel.org:/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git
> >
> >     - Block development tree, Jens Axboe <axboe@suse.de>
> >         kernel.org:/pub/scm/linux/kernel/git/axboe/linux-2.6-block.git
> >
> >     - DRM development tree, Dave Airlie <airlied@linux.ie>
> >         kernel.org:/pub/scm/linux/kernel/git/airlied/drm-2.6.git
> >
> >     - ia64 development tree, Tony Luck <tony.luck@intel.com>
> >         kernel.org:/pub/scm/linux/kernel/git/aegl/linux-2.6.git
> >
> >     - ieee1394 development tree, Jody McIntyre <scjody@modernduck.com>
> >         kernel.org:/pub/scm/linux/kernel/git/scjody/ieee1394.git
> >
> >     - infiniband, Roland Dreier <rolandd@cisco.com>
> >         kernel.org:/pub/scm/linux/kernel/git/roland/infiniband.git
> >
> >     - libata, Jeff Garzik <jgarzik@pobox.com>
> >         kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git
> >
> >     - network drivers, Jeff Garzik <jgarzik@pobox.com>
> >         kernel.org:/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git
> >
> >     - pcmcia, Dominik Brodowski <linux@dominikbrodowski.net>
> >         kernel.org:/pub/scm/linux/kernel/git/brodo/pcmcia-2.6.git
> >
> >     - SCSI, James Bottomley <James.Bottomley@SteelEye.com>
> >         kernel.org:/pub/scm/linux/kernel/git/jejb/scsi-misc-2.6.git
> >
> 
> As I see it, this list is almost guaranteed to a) be incomplete, b) be
> outdated almost from the start, c) require often patching of your
> HOWTO to keep updated when tree locations/names change or people
> change email addr.

patches often isn't a problem, the kernel seems to handle that just fine
:)

> Wouldn't it be better to simply point to http://kernel.org/git for the list?

Hm, probably.  I'll add that also, I think it is good to point to the
real trees, as people do want to know that at times and this information
isn't listed anywhere (as evident by the ammount of digging I had to do
to find these trees...)

> And email addresses for people can be found in CREDITS & MAINTAINERS,
> why duplicate info here instead of pointing to those 2 canonical
> documents?

I'm not meaning to duplicate anything, as we don't have "location of
development git/quilt tree" entry in the MAINTAINERS file.  Hm, that
does sound like the proper place for such an entry, doesn't it?  Anyone
want to propose that addition?

thanks,

greg k-h
