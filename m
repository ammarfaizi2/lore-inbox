Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750745AbWHGLbG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbWHGLbG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 07:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbWHGLbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 07:31:06 -0400
Received: from srvr22.engin.umich.edu ([141.213.75.21]:21999 "EHLO
	srvr22.engin.umich.edu") by vger.kernel.org with ESMTP
	id S1750745AbWHGLbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 07:31:05 -0400
From: Matt Reuther <mreuther@umich.edu>
Organization: The Knights Who Say... Ni!
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.18-rc3-mm2 Compile Error
Date: Mon, 7 Aug 2006 07:31:44 -0400
User-Agent: KMail/1.8.2
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200608062330.19628.mreuther@umich.edu> <20060806222129.f1cfffb9.akpm@osdl.org>
In-Reply-To: <20060806222129.f1cfffb9.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608070731.45133.mreuther@umich.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 August 2006 01:21 am, Andrew Morton wrote:
> On Sun, 6 Aug 2006 23:30:19 -0400
>
> Matt Reuther <mreuther@umich.edu> wrote:
> > I got an Error while compiling 2.6.18-rc3-mm2:
> >
> >   AR      arch/i386/lib/lib.a
> >   GEN     .version
> >   CHK     include/linux/compile.h
> >   UPD     include/linux/compile.h
> >   CC      init/version.o
> >   LD      init/built-in.o
> >   LD      .tmp_vmlinux1
> > kernel/built-in.o(.text+0x45667): In function `bacct_add_tsk':
> > include/linux/time.h:130: undefined reference to `__divdi3'
> > make: *** [.tmp_vmlinux1] Error 1
> >
> > I attached the .config file.
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc3/2.
>6.18-rc3-mm2/hot-fixes/csa-basic-accounting-over-taskstats-fix.patch should
> fix this, thanks.

It does indeed fix the error. Thank you!

Matt
