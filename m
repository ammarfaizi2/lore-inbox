Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314318AbSEFJt3>; Mon, 6 May 2002 05:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314321AbSEFJt1>; Mon, 6 May 2002 05:49:27 -0400
Received: from [195.39.17.254] ([195.39.17.254]:22420 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S314318AbSEFJtX>;
	Mon, 6 May 2002 05:49:23 -0400
Date: Sat, 27 Apr 2002 01:15:34 +0000
From: Pavel Machek <pavel@suse.cz>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Tony Luck <aegl@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Virtual address space exhaustion (was  Discontigmem virt_to_page() )
Message-ID: <20020427011534.C413@toy.ucw.cz>
In-Reply-To: <20020503183701.32163.qmail@web13505.mail.yahoo.com> <Pine.LNX.3.95.1020503144728.8291A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > One of the Unix characteristics is that the kernel
> > > address space is shared with each of the process
> > > address space.
> > 
> > This hasn't been an absolute requirement. There have
> > been 32-bit Unix implementations that gave separate
> > 4G address spaces to the kernel and to each user
> > process.  The only real downside to this is that
> > copyin()/copyout() are more complex. Some processors
> > provided special instructions to access user-mode
> > addresses from kernel to mitigate this complexity.
> > 
> Really? The only 32-bit Unix's I've seen the details of
> are SCO Unix, Interactive Unix, Linux, and BSD Unix.
> The other Unix's I've become familiar are Sun-OS, the
> original AT&T(Unix System Labs)/SYS-V and DEC Ultrix.
> All these Unix's share user address-space with kernel
> address-space. This is supposed to be the very thing

Remember userspace being accessed through fs: in linux-2.0 days?

That counts as separate address space to me...
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

