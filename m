Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267961AbTAHQV3>; Wed, 8 Jan 2003 11:21:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267962AbTAHQV3>; Wed, 8 Jan 2003 11:21:29 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:22029 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S267961AbTAHQV2>;
	Wed, 8 Jan 2003 11:21:28 -0500
Date: Wed, 8 Jan 2003 17:28:44 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Andrew Walrond <andrew@walrond.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUILD PROBLEM - Linux 2.5 BK - smpboot.c
Message-ID: <20030108162844.GA1025@mars.ravnborg.org>
Mail-Followup-To: Andrew Walrond <andrew@walrond.org>,
	linux-kernel@vger.kernel.org
References: <3E1C17E0.2080804@walrond.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E1C17E0.2080804@walrond.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2003 at 12:21:52PM +0000, Andrew Walrond wrote:
> I'm seeing this error:
> 
>   gcc -Wp,-MD,arch/i386/kernel/.smpboot.o.d -D__KERNEL__ -Iinclude 
> -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing 
> -fno-common -pipe -mpreferred-stack-boundary=2 -march=pentium4 
> -Iinclude/asm-i386/mach-default -fomit-frame-pointer -nostdinc 
> -iwithprefix include    -DKBUILD_BASENAME=smpboot 
> -DKBUILD_MODNAME=smpboot   -c -o arch/i386/kernel/smpboot.o 
> arch/i386/kernel/smpboot.c
> arch/i386/kernel/smpboot.c:55:26:make -f scripts/Makefile.build obj=fs/devfs
>  mach_wakecpu.h: No such file or directory

In BK recent mach_acpi is included on line 55.
Sure you have a clean tree?

	Sam
