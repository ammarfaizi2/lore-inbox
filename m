Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268997AbRHFUQY>; Mon, 6 Aug 2001 16:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268992AbRHFUQO>; Mon, 6 Aug 2001 16:16:14 -0400
Received: from ns1.uklinux.net ([212.1.130.11]:1549 "EHLO s1.uklinux.net")
	by vger.kernel.org with ESMTP id <S268997AbRHFUQH>;
	Mon, 6 Aug 2001 16:16:07 -0400
Envelope-To: linux-kernel@vger.kernel.org
Date: Mon, 6 Aug 2001 21:16:40 +0100 (BST)
From: Ken Moffat <ken@kenmoffat.uklinux.net>
To: Alexander Viro <viro@math.psu.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [CFT] initramfs patch (2.4.8-pre3)
In-Reply-To: <Pine.GSO.4.21.0108051640360.12846-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.21.0108062113560.2883-100000@pppg_penguin.linux.bogus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, Al. It booted nicely this time. Your last line sounds good to me,
but you shouldn't pay too much regard to an un-evolved simian like me.

Cheers, Ken

On Sun, 5 Aug 2001, Alexander Viro wrote:

> 
> 
> On Sun, 5 Aug 2001, Ken Moffat wrote:
> 
> > Small problem, though
> > 
> > request_module[ramfs]: Root fs not mounted
> > Kernel panic. Can't create rootfs
> > 
> > Obviously I've not been paying attention. I ran "make oldconfig" and
> > didn't see any new options that were needed, so I didn't consider altering
> > my current config settings. Which one is it I need, please ? 
> 
> RAMFS ;-) Actually, I probably ought to replace tristate ... CONFIG_RAMFS
> with define_bool CONFIG_RAMFS y in fs/Config.in.
> 

-- 
   Never drink more than two pangalacticgargleblasters !
Home page : http://www.kenmoffat.uklinux.net

