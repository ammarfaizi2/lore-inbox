Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264789AbSJaJxC>; Thu, 31 Oct 2002 04:53:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264791AbSJaJxC>; Thu, 31 Oct 2002 04:53:02 -0500
Received: from cmailg4.svr.pol.co.uk ([195.92.195.174]:10762 "EHLO
	cmailg4.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S264789AbSJaJxB>; Thu, 31 Oct 2002 04:53:01 -0500
Date: Thu, 31 Oct 2002 09:59:37 +0000
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.45
Message-ID: <20021031095937.GA7487@fib011235813.fsnet.co.uk>
References: <Pine.LNX.4.44.0210301651120.6719-100000@penguin.transmeta.com> <20021031013724.GG2073@asus.verdurin.priv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021031013724.GG2073@asus.verdurin.priv>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2002 at 01:37:25AM +0000, Adam Huffman wrote:
>   gcc -Wp,-MD,drivers/md/.dm-ioctl.o.d -D__KERNEL__ -Iinclude -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
> -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
> -march=athlon -Iarch/i386/mach-generic -nostdinc -iwithprefix include
> -DKBUILD_BASENAME=dm_ioctl   -c -o drivers/md/dm-ioctl.o
> drivers/md/dm-ioctl.c
> drivers/md/dm-ioctl.c: In function `create':
> drivers/md/dm-ioctl.c:588: incompatible type for argument 1 of
> `set_device_ro'
> drivers/md/dm-ioctl.c: In function `reload':
> drivers/md/dm-ioctl.c:874: incompatible type for argument 1 of
> `set_device_ro'
> make[2]: *** [drivers/md/dm-ioctl.o] Error 1
> make[1]: *** [drivers/md] Error 2
> make: *** [drivers] Error 2

I've already posted the patches that are needed to the list.  Alternatively get them
from here:

http://people.sistina.com/~thornber/patches/2.5-stable/2.5.45-dm-1.tar.bz2

- Joe
