Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265099AbSJaBns>; Wed, 30 Oct 2002 20:43:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265100AbSJaBns>; Wed, 30 Oct 2002 20:43:48 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:16907 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S265099AbSJaBnr>;
	Wed, 30 Oct 2002 20:43:47 -0500
Message-ID: <3DC08C37.6060909@pobox.com>
Date: Wed, 30 Oct 2002 20:49:43 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adam Huffman <bloch@verdurin.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.45
References: <Pine.LNX.4.44.0210301651120.6719-100000@penguin.transmeta.com> <20021031013724.GG2073@asus.verdurin.priv>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Huffman wrote:

>  gcc -Wp,-MD,drivers/md/.dm-ioctl.o.d -D__KERNEL__ -Iinclude -Wall
>-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
>-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
>-march=athlon -Iarch/i386/mach-generic -nostdinc -iwithprefix include
>-DKBUILD_BASENAME=dm_ioctl   -c -o drivers/md/dm-ioctl.o
>drivers/md/dm-ioctl.c
>drivers/md/dm-ioctl.c: In function `create':
>drivers/md/dm-ioctl.c:588: incompatible type for argument 1 of
>`set_device_ro'
>drivers/md/dm-ioctl.c: In function `reload':
>drivers/md/dm-ioctl.c:874: incompatible type for argument 1 of
>`set_device_ro'
>make[2]: *** [drivers/md/dm-ioctl.o] Error 1
>make[1]: *** [drivers/md] Error 2
>make: *** [drivers] Error 2
>  
>


yeah, don't use it for now, it needs more cleanups.


