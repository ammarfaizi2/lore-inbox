Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266777AbTBQDs1>; Sun, 16 Feb 2003 22:48:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266795AbTBQDs1>; Sun, 16 Feb 2003 22:48:27 -0500
Received: from crack.them.org ([65.125.64.184]:38077 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S266777AbTBQDs0>;
	Sun, 16 Feb 2003 22:48:26 -0500
Date: Sun, 16 Feb 2003 22:58:21 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Rahul Vaidya <rahulv@csa.iisc.ernet.in>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux 2.5.53 not compiling
Message-ID: <20030217035821.GA10759@nevyn.them.org>
Mail-Followup-To: Rahul Vaidya <rahulv@csa.iisc.ernet.in>,
	linux-kernel@vger.kernel.org
References: <20030217034644.GA10083@nevyn.them.org> <Pine.SOL.3.96.1030217092308.27688B-100000@osiris.csa.iisc.ernet.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOL.3.96.1030217092308.27688B-100000@osiris.csa.iisc.ernet.in>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2003 at 09:24:21AM +0530, Rahul Vaidya wrote:
> 
> I tried compiling using the actual gcc, I got the following error.
> 
> gcc -Wp,-MD,init/.vermagic.o.d -D__KERNEL__ -Iinclude -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
> -pipe -mpreferred-stack-boundary=2 -march=i686
> -Iinclude/asm-i386/mach-default -fomit-frame-pointer -nostdinc
> -iwithprefix include    -DKBUILD_BASENAME=vermagic
> -DKBUILD_MODNAME=vermagic -c -o init/.tmp_vermagic.o init/vermagic.c

That's just using the one in your path again.  Is it the right one? 
What does running that exact command with -v from the kernel source dir
give you?

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
