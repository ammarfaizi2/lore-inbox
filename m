Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265828AbUATVfO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 16:35:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265838AbUATVfO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 16:35:14 -0500
Received: from fw.osdl.org ([65.172.181.6]:63618 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265828AbUATVfG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 16:35:06 -0500
Date: Tue, 20 Jan 2004 13:30:57 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: arvidjaar@mail.ru, linux-kernel@vger.kernel.org
Subject: Re: Can't boot 2.6.1-mm4 or -mm5
Message-Id: <20040120133057.0437e73f.rddunlap@osdl.org>
In-Reply-To: <20040120111554.723145eb.akpm@osdl.org>
References: <200401202145.06005.arvidjaar@mail.ru>
	<20040120111554.723145eb.akpm@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jan 2004 11:15:54 -0800 Andrew Morton <akpm@osdl.org> wrote:

| Andrey Borzenkov <arvidjaar@mail.ru> wrote:
| >
| > I can't boot either of them. 2.6.1-mm3 was OK; compiling and booting -mm4 or 
| > -mm5 with the same config as before (since 2.5.69 actually). Compiling and 
| > booting with VESA framebuffer and vga=788 gives empty screen; booting with 
| > vga=normal or compiling without framebuffer support goes as far as
| > 
| > Uncompressing kernel ... booting
| > 
| > and that is all. No disk activity either so it seems to have just stopped.
| 
| Don't know, sorry.  Does anyone have a slightly-sane early printk patch
| handy?

There's one in here:

ftp://ftp.kernel.org/pub/linux/kernel/people/mbligh/2.6.1/patch-2.6.1-mjb1.bz2

| > 
| > {pts/0}% gcc --version
| > gcc-3.3.1 (GCC) 3.3.1 (Mandrake Linux 9.2 3.3.1-2mdk)
| > Copyright (C) 2003 Free Software Foundation, Inc.
| > This is free software; see the source for copying conditions.  There is NO
| > warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
| > 
| > system is ASUS CUSL2, i815 chipset, GeForce2 MX videocard. lspci on 2.6.0 
| > follows; config for -mm5 is attached. It was produced by using config from 
| > -mm3, running make oldconfig and answering N to most new questions. It is 
| > possible that there is problem with new CPU selection but I alaways compiled 
| > with PentiumIII only before.
| 
| I'd try enabling more CPU types, see what that does.  You have SMP enabled,
| but that should be OK.


--
~Randy
kernel-janitors project:  http://janitor.kernelnewbies.org/
