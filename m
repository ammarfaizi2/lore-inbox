Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266665AbSLDOze>; Wed, 4 Dec 2002 09:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266675AbSLDOze>; Wed, 4 Dec 2002 09:55:34 -0500
Received: from ip68-0-152-218.tc.ph.cox.net ([68.0.152.218]:24973 "EHLO
	Bill-The-Cat.bloom.county") by vger.kernel.org with ESMTP
	id <S266665AbSLDOzd>; Wed, 4 Dec 2002 09:55:33 -0500
Date: Wed, 4 Dec 2002 08:02:58 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Miles Lane <miles.lane@attbi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.50 -- arch/ppc/syslib/i8259.c:188: In function `i8259_init': `SA_INTERRUPT' undeclared (first use in this function)
Message-ID: <20021204150258.GG821@opus.bloom.county>
References: <1038885609.605.115.camel@jellybean>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1038885609.605.115.camel@jellybean>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 02, 2002 at 07:20:08PM -0800, Miles Lane wrote:

>   gcc -Wp,-MD,arch/ppc/syslib/.i8259.o.d -D__KERNEL__ -Iinclude -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
> -fomit-frame-pointer -I/usr/src/linux-2.5.50/arch/ppc -msoft-float -pipe
> -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -nostdinc -iwithprefix
> include    -DKBUILD_BASENAME=i8259 -DKBUILD_MODNAME=i8259   -c -o
> arch/ppc/syslib/i8259.o arch/ppc/syslib/i8259.c
> arch/ppc/syslib/i8259.c: In function `i8259_init':
> arch/ppc/syslib/i8259.c:188: `SA_INTERRUPT' undeclared (first use in
> this function)
> arch/ppc/syslib/i8259.c:188: (Each undeclared identifier is reported
> only once
> arch/ppc/syslib/i8259.c:188: for each function it appears in.)
> make[1]: *** [arch/ppc/syslib/i8259.o] Error 1
> make: *** [arch/ppc/syslib] Error 2

http://penguinppc.org/dev/kernel.shtml

I _believe_ this is fixed in the linuxppc-2.5 tree already.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
