Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267963AbTBMJSX>; Thu, 13 Feb 2003 04:18:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267966AbTBMJSX>; Thu, 13 Feb 2003 04:18:23 -0500
Received: from dns.toxicfilms.tv ([150.254.37.24]:11278 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP
	id <S267963AbTBMJSW>; Thu, 13 Feb 2003 04:18:22 -0500
Date: Thu, 13 Feb 2003 10:28:07 +0100 (CET)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: oford <oford@ev1.net>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.60 Compile error
In-Reply-To: <1045126616.23710.51.camel@spider.hotmonkeyporn.com>
Message-ID: <Pine.LNX.4.51.0302131027320.25884@dns.toxicfilms.tv>
References: <1045126616.23710.51.camel@spider.hotmonkeyporn.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Feb 2003, oford wrote:

>   gcc -Wp,-MD,arch/i386/kernel/.time.o.d -D__KERNEL__ -Iinclude -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
> -pipe -mpreferred-stack-boundary=2 -march=pentium3
> -Iinclude/asm-i386/mach-default -fomit-frame-pointer -nostdinc
> -iwithprefix include    -DKBUILD_BASENAME=time -DKBUILD_MODNAME=time -c
> -o arch/i386/kernel/.tmp_time.o arch/i386/kernel/time.c
> ld:arch/i386/kernel/.tmp_time.ver:1: parse error
> make[1]: *** [arch/i386/kernel/time.o] Error 1
> make: *** [arch/i386/kernel] Error 2
>
There's a sed incompatibility, check out 2.5.60-dj2, that has it fixed.

Regards,
Maciej
