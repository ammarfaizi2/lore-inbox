Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262580AbSLJQR5>; Tue, 10 Dec 2002 11:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262602AbSLJQR5>; Tue, 10 Dec 2002 11:17:57 -0500
Received: from dsl-213-023-066-023.arcor-ip.net ([213.23.66.23]:29058 "EHLO
	neon.pearbough.net") by vger.kernel.org with ESMTP
	id <S262580AbSLJQRw>; Tue, 10 Dec 2002 11:17:52 -0500
Date: Tue, 10 Dec 2002 17:24:06 +0100
From: axel@pearbough.net
To: "ALESSANDRO.SUARDI" <ALESSANDRO.SUARDI@oracle.com>
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: module-init-tools 0.9.3 -- "missing" issue
Message-ID: <20021210162406.GA24309@neon.pearbough.net>
Mail-Followup-To: "ALESSANDRO.SUARDI" <ALESSANDRO.SUARDI@oracle.com>,
	rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
References: <2105495.1039535073217.JavaMail.nobody@web55.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2105495.1039535073217.JavaMail.nobody@web55.us.oracle.com>
User-Agent: Mutt/1.4i
Organization: pearbough.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ALESSANDRO.SUARDI!

I'd say your automake is too old or too new. Not sure.

Axel


On Tue, 10 Dec 2002, ALESSANDRO.SUARDI wrote:

> [asuardi@dolphin module-init-tools-0.9.3]$ automake --add-missing --copy
> Makefile.am: installing `./depcomp'
> [asuardi@dolphin module-init-tools-0.9.3]$ autoconf
> [asuardi@dolphin module-init-tools-0.9.3]$ ./configure --prefix=/
> checking build system type... i686-pc-linux-gnu
> checking host system type... i686-pc-linux-gnu
> checking target system type... i686-pc-linux-gnu
> checking for a BSD-compatible install... /usr/bin/install -c
> checking whether build environment is sane... yes
> /download/kernel/v2.5/module-init-tools-0.9.3/missing: Unknown `--run' option
> Try `/download/kernel/v2.5/module-init-tools-0.9.3/missing --help' for more information
> configure: WARNING: `missing' script is too old or missing
> checking for gawk... gawk
> checking whether make sets ${MAKE}... yes
> checking for gcc... gcc
> checking for C compiler default output... a.out
> checking whether the C compiler works... yes
> checking whether we are cross compiling... no
> checking for suffix of executables...
> checking for suffix of object files... o
> checking whether we are using the GNU C compiler... yes
> checking whether gcc accepts -g... yes
> checking for style of include used by make... GNU
> checking dependency style of gcc... gcc3
> configure: creating ./config.status
> config.status: creating Makefile
> config.status: executing depfiles commands
> 
> So - it complains about 'missing' not knowing the --run option. Indeed:
> 
> [asuardi@dolphin module-init-tools-0.9.3]$ ./missing --help
> ./missing [OPTION]... PROGRAM [ARGUMENT]...
> 
> Handle `PROGRAM [ARGUMENT]...' for when PROGRAM is missing, or return an
> error status if there is no known handling for PROGRAM.
> 
> Options:
>   -h, --help      display this help and exit
>   -v, --version   output version information and exit
> 
> Supported PROGRAM values:
>   aclocal      touch file `aclocal.m4'
>   autoconf     touch file `configure'
>   autoheader   touch file `config.h.in'
>   automake     touch all `Makefile.in' files
>   bison        create `y.tab.[ch]', if possible, from existing .[ch]
>   flex         create `lex.yy.c', if possible, from existing .c
>   lex          create `lex.yy.c', if possible, from existing .c
>   makeinfo     touch the output file
>   yacc         create `y.tab.[ch]', if possible, from existing .[ch]
> [asuardi@dolphin module-init-tools-0.9.3]$
> 
> 
> Unfortunately I'm a newbie in the new module-init-tools && little time to
>  dig deeper, so take this as a very simple report. Thanks,
