Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267219AbSLEEoS>; Wed, 4 Dec 2002 23:44:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267220AbSLEEoS>; Wed, 4 Dec 2002 23:44:18 -0500
Received: from havoc.daloft.com ([64.213.145.173]:61085 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S267219AbSLEEoR>;
	Wed, 4 Dec 2002 23:44:17 -0500
Date: Wed, 4 Dec 2002 23:51:46 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Mohamed El Ayouty <melayout@umich.edu>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [COMPILE ERROR] BK Tree rev 1.910 ide-scsi.c compile fails
Message-ID: <20021205045146.GB30035@gtf.org>
References: <1039063552.2113.37.camel@syKr0n.mine.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1039063552.2113.37.camel@syKr0n.mine.nu>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2002 at 11:45:52PM -0500, Mohamed El Ayouty wrote:
> Linux-2.5 Bitkeeper rev 1.910 
> 
> Compile Error on Scsi

Please note that "1.910" has absolutely no meaning.

If you want to give us a tree reference, look at
ftp://ftp.kernel.org/pub/linux/kernel/v2.5/snapshots/

and reference "2.5.50-bk4" or "2.5.50-bk5" or "BK-latest".


> gcc -Wp,-MD,drivers/scsi/.ide-scsi.o.d -D__KERNEL__ -Iinclude -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
> -pipe -mpreferred-stack-boundary=2 -march=i686 -Iarch/i386/mach-generic
> -fomit-frame-pointer -nostdinc -iwithprefix include   
> -DKBUILD_BASENAME=ide_scsi -DKBUILD_MODNAME=ide_scsi   -c -o
> drivers/scsi/ide-scsi.o drivers/scsi/ide-scsi.c
> drivers/scsi/ide-scsi.c: In function `should_transform':
> drivers/scsi/ide-scsi.c:767: structure has no member named `tag'

I'm pretty sure I saw a patch for this on lkml or on the commits list...

	Jeff



