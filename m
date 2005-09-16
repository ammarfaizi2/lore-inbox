Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750711AbVIPV55@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbVIPV55 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 17:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750709AbVIPV5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 17:57:53 -0400
Received: from mail.kroah.org ([69.55.234.183]:40845 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750711AbVIPV52 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 17:57:28 -0400
Date: Fri, 16 Sep 2005 14:30:04 -0700
From: Greg KH <greg@kroah.com>
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: Jiri Slaby <jirislaby@gmail.com>, Dominik Karall <dominik.karall@gmx.net>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc1-mm1
Message-ID: <20050916213003.GB13604@kroah.com>
References: <20050916022319.12bf53f3.akpm@osdl.org> <200509162042.07376.dominik.karall@gmx.net> <432B2101.9080806@gmail.com> <20050916195903.GE22221@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050916195903.GE22221@vrfy.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2005 at 09:59:03PM +0200, Kay Sievers wrote:
> On Fri, Sep 16, 2005 at 09:46:09PM +0200, Jiri Slaby wrote:
> > Dominik Karall napsal(a):
> > 
> > >On Friday 16 September 2005 11:23, Andrew Morton wrote:
> > > 
> > >
> > >>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc1/2.
> > >>6.14-rc1-mm1/ (temp copy at
> > >>http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.14-rc1-mm1.gz)
> > >>   
> > >>
> > >
> > >I don't get a /dev/input/mice device with this kernel, so Xorg reports 
> > >following error (udev 070 in use):
> > > 
> > >
> > [snip]
> > 
> > I have the same problem. Version 2.6.13-mm3 was OK and the new version 
> > was only oldconfigured. When I create appropriate devices with mknod, it 
> > is ok. So why does not udev (58 and 70) create that devices (event, 
> > mice, mouse, wacom)?
> 
> There is no userspace support(udev, libsysfs, HAL) for the experimental
> sysfs layout of the input layer patches. We better remove them until we
> all can agree on a sane layout. I don't expect it will make it into the
> kernel it its current form.

Yes, Andrew, can you please drop these patches, they will cause lots of
problems with users due to the above mentioned issues.

thanks,

greg k-h
