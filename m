Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264788AbSJaIwk>; Thu, 31 Oct 2002 03:52:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264791AbSJaIwk>; Thu, 31 Oct 2002 03:52:40 -0500
Received: from mail.michigannet.com ([208.49.116.30]:1042 "EHLO
	member.michigannet.com") by vger.kernel.org with ESMTP
	id <S264788AbSJaIwi>; Thu, 31 Oct 2002 03:52:38 -0500
Date: Thu, 31 Oct 2002 03:58:56 -0500
From: Paul <set@pobox.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.45
Message-ID: <20021031085856.GF7170@squish.home.loc>
Mail-Followup-To: Paul <set@pobox.com>,
	Jeff Garzik <jgarzik@pobox.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0210301651120.6719-100000@penguin.transmeta.com> <20021031013724.GG2073@asus.verdurin.priv> <3DC08C37.6060909@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DC08C37.6060909@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com>, on Wed Oct 30, 2002 [08:49:43 PM] said:
> Adam Huffman wrote:
> 
> > gcc -Wp,-MD,drivers/md/.dm-ioctl.o.d -D__KERNEL__ -Iinclude -Wall
> >-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
> >-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
> >-march=athlon -Iarch/i386/mach-generic -nostdinc -iwithprefix include
> >-DKBUILD_BASENAME=dm_ioctl   -c -o drivers/md/dm-ioctl.o
> >drivers/md/dm-ioctl.c
> >drivers/md/dm-ioctl.c: In function `create':
> >drivers/md/dm-ioctl.c:588: incompatible type for argument 1 of
> >`set_device_ro'
> >drivers/md/dm-ioctl.c: In function `reload':
> >drivers/md/dm-ioctl.c:874: incompatible type for argument 1 of
> >`set_device_ro'
> >make[2]: *** [drivers/md/dm-ioctl.o] Error 1
> >make[1]: *** [drivers/md] Error 2
> >make: *** [drivers] Error 2
> > 
> >
> 
> 
> yeah, don't use it for now, it needs more cleanups.
> 
> 
	Hi;

	I need lvm to test this kernel series. I am not using
md stuff, but this is where it breaks for me too. If there
are corrective patches, please let us know...

Paul
set@pobox.com
