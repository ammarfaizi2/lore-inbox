Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266968AbUAXQtg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 11:49:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266970AbUAXQtf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 11:49:35 -0500
Received: from mo02.iij4u.or.jp ([210.130.0.19]:27615 "EHLO mo02.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S266968AbUAXQtd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 11:49:33 -0500
Date: Sun, 25 Jan 2004 01:49:20 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: yuasa@hh.iij4u.or.jp, marcelo.tosatti@cyclades.com,
       linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: Linux 2.4.25-pre7
Message-Id: <20040125014920.54a786cc.yuasa@hh.iij4u.or.jp>
In-Reply-To: <40125540.A33B8AB2@eyal.emu.id.au>
References: <Pine.LNX.4.58L.0401231652020.19820@logos.cnet>
	<40125540.A33B8AB2@eyal.emu.id.au>
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 24 Jan 2004 22:21:36 +1100
Eyal Lebedinsky <eyal@eyal.emu.id.au> wrote:

> Marcelo Tosatti wrote:
> > Here goes -pre number 7 of 2.4.25 series.
> 
> cp aty128fb.o clgenfb.o cyber2000fb.o fbcon-afb.o fbcon-cfb16.o
> fbcon-cfb2.o fbc
> on-cfb24.o fbcon-cfb32.o fbcon-cfb4.o fbcon-cfb8.o fbcon-hga.o
> fbcon-ilbm.o fbco
> n-iplan2p2.o fbcon-iplan2p4.o fbcon-iplan2p8.o fbcon-mac.o fbcon-mfb.o
> fbcon-vga
> -planes.o fbcon-vga.o fbgen.o hgafb.o it8181fb.o mdacon.o neofb.o
> pm2fb.o pm3fb.
> o radeonfb.o sstfb.o tdfxfb.o tridentfb.o vfb.o vga16fb.o
> /lib/modules/2.4.25-pr
> e7/kernel/drivers/video/
> cp: cannot stat `it8181fb.o': No such file or directory
> make[2]: *** [_modinst__] Error 1
> make[2]: Leaving directory
> `/data2/usr/local/src/linux-2.4-pre/drivers/video'
> 
> There are no it8181fb.* files there.

This file comes from a MIPS CVS tree.

I have this file.
You can get following.

http://www.hh.iij4u.or.jp/~yuasa/linux-vr/v2.4/it8181fb.c

Marcelo,
Please add this file to next pre.

Thanks,

Yoichi
