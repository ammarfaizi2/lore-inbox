Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262651AbTCIWeC>; Sun, 9 Mar 2003 17:34:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262653AbTCIWeC>; Sun, 9 Mar 2003 17:34:02 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:65178 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S262651AbTCIWeB>;
	Sun, 9 Mar 2003 17:34:01 -0500
Date: Mon, 10 Mar 2003 09:44:18 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Pavel Machek <pavel@ucw.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: sys32_ioctl -> compat_ioctl -- generic
Message-Id: <20030310094418.2eb73f8f.sfr@canb.auug.org.au>
In-Reply-To: <20030306233721.GA8565@elf.ucw.cz>
References: <20030303232122.GA24018@elf.ucw.cz>
	<20030305103619.52ccdfe2.sfr@canb.auug.org.au>
	<20030306233721.GA8565@elf.ucw.cz>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

Sorry I haven't responded earlier.  I am willing to help in
any way I can, so let me know.

On Fri, 7 Mar 2003 00:37:21 +0100 Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
> 
> > For consistancy, this should be called compat_sys_ioctl.
> 
> Done. (And moved whole stuff to fs/compat.c).

Great.

> This is andi's code, but it seems unneeded, fixed.

I assume Andi will scream if there is something subtle there :-)

> > Also, if you are adding this much code, you should add a copyright notice
> > to the top of the file ...
> 
> I actually need to copy copyrights from ia32_ioctl, where I took
> this. Done.

OK, I will have a deeper look soon.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
