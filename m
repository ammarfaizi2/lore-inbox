Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293681AbSCAUNi>; Fri, 1 Mar 2002 15:13:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293705AbSCAUN2>; Fri, 1 Mar 2002 15:13:28 -0500
Received: from ol1-24.217.42.23.charter-stl.com ([24.217.42.23]:35005 "EHLO
	thepeel.org") by vger.kernel.org with ESMTP id <S293681AbSCAUNT>;
	Fri, 1 Mar 2002 15:13:19 -0500
Date: Fri, 1 Mar 2002 14:13:08 -0600 (CST)
From: John Peel <jrp@thepeel.org>
To: "Thang T. Mai" <thang@unixcircle.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: make menuconfig fails
In-Reply-To: <Pine.LNX.4.44.0203011032520.3325-100000@mail.unixcircle.com>
Message-ID: <Pine.LNX.4.33.0203011412240.5256-100000@thepeel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Mar 2002, Thang T. Mai wrote:

> 
> Do you have perl installed?
> Cheers!

[root@localhost root]# which perl
/usr/bin/perl

> 
> On Fri, 1 Mar 2002, John Peel wrote:
> 
> > I just setup a new box running RH7.2 and I am trying to compile kernel 
> > 2.4.18. I did a minimal install on this box as it is only going to function as a router. When I 
> > initially did a 'make menuconfig' it gave me an error regarding ncurses 
> > being missing. I installed ncurses, ncurses4, and ncurses-devel. Now when 
> > I do a 'make menuconfig' I get the following output:
> > 
> > [root@localhost linux]# make menuconfig
> > rm -f include/asm
> > ( cd include ; ln -sf asm-i386 asm)
> > make -C scripts/lxdialog all
> > make[1]: Entering directory `/usr/src/linux/scripts/lxdialog'
> > gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -DLOCALE  
> > -I/usr/include/ncurses -DCURSES_LOC="<ncurses.h>" -c -o checklist.o 
> > checklist.c
> > checklist.c: In function `dialog_checklist':
> > checklist.c:154: `TRUE' undeclared (first use in this function)
> > checklist.c:154: (Each undeclared identifier is reported only once
> > checklist.c:154: for each function it appears in.)
> > checklist.c:241: `FALSE' undeclared (first use in this function)
> > make[1]: *** [checklist.o] Error 1
> > make[1]: Leaving directory `/usr/src/linux/scripts/lxdialog'
> > make: *** [menuconfig] Error 2
> > [root@localhost linux]#
> > 
> > Can anyone shed some light on what's going on. I could just use 'make 
> > config' but it's so time consuming and on most of my boxes I upgrade 
> > kernels quite often. Thanks in advance and i apologize if I'm looking in 
> > the wrong place for solutions. -peel
> > 
> > john peel
> > jrp@thepeel.org
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 

