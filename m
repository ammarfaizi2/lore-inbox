Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268914AbUJEJfG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268914AbUJEJfG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 05:35:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268915AbUJEJfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 05:35:05 -0400
Received: from smtp.nedstat.nl ([194.109.98.184]:47770 "HELO smtp.nedstat.nl")
	by vger.kernel.org with SMTP id S268914AbUJEJeF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 05:34:05 -0400
Subject: Re: 2.6.9-rc3-mm2
From: Peter Zijlstra <peter@programming.kicks-ass.net>
To: Pasi Savolainen <psavo@iki.fi>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1096968325.2628.5.camel@localhost.localdomain>
References: <20041004020207.4f168876.akpm@osdl.org>
	 <slrncm315m.hiv.psavo@varg.dyndns.org>
	 <1096968325.2628.5.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1096968626.2628.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 05 Oct 2004 11:30:26 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-05 at 11:25, Peter Zijlstra wrote:
> On Mon, 2004-10-04 at 19:13, Pasi Savolainen wrote:
> > * Andrew Morton <akpm@osdl.org>:
> > >
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc3/2.6.9-rc3-mm2/
> > >
> > >
> > > - Hopefully those x86 compile errors are fixed up.
> > 
> > Are they something like this?
> > 
> > - -
> > pvsavola@tienel:~/linu/k25/mm$ uname -a
> > Linux tienel 2.6.9-rc3-mm1 #1 SMP Sun Oct 3 16:34:23 EEST 2004 i686 GNU/Linux
> > pvsavola@tienel:~/linu/k25/mm$ make -j1 bzImage modules
> >   CHK     include/linux/version.h
> > make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
> >   CHK     include/linux/compile.h
> >   GEN_INITRAMFS_LIST usr/initramfs_list
> > Using shipped usr/initramfs_list
> >   GEN     .version
> >   CHK     include/linux/compile.h
> >   UPD     include/linux/compile.h
> >   CC      init/version.o
> >   LD      init/built-in.o
> >   LD      .tmp_vmlinux1
> >   KSYM    .tmp_kallsyms1.S
> > make: *** wait: No child processes.  Stop.
> > - -
> > 
> > The 'no child processes' keeps on coming up at 'random' moments under
> > rc3-mm1. First time ever that I've seen it otherwise.
> > 
> 
> Just a simple mee too!
> on 2.6.9-rc3-mm2-VP-T0 and on some earlier Sx patches as well.
> Unfortunatly I haven't had time to track back as to when this was
> introduced.
> 
Oh and it is any big make job, not just kernel compiles.

> Both a P4-HT and a dual athlon have this problem.
> 
> Regards,
> 
> Peter Zijlstra
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

