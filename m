Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750796AbWFUVQy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbWFUVQy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 17:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbWFUVQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 17:16:53 -0400
Received: from aa001msr.fastwebnet.it ([85.18.95.64]:40404 "EHLO
	aa001msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1750796AbWFUVQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 17:16:52 -0400
Date: Wed, 21 Jun 2006 23:16:17 +0200
From: Mattia Dongili <malattia@linux.it>
To: Andrew Morton <akpm@osdl.org>
Cc: hpa@zytor.com, mbligh@mbligh.org, linux-kernel@vger.kernel.org
Subject: Re: fs/binfmt_aout.o, Error: suffix or operands invalid for `cmp' [was Re: 2.6.17-mm1]
Message-ID: <20060621211616.GB4638@inferi.kami.home>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, hpa@zytor.com,
	mbligh@mbligh.org, linux-kernel@vger.kernel.org
References: <44998DCB.1030703@mbligh.org> <20060621184814.GQ24595@inferi.kami.home> <44999BC5.7060702@zytor.com> <20060621193932.GR24595@inferi.kami.home> <20060621134215.1bca6a5c.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060621134215.1bca6a5c.akpm@osdl.org>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.17-rc5-mm3-2 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2006 at 01:42:15PM -0700, Andrew Morton wrote:
> On Wed, 21 Jun 2006 21:39:32 +0200
> Mattia Dongili <malattia@linux.it> wrote:
> 
> > Thanks, this is fixed, but I have a new failure:
> >   CC [M]  fs/xfs/support/move.o
> >   CC [M]  fs/xfs/support/uuid.o
> >   LD [M]  fs/xfs/xfs.o
> >   CC      fs/dnotify.o
> >   CC      fs/dcookies.o
> >   LD      fs/built-in.o
> >   CC [M]  fs/binfmt_aout.o
> > {standard input}: Assembler messages:
> > {standard input}:160: Error: suffix or operands invalid for `cmp'
> > make[1]: *** [fs/binfmt_aout.o] Error 1
> > make: *** [fs] Error 2
> 
> what the heck?  Can you do `make fs/binfmt_aout.s' then send the relevant
> parts of that file?

I can't really tell which is the relevant part other than line 160 :)
Full file available here:
http://oioio.altervista.org/linux/binfmt_aout.s

gcc is:
Using built-in specs.
Target: i486-linux-gnu
Configured with: ../src/configure -v --enable-languages=c,c++,java,f95,objc,ada,treelang --prefix=/usr --enable-shared --with-system-zlib --libexecdir=/usr/lib --without-included-gettext --enable-threads=posix --enable-nls --program-suffix=-4.0 --enable-__cxa_atexit --enable-clocale=gnu --enable-libstdcxx-debug --enable-java-awt=gtk-default --enable-gtk-cairo --with-java-home=/usr/lib/jvm/java-1.4.2-gcj-4.0-1.4.2.0/jre --enable-mpfr --disable-werror --with-tune=i686 --enable-checking=release i486-linux-gnu
Thread model: posix
gcc version 4.0.4 20060507 (prerelease) (Debian 4.0.3-3)

-- 
mattia
:wq!
