Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261524AbSK0Ds5>; Tue, 26 Nov 2002 22:48:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261518AbSK0Ds5>; Tue, 26 Nov 2002 22:48:57 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:62710 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S261529AbSK0Dsz>;
	Tue, 26 Nov 2002 22:48:55 -0500
Date: Wed, 27 Nov 2002 14:55:32 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "sean darcy" <seandarcy@hotmail.com>
Message-Id: <20021127145532.0398175c.sfr@canb.auug.org.au>
In-Reply-To: <F2708IgEO3YnDKvLVFD000016ca@hotmail.com>
References: <F2708IgEO3YnDKvLVFD000016ca@hotmail.com>
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: modutils for both redhat kernels and 2.5.x
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 26 Nov 2002 22:22:22 -0500 "sean darcy" <seandarcy@hotmail.com> wrote:
>
> OK.OK So there's no way to boot both.
> 
> FWIW, modutils-2.4.21-4 works fine with built 2.4.19 and 2.4.20-rc3 kernels. 
> While modprobe -c does give errors, all the rh scripts seem to work fine.
> 
> AND, rh's position on all this:
> 
> "You need *entirely different* modutils, not just a new modutils. We 
> probably
> won't be looking into this until the new 2.5 module loader is actually 
> finished" Bugzilla 78508
> 
> So if you want to try 2.5 kernels, make your own 2.4.x, you can't use the rh 
> kernels.

Rusty has available a source RPM just for this situation.

http://www.kernel.org/pub/linux/kernel/people/rusty/modules/modutils-2.4.21-4.src.rpm

Download this, build the rpm and install it and you will have both the new
and old available to you ...

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
