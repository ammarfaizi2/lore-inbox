Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288994AbSBMVyA>; Wed, 13 Feb 2002 16:54:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288969AbSBMVxn>; Wed, 13 Feb 2002 16:53:43 -0500
Received: from air-2.osdl.org ([65.201.151.6]:20667 "EHLO segfault.osdlab.org")
	by vger.kernel.org with ESMTP id <S288994AbSBMVxS>;
	Wed, 13 Feb 2002 16:53:18 -0500
Date: Wed, 13 Feb 2002 13:53:38 -0800 (PST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@segfault.osdlab.org>
To: Pavel Machek <pavel@suse.cz>
cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Small notes about /proc/driver
In-Reply-To: <20020211204811.GA131@elf.ucw.cz>
Message-ID: <Pine.LNX.4.33.0202131353100.25114-100000@segfault.osdlab.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 11 Feb 2002, Pavel Machek wrote:

> Hi!
> 
> root@amd:/proc/driver/root/pci0/00:02.0# cat irq
> 11root@amd:/proc/driver/root/pci0/00:02.0#
> root@amd:/proc/driver/root/pci0/00:02.0# cat power
> 0
> root@amd:/proc/driver/root/pci0/00:02.0# cat resources
> 
> -> irq does not include newline while power does. Probably irq should
> add a newline for consistency.

Yes. Thanks.

> I briefly tested usb support in driver. You really should figure out
> some name ;-).

Name? For what?

	-pat

