Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261670AbULIXZq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbULIXZq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 18:25:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261675AbULIXZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 18:25:46 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:8353 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261670AbULIXZj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 18:25:39 -0500
Date: Thu, 9 Dec 2004 15:25:27 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Walrond <andrew@walrond.org>
Cc: linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net
Subject: Re: [ANNOUNCE] udev 048 release
Message-ID: <20041209232527.GA6604@kroah.com>
References: <20041208185856.GA26734@kroah.com> <20041208192810.GA28374@kroah.com> <20041208194618.GA28810@kroah.com> <200412092147.14234.andrew@walrond.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412092147.14234.andrew@walrond.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2004 at 09:47:14PM +0000, Andrew Walrond wrote:
> On Wednesday 08 Dec 2004 19:46, Greg KH wrote:
> >
> > Ok, version 048 has been released to fix the build errors for the
> > extras/ directory.  It's available at
> >  kernel.org/pub/linux/utils/kernel/hotplug/udev-048.tar.gz
> >
> 
> I've built a boot cd with linux-2.6.10-rc3, udev 048 and latest hotplug.
> 
> When I boot a machine with my CD, udev doesn't create /dev/hda
> I can't fathom why. Any reasons why it wouldn't create it?

Does /sys/block/hda exist?

Did you run udevstart as part of your boot process after init happens?

thanks,

greg k-h
