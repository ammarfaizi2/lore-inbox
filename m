Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268285AbUJDRNf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268285AbUJDRNf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 13:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268328AbUJDRNf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 13:13:35 -0400
Received: from main.gmane.org ([80.91.229.2]:3263 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S268285AbUJDRNd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 13:13:33 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Pasi Savolainen <psavo@iki.fi>
Subject: Re: 2.6.9-rc3-mm2
Date: Mon, 4 Oct 2004 17:13:26 +0000 (UTC)
Message-ID: <slrncm315m.hiv.psavo@varg.dyndns.org>
References: <20041004020207.4f168876.akpm@osdl.org>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: a11a.mannikko1.ton.tut.fi
User-Agent: slrn/0.9.8.0 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton <akpm@osdl.org>:
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc3/2.6.9-rc3-mm2/
>
>
> - Hopefully those x86 compile errors are fixed up.

Are they something like this?

- -
pvsavola@tienel:~/linu/k25/mm$ uname -a
Linux tienel 2.6.9-rc3-mm1 #1 SMP Sun Oct 3 16:34:23 EEST 2004 i686 GNU/Linux
pvsavola@tienel:~/linu/k25/mm$ make -j1 bzImage modules
  CHK     include/linux/version.h
make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
  CHK     include/linux/compile.h
  GEN_INITRAMFS_LIST usr/initramfs_list
Using shipped usr/initramfs_list
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
  KSYM    .tmp_kallsyms1.S
make: *** wait: No child processes.  Stop.
- -

The 'no child processes' keeps on coming up at 'random' moments under
rc3-mm1. First time ever that I've seen it otherwise.


-- 
   Psi -- <http://www.iki.fi/pasi.savolainen>

