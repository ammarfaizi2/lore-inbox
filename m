Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264690AbTANQLl>; Tue, 14 Jan 2003 11:11:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264697AbTANQLk>; Tue, 14 Jan 2003 11:11:40 -0500
Received: from air-2.osdl.org ([65.172.181.6]:16015 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S264690AbTANQLk>;
	Tue, 14 Jan 2003 11:11:40 -0500
Date: Tue, 14 Jan 2003 09:19:10 -0600 (CST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: ----- <grundig@teleline.es>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.56 lib/kobject.c "badness" (ppp bug?)
In-Reply-To: <20030111201306.7513bc7e.grundig@teleline.es>
Message-ID: <Pine.LNX.4.33.0301140917550.1025-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 11 Jan 2003, ----- wrote:

> while connected at inet:
> 
> Jan 11 17:44:01 estel kernel: Badness in kobject_register at lib/kobject.c:129
> Jan 11 17:44:01 estel kernel: Call Trace:
> Jan 11 17:44:01 estel kernel:  [kobject_register+88/112] kobject_register+0x58/0x70
> Jan 11 17:44:01 estel kernel:  [register_netdevice+447/496] register_netdevice+0x1bf/0x1f0
> Jan 11 17:44:01 estel kernel:  [<d0873893>] ppp_create_interface+0x163/0x2f78c8d0 [ppp_generic]
> Jan 11 17:44:01 estel kernel:  [<d0874d01>] +0x9d/0x2f78b39c [ppp_generic]
> Jan 11 17:44:01 estel kernel:  [<d0870d8a>] ppp_unattached_ioctl+0x15a/0x2f78f3d0 [ppp_generic]
> Jan 11 17:44:01 estel kernel:  [<d0870c2b>] ppp_ioctl+0x78b/0x2f78fb60 [ppp_generic]
> Jan 11 17:44:01 estel kernel:  [cache_free_debugcheck+393/592] cache_free_debugcheck+0x189/0x250
> Jan 11 17:44:01 estel kernel:  [sys_ioctl+349/733] sys_ioctl+0x15d/0x2dd
> Jan 11 17:44:01 estel kernel:  [syscall_call+7/11] syscall_call+0x7/0xb

Sorry for the delay in replying..This is fixed as of 2.5.57. Please update 
your kernel and try again.

Thanks,

	-pat

