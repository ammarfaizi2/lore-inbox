Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293507AbSCASvw>; Fri, 1 Mar 2002 13:51:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293517AbSCASvd>; Fri, 1 Mar 2002 13:51:33 -0500
Received: from adsl-63-193-121-28.dsl.snfc21.pacbell.net ([63.193.121.28]:24755
	"EHLO mail.unixcircle.com") by vger.kernel.org with ESMTP
	id <S293507AbSCASvV>; Fri, 1 Mar 2002 13:51:21 -0500
Date: Fri, 1 Mar 2002 10:33:26 -0800 (PST)
From: "Thang T. Mai" <thang@unixcircle.com>
To: John Peel <jrp@thepeel.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: make menuconfig fails
In-Reply-To: <Pine.LNX.4.33.0203011118460.3337-100000@thepeel.org>
Message-ID: <Pine.LNX.4.44.0203011032520.3325-100000@mail.unixcircle.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Do you have perl installed?
Cheers!

On Fri, 1 Mar 2002, John Peel wrote:

> I just setup a new box running RH7.2 and I am trying to compile kernel 
> 2.4.18. I did a minimal install on this box as it is only going to function as a router. When I 
> initially did a 'make menuconfig' it gave me an error regarding ncurses 
> being missing. I installed ncurses, ncurses4, and ncurses-devel. Now when 
> I do a 'make menuconfig' I get the following output:
> 
> [root@localhost linux]# make menuconfig
> rm -f include/asm
> ( cd include ; ln -sf asm-i386 asm)
> make -C scripts/lxdialog all
> make[1]: Entering directory `/usr/src/linux/scripts/lxdialog'
> gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -DLOCALE  
> -I/usr/include/ncurses -DCURSES_LOC="<ncurses.h>" -c -o checklist.o 
> checklist.c
> checklist.c: In function `dialog_checklist':
> checklist.c:154: `TRUE' undeclared (first use in this function)
> checklist.c:154: (Each undeclared identifier is reported only once
> checklist.c:154: for each function it appears in.)
> checklist.c:241: `FALSE' undeclared (first use in this function)
> make[1]: *** [checklist.o] Error 1
> make[1]: Leaving directory `/usr/src/linux/scripts/lxdialog'
> make: *** [menuconfig] Error 2
> [root@localhost linux]#
> 
> Can anyone shed some light on what's going on. I could just use 'make 
> config' but it's so time consuming and on most of my boxes I upgrade 
> kernels quite often. Thanks in advance and i apologize if I'm looking in 
> the wrong place for solutions. -peel
> 
> john peel
> jrp@thepeel.org
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

