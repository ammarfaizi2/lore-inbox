Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262322AbSI1Uho>; Sat, 28 Sep 2002 16:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262325AbSI1Uho>; Sat, 28 Sep 2002 16:37:44 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:16615 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S262322AbSI1Uhn>; Sat, 28 Sep 2002 16:37:43 -0400
Date: Sat, 28 Sep 2002 22:42:58 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: ebuddington@wesleyan.edu, Alexander Viro <viro@math.psu.edu>
cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: 2.5.37: hd.c: `hd_gendisk' undeclared in `hd_request'
In-Reply-To: <20020920235521.A32621@ma-northadams1b-39.bur.adelphia.net>
Message-ID: <Pine.NEB.4.44.0209282238550.18211-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Sep 2002, Eric Buddington wrote:

> With the kernel configured with 'make allmodconfig' and essentials
> set to Y (IDE disks, SCSI CDROM, keyboard), and processor set to PII,
> I get the following error from 'make bzImage':
>
> --------------------------------
> hd.c: In function `hd_request':
> hd.c:593: `hd_gendisk' undeclared (first use in this function)
> hd.c:593: (Each undeclared identifier is reported only once
> hd.c:593: for each function it appears in.)
> hd.c:594: `unit' undeclared (first use in this function)
> hd.c: At top level:
> hd.c:694: `hd_gendisk' used prior to declaration
> make[3]: *** [hd.o] Error 1
> make[3]: Leaving directory `/packages/linux/2.5.37/any/src/linux-2.5.37/drivers/ide/legacy'
> --------------------------------
>
> This is probably a config option I don't actually need, but I thought
> it worth noting.


This problem is still present in 2.5.39. It seems to be a result of Al's
gendisk changes.


> -Eric

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

