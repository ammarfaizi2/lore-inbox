Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261170AbVAHN5I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbVAHN5I (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 08:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261171AbVAHN5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 08:57:08 -0500
Received: from mail.gmx.de ([213.165.64.20]:46488 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261170AbVAHN5F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 08:57:05 -0500
X-Authenticated: #1725425
Date: Sat, 8 Jan 2005 15:18:16 +0100
From: Marc Ballarin <Ballarin.Marc@gmx.de>
To: Dave Airlie <airlied@gmail.com>
Cc: bboissin@gmail.com, akpm@osdl.org, werner@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-mm2
Message-Id: <20050108151816.2a9c318f.Ballarin.Marc@gmx.de>
In-Reply-To: <21d7e99705010805424ec16550@mail.gmail.com>
References: <20050106002240.00ac4611.akpm@osdl.org>
	<40f323d005010701395a2f8d00@mail.gmail.com>
	<21d7e99705010718435695f837@mail.gmail.com>
	<40f323d00501080427f881c68@mail.gmail.com>
	<21d7e99705010805424ec16550@mail.gmail.com>
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Jan 2005 00:42:03 +1100
Dave Airlie <airlied@gmail.com> wrote:

> it looks like agp_backend_acquire is returning NULL in this case, 
> [drm:drm_ioctl] pid=10587, cmd=0x6430, nr=0x30, dev 0xe200, auth=1
> [drm:drm_ioctl] ret = ffffffed
> is the agp acquire ioctl and the return is -ENODEV 
> 
> Any ideas Mike why that might happen?

Could this be the same issue discussed and fixed in another thread?

http://marc.theaimsgroup.com/?l=linux-kernel&m=110504486230527&w=2

Regards
