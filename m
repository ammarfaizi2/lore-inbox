Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263047AbVFWKGa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263047AbVFWKGa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 06:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263048AbVFWKFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 06:05:34 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:29959 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262398AbVFWJxu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 05:53:50 -0400
Date: Thu, 23 Jun 2005 11:53:42 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Nick Warne <nick@linicks.net>
Cc: linux-kernel@vger.kernel.org, George Kasica <georgek@netwrx1.com>
Subject: Re: Problem compiling 2.6.12
Message-ID: <20050623095342.GD3749@stusta.de>
References: <200506222037.17738.nick@linicks.net> <20050622213038.GA3749@stusta.de> <200506222253.47777.nick@linicks.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506222253.47777.nick@linicks.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2005 at 10:53:47PM +0100, Nick Warne wrote:
> On Wednesday 22 June 2005 22:30, Adrian Bunk wrote:
> > On Wed, Jun 22, 2005 at 08:37:17PM +0100, Nick Warne wrote:
> > > George Kasica wrote:
> > > > Tried that here and got not much farther...here's the error:
> > > >
> > > > [root@eagle linux]# make bzImage
> > > >    CHK     include/linux/version.h
> > > >    SPLIT   include/linux/autoconf.h -> include/config/*
> > > >    HOSTCC  scripts/mod/sumversion.o
> > > > In file included from /usr/include/linux/errno.h:4,
> > >
> > > That last line looks wrong...  I think you may have symlinks linking to
> > > other older kernel header stuff.
> > >...
> >
> > No, it looks correct.
> >
> > That's the copy of linux/errno.h shipped with glibc and that's correct
> > when using HOSTCC.
> 
> Is it?  I thought kernel didn't care what Glibc or what kernel headers you had 
> (that is system requirement) - it is automous.  Isn't HOSTCC explicitly just 
> what compiler you have?
>...

CC is the compiler to actually compile the kernel for the target 
platform.

HOSTCC is the compiler to build helper programs for kernel compilation.

The helper programs HOSTCC compiles aren't part of the kernel, they are 
ordinary userspace programs that could have as well been written in 
Perl.

> Nick

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

