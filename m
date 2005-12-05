Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751490AbVLEXGi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490AbVLEXGi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 18:06:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751494AbVLEXGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 18:06:38 -0500
Received: from xenotime.net ([66.160.160.81]:38305 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751490AbVLEXGh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 18:06:37 -0500
Date: Mon, 5 Dec 2005 15:06:30 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: "J.A. Magallon" <jamagallon@able.es>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.6.15-rc5-mm1
In-Reply-To: <20051206000524.74cb2ddc@werewolf.auna.net>
Message-ID: <Pine.LNX.4.58.0512051505430.5345@shark.he.net>
References: <20051204232153.258cd554.akpm@osdl.org> <20051206000524.74cb2ddc@werewolf.auna.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

copy linux-usb-devel list...

On Tue, 6 Dec 2005, J.A. Magallon wrote:

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
>
> --
> J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
> werewolf!able!es                         \         It's better when it's free
> Mandriva Linux release 2006.1 (Cooker) for i586
> Linux 2.6.14-jam3 (gcc 4.0.2 (4.0.2-1mdk for Mandriva Linux release 2006.1))
>

-- 
~Randy
