Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262723AbUJ1Ams@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262723AbUJ1Ams (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 20:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262574AbUJ1AX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 20:23:26 -0400
Received: from fire.osdl.org ([65.172.181.4]:32968 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S262669AbUJ1AMv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 20:12:51 -0400
Subject: Re: 2.6.10-rc1-mm1 (compile stats)
From: John Cherry <cherry@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20041027133443.62b1fb29.akpm@osdl.org>
References: <20041026213156.682f35ca.akpm@osdl.org>
	 <1098895320.9269.32.camel@cherrybomb.pdx.osdl.net>
	 <20041027133443.62b1fb29.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1098922350.9675.235.camel@cherrybomb.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 27 Oct 2004 17:12:30 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-27 at 13:34, Andrew Morton wrote:
> John Cherry <cherry@osdl.org> wrote:
> >
> >  Build error is still...
> > 
> >    LD      vmlinux
> >    SYSMAP  System.map
> >    SYSMAP  .tmp_System.map
> >    AS      arch/i386/boot/bootsect.o
> >    AS      arch/i386/boot/compressed/head.o
> >    AS      arch/i386/boot/setup.o
> >    HOSTCC  arch/i386/boot/tools/build
> >    CC      arch/i386/boot/compressed/misc.o
> >    LD      arch/i386/boot/bootsect
> >    OBJCOPY arch/i386/boot/compressed/vmlinux.bin
> >  BFD: Warning: Writing section `.bss' to huge (ie negative) file offset 0xc02e4000.
> >  objcopy: arch/i386/boot/compressed/vmlinux.bin: File truncated
> 
> I think that means you need a binutils upgrade.  What version are you running?

2.13.90.0.18 binutils (gcc version 3.2.2).

I suspect you are right about the binutils.  I just did the same build
on my Fedora Core 3 machine and the negative file offset problem goes
away.

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

