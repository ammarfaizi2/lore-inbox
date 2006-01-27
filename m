Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932412AbWA0BMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932412AbWA0BMz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 20:12:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbWA0BMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 20:12:55 -0500
Received: from mail.kroah.org ([69.55.234.183]:40598 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932412AbWA0BMy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 20:12:54 -0500
Date: Thu, 26 Jan 2006 17:11:48 -0800
From: Greg KH <greg@kroah.com>
To: Pavel Machek <pavel@ucw.cz>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, rjw@sisk.pl,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] swsusp: userland interface (rev 2)
Message-ID: <20060127011148.GB17030@kroah.com>
References: <200601240929.37676.rjw@sisk.pl> <20060124131312.0545262d.akpm@osdl.org> <20060124213010.GA1602@elf.ucw.cz> <20060124135843.739481e7.akpm@osdl.org> <20060124221426.GB1602@elf.ucw.cz> <20060124222044.GG2449@redhat.com> <20060124223328.GC1602@elf.ucw.cz> <20060124223834.GH2449@redhat.com> <20060124224437.GA2007@elf.ucw.cz> <20060126020926.GR5501@mail>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060126020926.GR5501@mail>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2006 at 09:09:27PM -0500, Jim Crilly wrote:
> On 01/24/06 11:44:37PM +0100, Pavel Machek wrote:
> > On ?t 24-01-06 17:38:34, Dave Jones wrote:
> > >  > We'll of course try to get the interface right at the first
> > >  > try. OTOH... if wrong interface is in kernel for a month, I do not
> > >  > think it is reasonable to keep supporting that wrong interface for a
> > >  > year before it can be removed. One month of warning should be fair in
> > >  > such case...
> > > 
> > > Users want to be able to boot between different kernels.
> > > Tying functionality to specific versions of userspace completely
> > > screws them over.
> > 
> > Well, by the time we have any _users_ interface should be
> > stable. Actually I believe interface will be stable from day 0, but...
> >
> 
> I'm sure gregkh thought the same thing with about sysfs and udev and we've
> seen how well that's worked out...

Yes, I think it's worked out quite well, except for the bugs in udev
that did not anticipate kernel changes properly.  But again, those were
udev bugs, not kernel bugs.

If you have specific udev issues, that are not distro related, please
bring them up on the linux-hotplug-devel mailing list so that people can
help you out.

Or don't use udev at all, no one is forcing you :)

thanks,

greg k-h
