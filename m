Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263330AbUAYBh4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 20:37:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263228AbUAYBh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 20:37:56 -0500
Received: from mo03.iij4u.or.jp ([210.130.0.20]:2014 "EHLO mo03.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S263330AbUAYBhy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 20:37:54 -0500
Date: Sun, 25 Jan 2004 10:37:47 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: yuasa@hh.iij4u.or.jp, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.25-pre7
Message-Id: <20040125103747.4273bdca.yuasa@hh.iij4u.or.jp>
In-Reply-To: <40130D9F.3866691C@eyal.emu.id.au>
References: <Pine.LNX.4.58L.0401231652020.19820@logos.cnet>
	<40125540.A33B8AB2@eyal.emu.id.au>
	<20040125014920.54a786cc.yuasa@hh.iij4u.or.jp>
	<40130D9F.3866691C@eyal.emu.id.au>
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Jan 2004 11:28:15 +1100
Eyal Lebedinsky <eyal@eyal.emu.id.au> wrote:

> Yoichi Yuasa wrote:
> > > `/data2/usr/local/src/linux-2.4-pre/drivers/video'
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
> Is this a MIPS only file?

No,

> I run on x86 and it was selected:
> 
>    if [ "$CONFIG_PCI" = "y" -o "$CONFIG_CPU_VR41XX" = "y" ]; then
>       tristate '  ITE IT8181E/F support' CONFIG_FB_IT8181
>    fi 
> 
> Maybe we need a '-a' instead?

If you get IT8181 card, you can use on x86 with PCI.

Yoichi
