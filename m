Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265092AbSJaB3T>; Wed, 30 Oct 2002 20:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265093AbSJaB3T>; Wed, 30 Oct 2002 20:29:19 -0500
Received: from [195.137.43.42] ([195.137.43.42]:43604 "EHLO asus.verdurin.priv")
	by vger.kernel.org with ESMTP id <S265092AbSJaB3S>;
	Wed, 30 Oct 2002 20:29:18 -0500
Date: Thu, 31 Oct 2002 01:37:25 +0000
From: Adam Huffman <bloch@verdurin.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.45
Message-ID: <20021031013724.GG2073@asus.verdurin.priv>
Mail-Followup-To: Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0210301651120.6719-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210301651120.6719-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Oct 2002, Linus Torvalds wrote:

> 
> 
> Big changes, lots of merges. A number of the merges are fairly
> substantial too. 
> 
> Device mapper (LVM2), crypto/ipsec stuff for networking, epoll and giving
> the new kernel configurator a chance. Big things.
> 
> And a _lot_ of maintenance, from various architecture updates to USB and
> ISDN and ALSA. Merges with Andrew & Alan etc.. Go out and test, 
> 
> 		Linus
> 

  gcc -Wp,-MD,drivers/md/.dm-ioctl.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=athlon -Iarch/i386/mach-generic -nostdinc -iwithprefix include
-DKBUILD_BASENAME=dm_ioctl   -c -o drivers/md/dm-ioctl.o
drivers/md/dm-ioctl.c
drivers/md/dm-ioctl.c: In function `create':
drivers/md/dm-ioctl.c:588: incompatible type for argument 1 of
`set_device_ro'
drivers/md/dm-ioctl.c: In function `reload':
drivers/md/dm-ioctl.c:874: incompatible type for argument 1 of
`set_device_ro'
make[2]: *** [drivers/md/dm-ioctl.o] Error 1
make[1]: *** [drivers/md] Error 2
make: *** [drivers] Error 2


