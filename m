Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161066AbVLJXh7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161066AbVLJXh7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 18:37:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161067AbVLJXh7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 18:37:59 -0500
Received: from mail.kroah.org ([69.55.234.183]:47044 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161066AbVLJXh6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 18:37:58 -0500
Date: Sat, 10 Dec 2005 15:36:55 -0800
From: Greg KH <greg@kroah.com>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc5-mm1
Message-ID: <20051210233655.GH11094@kroah.com>
References: <20051204232153.258cd554.akpm@osdl.org> <20051206000524.74cb2ddc@werewolf.auna.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051206000524.74cb2ddc@werewolf.auna.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2005 at 12:05:24AM +0100, J.A. Magallon wrote:
> On Sun, 4 Dec 2005 23:21:53 -0800, Andrew Morton <akpm@osdl.org> wrote:
> 
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc5/2.6.15-rc5-mm1/
> > 
> > 
> 
> I still get this oops on boot, then the machine freezes hard on the init
> process:
> 
> usb_set_configuration+0x22b/0x4df
> usb_new_device+0x105/0x158
> hub_port_connect_change+0x2de/0x37e
> clear_port_feature+0x48/0x4d
> hub_events+0x2aa/0x42f
> hub_thread+0x14/0xe2
> autoremove_wake_function+0x0/0x37
> kthread+0x93/0x97
> kthread+0x0/0x97
> kernel_thread_helper+0x5/0xb
> 
> udevd-event[694]: run_program: exec of program '/etc/udev/agents.d/usb/usbcore'
> failed.
> 
> I have udev-075, plain 2.6.15-rc5-mm1 + devfs-die + low1Gbmem.
> 
> Any ideas ?

Do you have the same problem with 2.6.15-rc5?

What is in /etc/udev/agents.d/usb/usbcore?
What distro is this?
What kind of usb devices do you have attached?

thanks,

greg k-h
