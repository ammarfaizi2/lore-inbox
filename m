Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266717AbTBQDxo>; Sun, 16 Feb 2003 22:53:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266716AbTBQDxo>; Sun, 16 Feb 2003 22:53:44 -0500
Received: from csa.iisc.ernet.in ([144.16.67.8]:29135 "EHLO csa.iisc.ernet.in")
	by vger.kernel.org with ESMTP id <S266717AbTBQDxm>;
	Sun, 16 Feb 2003 22:53:42 -0500
Date: Mon, 17 Feb 2003 09:33:32 +0530 (IST)
From: Rahul Vaidya <rahulv@csa.iisc.ernet.in>
To: Daniel Jacobowitz <dan@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux 2.5.53 not compiling
In-Reply-To: <20030217035821.GA10759@nevyn.them.org>
Message-ID: <Pine.SOL.3.96.1030217093109.27688D-100000@osiris.csa.iisc.ernet.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From my kernel source directory: I have aliased gcc to my actual gcc
file..not the softlinked one..

Reading specs from
/usr/local/gcc-3.2/lib/gcc-lib/i686-pc-linux-gnu/3.2/specs
Configured with: ../gcc-3.2/configure --prefix=/usr/local/gcc-3.2
Thread model: posix
gcc version 3.2
 /usr/local/gcc-3.2/lib/gcc-lib/i686-pc-linux-gnu/3.2/cpp0 -lang-c -v
-D__GNUC__=3 -D__GNUC_MINOR__=2 -D__GNUC_PATCHLEVEL__=0
-D__GXX_ABI_VERSION=102 -D__ELF__ -Dunix -D__gnu_linux__ -Dlinux -D__ELF__
-D__unix__ -D__gnu_linux__ -D__linux__ -D__unix -D__linux -Asystem=posix
-D__NO_INLINE__ -D__STDC_HOSTED__=1 -Acpu=i386 -Amachine=i386 -Di386
-D__i386 -D__i386__ -D__tune_i686__ -D__tune_pentiumpro__ -iwithprefix
include -
GNU CPP version 3.2 (cpplib) (i386 Linux/ELF)
ignoring nonexistent directory
"/usr/local/gcc-3.2/i686-pc-linux-gnu/include"
ignoring duplicate directory
"/usr/local/gcc-3.2/lib/gcc-lib/i686-pc-linux-gnu/3.2/include"
#include "..." search starts here:
#include <...> search starts here:
 /usr/local/gcc-3.2/lib/gcc-lib/i686-pc-linux-gnu/3.2/include
 /usr/local/include
 /usr/local/gcc-3.2/include
 /usr/include
End of search list.
# 1 "<stdin>"
# 1 "<built-in>"
# 1 "<command line>"
# 1 "<stdin>"


--
Rahul Vaidya
Hostel Room G46,
Ph.3942451

"Life can only be understood going backwards, 
	            but it must be lived going forwards"
						-Kierkegaard

On Sun, 16 Feb 2003, Daniel Jacobowitz wrote:

> On Mon, Feb 17, 2003 at 09:24:21AM +0530, Rahul Vaidya wrote:
> > 
> > I tried compiling using the actual gcc, I got the following error.
> > 
> > gcc -Wp,-MD,init/.vermagic.o.d -D__KERNEL__ -Iinclude -Wall
> > -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
> > -pipe -mpreferred-stack-boundary=2 -march=i686
> > -Iinclude/asm-i386/mach-default -fomit-frame-pointer -nostdinc
> > -iwithprefix include    -DKBUILD_BASENAME=vermagic
> > -DKBUILD_MODNAME=vermagic -c -o init/.tmp_vermagic.o init/vermagic.c
> 
> That's just using the one in your path again.  Is it the right one? 
> What does running that exact command with -v from the kernel source dir
> give you?
> 
> -- 
> Daniel Jacobowitz
> MontaVista Software                         Debian GNU/Linux Developer
> 

