Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262418AbUILVXB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262418AbUILVXB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 17:23:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262574AbUILVXB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 17:23:01 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:5544 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S262279AbUILVWr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 17:22:47 -0400
Date: Sun, 12 Sep 2004 23:22:44 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>,
       Debian GNU/Linux m68k <debian-68k@lists.debian.org>,
       uClinux list <uclinux-dev@uclinux.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: `new' syscalls for m68k
Message-ID: <20040912212244.GC24240@MAIL.13thfloor.at>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux/m68k <linux-m68k@lists.linux-m68k.org>,
	Debian GNU/Linux m68k <debian-68k@lists.debian.org>,
	uClinux list <uclinux-dev@uclinux.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0409102250300.24607@anakin> <1094852893.18235.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094852893.18235.5.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2004 at 10:48:16PM +0100, Alan Cox wrote:
> On Gwe, 2004-09-10 at 21:57, Geert Uytterhoeven wrote:
> >   - Are sys_sched_[gs]etaffinity() needed for non-SMP?
> Not really
> 
> >   - I disabled [sg]et_thread_area() since sys_[gs]et_thread_area() are
> >     missing. Do we have to implement them, or should we use some other
> >     method for Thread Local Storage?
> 
> Up to your implementation
> 
> >   - What about sys_vserver()?

I would be happy to add a syscall reservation 
to the list of already reserved syscalls for
i386, x86_64, s390, sparc/64, sh3/4, ppc/64
and mips * ...

> Vserver project - probably dead for 2.6 since the SELinux and other
> security modules can implement this same things (and a 2.6 vserver one
> assumes would do likewise)

sorry, SELinux and friends can and do not even
remotely implement the same functionality, and
linux-vserver for 2.6 is working fine ...

best,
Herbert
 
> >   - What about sys_kexec_load()?
> 
> Depends if you support kexec
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
