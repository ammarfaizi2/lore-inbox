Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263544AbUAYBp5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 20:45:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263564AbUAYBp5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 20:45:57 -0500
Received: from mo02.iij4u.or.jp ([210.130.0.19]:48101 "EHLO mo02.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S263544AbUAYBpy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 20:45:54 -0500
Date: Sun, 25 Jan 2004 10:45:48 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: yuasa@hh.iij4u.or.jp, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.25-pre7
Message-Id: <20040125104548.55dbd525.yuasa@hh.iij4u.or.jp>
In-Reply-To: <40131312.ADD37133@eyal.emu.id.au>
References: <Pine.LNX.4.58L.0401231652020.19820@logos.cnet>
	<40125540.A33B8AB2@eyal.emu.id.au>
	<20040125014920.54a786cc.yuasa@hh.iij4u.or.jp>
	<40131312.ADD37133@eyal.emu.id.au>
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Jan 2004 11:51:30 +1100
Eyal Lebedinsky <eyal@eyal.emu.id.au> wrote:

> Yoichi Yuasa wrote:
> > >
> > > There are no it8181fb.* files there.
> > 
> > This file comes from a MIPS CVS tree.
> > 
> > I have this file.
> > You can get following.
> > 
> > http://www.hh.iij4u.or.jp/~yuasa/linux-vr/v2.4/it8181fb.c
> 
> I added it and now get:
> 
> gcc -D__KERNEL__ -I/data2/usr/local/src/linux-2.4-pre/include -Wall
> -Wstrict-pro
> totypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
> -fomit-frame-pointer
>  -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4
> -DMODULE -DM
> ODVERSIONS -include
> /data2/usr/local/src/linux-2.4-pre/include/linux/modversions
> .h  -nostdinc -iwithprefix include -DKBUILD_BASENAME=it8181fb  -c -o
> it8181fb.o 
> it8181fb.c
> it8181fb.c: In function `it8181fb_init':
> it8181fb.c:1200: `PCI_DEVICE_ID_ITE_IT8181' undeclared (first use in
> this functi
> on)
> it8181fb.c:1200: (Each undeclared identifier is reported only once
> it8181fb.c:1200: for each function it appears in.)
> it8181fb.c: At top level:
> it8181fb.c:162: warning: `fontname' defined but not used
> make[2]: *** [it8181fb.o] Error 1
> make[2]: Leaving directory
> `/data2/usr/local/src/linux-2.4-pre/drivers/video'
> 
> So maybe it really is a MIPS only file (I am on x86)?

I don't know why.
When the patch was sent, the addition to a header was not sent, either.

You can see all about it8181fb's patch.

http://www.hh.iij4u.or.jp/~yuasa/linux-vr/v2.4/it8181fb-v24.diff

Yoichi
