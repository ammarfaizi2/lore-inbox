Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265876AbUA1JJO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 04:09:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265879AbUA1JJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 04:09:14 -0500
Received: from f9.mail.ru ([194.67.57.39]:43271 "EHLO f9.mail.ru")
	by vger.kernel.org with ESMTP id S265876AbUA1JJK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 04:09:10 -0500
From: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	<arvidjaar@mail.ru>
To: =?koi8-r?Q?=22?=Andrew Morton=?koi8-r?Q?=22=20?= <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Can't boot 2.6.1-mm4 or -mm5
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [212.248.25.26]
Date: Wed, 28 Jan 2004 12:09:09 +0300
In-Reply-To: <20040120111554.723145eb.akpm@osdl.org>
Reply-To: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	  <arvidjaar@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E1Allh7-000DSK-00.arvidjaar-mail-ru@f9.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----

> 
> Andrey Borzenkov <arvidjaar@mail.ru> wrote:
> >
> > I can't boot either of them. 2.6.1-mm3 was OK; compiling and booting -mm4 or 
> > -mm5 with the same config as before (since 2.5.69 actually). Compiling and 
> > booting with VESA framebuffer and vga=788 gives empty screen; booting with 
> > vga=normal or compiling without framebuffer support goes as far as
> > 
> > Uncompressing kernel ... booting
> > 
> > and that is all. No disk activity either so it seems to have just stopped.
> 
> Don't know, sorry.  Does anyone have a slightly-sane early printk patch
> handy?
> 

this was -funit-at-a-time. Removing it (with all other conditions
equal) fixes boot problem. I informed Mandrake.

See also

<http://marc.theaimsgroup.com/?t=107492024800001&r=1&w=2>

and

<http://marc.theaimsgroup.com/?t=107505102400001&r=1&w=2&n=50>

regards

-andrey

> > 
> > {pts/0}% gcc --version
> > gcc-3.3.1 (GCC) 3.3.1 (Mandrake Linux 9.2 3.3.1-2mdk)
> > Copyright (C) 2003 Free Software Foundation, Inc.
> > This is free software; see the source for copying conditions.  There is NO
> > warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> > 
> > system is ASUS CUSL2, i815 chipset, GeForce2 MX videocard. lspci on 2.6.0 
> > follows; config for -mm5 is attached. It was produced by using config from 
> > -mm3, running make oldconfig and answering N to most new questions. It is 
> > possible that there is problem with new CPU selection but I alaways compiled 
> > with PentiumIII only before.
> 
> I'd try enabling more CPU types, see what that does.  You have SMP enabled,
> but that should be OK.
> 
> 
