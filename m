Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268929AbUJEJ3e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268929AbUJEJ3e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 05:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268922AbUJEJ3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 05:29:31 -0400
Received: from smtp.nedstat.nl ([194.109.98.184]:59801 "HELO smtp.nedstat.nl")
	by vger.kernel.org with SMTP id S268916AbUJEJ3E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 05:29:04 -0400
Subject: Re: 2.6.9-rc3-mm2
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Pasi Savolainen <psavo@iki.fi>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <slrncm315m.hiv.psavo@varg.dyndns.org>
References: <20041004020207.4f168876.akpm@osdl.org>
	 <slrncm315m.hiv.psavo@varg.dyndns.org>
Content-Type: text/plain
Message-Id: <1096968325.2628.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 05 Oct 2004 11:25:25 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-10-04 at 19:13, Pasi Savolainen wrote:
> * Andrew Morton <akpm@osdl.org>:
> >
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc3/2.6.9-rc3-mm2/
> >
> >
> > - Hopefully those x86 compile errors are fixed up.
> 
> Are they something like this?
> 
> - -
> pvsavola@tienel:~/linu/k25/mm$ uname -a
> Linux tienel 2.6.9-rc3-mm1 #1 SMP Sun Oct 3 16:34:23 EEST 2004 i686 GNU/Linux
> pvsavola@tienel:~/linu/k25/mm$ make -j1 bzImage modules
>   CHK     include/linux/version.h
> make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
>   CHK     include/linux/compile.h
>   GEN_INITRAMFS_LIST usr/initramfs_list
> Using shipped usr/initramfs_list
>   GEN     .version
>   CHK     include/linux/compile.h
>   UPD     include/linux/compile.h
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
>   KSYM    .tmp_kallsyms1.S
> make: *** wait: No child processes.  Stop.
> - -
> 
> The 'no child processes' keeps on coming up at 'random' moments under
> rc3-mm1. First time ever that I've seen it otherwise.
> 

Just a simple mee too!
on 2.6.9-rc3-mm2-VP-T0 and on some earlier Sx patches as well.
Unfortunatly I haven't had time to track back as to when this was
introduced.

Both a P4-HT and a dual athlon have this problem.

Regards,

Peter Zijlstra

