Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291878AbSBNUuX>; Thu, 14 Feb 2002 15:50:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291886AbSBNUuR>; Thu, 14 Feb 2002 15:50:17 -0500
Received: from smtp3.vol.cz ([195.250.128.83]:34576 "EHLO smtp3.vol.cz")
	by vger.kernel.org with ESMTP id <S291851AbSBNUuB>;
	Thu, 14 Feb 2002 15:50:01 -0500
Date: Wed, 13 Feb 2002 23:52:29 +0100
From: Pavel Machek <pavel@suse.cz>
To: Patrick Mochel <mochel@osdl.org>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Small notes about /proc/driver
Message-ID: <20020213225227.GJ1454@elf.ucw.cz>
In-Reply-To: <20020211204811.GA131@elf.ucw.cz> <Pine.LNX.4.33.0202131353100.25114-100000@segfault.osdlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0202131353100.25114-100000@segfault.osdlab.org>
User-Agent: Mutt/1.3.25i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > root@amd:/proc/driver/root/pci0/00:02.0# cat irq
> > 11root@amd:/proc/driver/root/pci0/00:02.0#
> > root@amd:/proc/driver/root/pci0/00:02.0# cat power
> > 0
> > root@amd:/proc/driver/root/pci0/00:02.0# cat resources
> > 
> > -> irq does not include newline while power does. Probably irq should
> > add a newline for consistency.
> 
> Yes. Thanks.
> 
> > I briefly tested usb support in driver. You really should figure out
> > some name ;-).
> 
> Name? For what?

That was joke. If you cat usb/something/name, it says 

"Should figure out some name"

. It really needs to be replaced with some better name.
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
