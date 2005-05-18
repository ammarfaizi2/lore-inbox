Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262119AbVERHRr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262119AbVERHRr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 03:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262116AbVERHRr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 03:17:47 -0400
Received: from mail.kroah.org ([69.55.234.183]:18608 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262119AbVERHQl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 03:16:41 -0400
Date: Wed, 18 May 2005 00:22:39 -0700
From: Greg KH <greg@kroah.com>
To: Yani Ioannou <yani.ioannou@gmail.com>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH 2.6.12-rc4 1/15] (dynamic sysfs callbacks) device attribute callbacks - take 2
Message-ID: <20050518072239.GA11889@kroah.com>
References: <2538186705051703394944e949@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2538186705051703394944e949@mail.gmail.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2005 at 06:39:07AM -0400, Yani Ioannou wrote:
> Hi,
> 
> The following patches implement dynamic sysfs callbacks for
> device_attribute, and provide a possible standard sensor attribute
> macro for the majority of the i2c sensor chip/hwmon drivers. Finally a
> patch against adm1026 shows how the patch can be used to reduce the
> footprint and clean up an existing driver.

<snip>

Ok, I think I got all of these patches applied properly (hint, don't
label your intro message as 1/15, it should be 0/14, with 14 different
patches, that threw me off for a bit.)  I've also included your i2c
driver patch for the adm1026 driver only.  All of these patches are now
in my tree and can be found on kernel.org in the place where my
patchscripts notified you.  If you could verify them I would appreciate
it (I also added a few patches for stuff that was in my tree only, like
new i2c drivers and some usb and pci sysfs stuff to make them build
properly.)  All of this should show up in the next -mm release too.

Thanks a lot for sticking with this process, I really appreciate it.
Now you can get back to actually fixing up the i2c drivers you wanted
to, which was what you wanted to do in the first place :)

thanks again,

greg k-h
