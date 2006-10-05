Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751705AbWJERTz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751705AbWJERTz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 13:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751706AbWJERTz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 13:19:55 -0400
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:17850 "EHLO
	pne-smtpout1-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S1751704AbWJERTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 13:19:54 -0400
Date: Thu, 5 Oct 2006 19:19:53 +0200
From: Voluspa <lista1@comhem.se>
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: Merge window closed: v2.6.19-rc1
Message-ID: <20061005191953.607547d1@loke.fish.not>
In-Reply-To: <20061005095944.f0c75c9f.rdunlap@xenotime.net>
References: <20061005184916.3bc76868@loke.fish.not>
	<20061005095944.f0c75c9f.rdunlap@xenotime.net>
X-Mailer: Sylpheed-Claws 2.4.0 (GTK+ 2.4.13; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Oct 2006 09:59:44 -0700 Randy Dunlap wrote:
> On Thu, 5 Oct 2006 18:49:16 +0200 Voluspa wrote:
> 
> >   AR      arch/x86_64/lib/lib.a
> >   GEN     .version
> >   CHK     include/linux/compile.h
> >   UPD     include/linux/compile.h
> >   CC      init/version.o
> >   LD      init/built-in.o
> >   LD      vmlinux
> > arch/x86_64/kernel/built-in.o: In function
> > `print_trace_warning_symbol':
> > traps.c:(.text.print_trace_warning_symbol+0xa): undefined reference
> > to `print_symbol' make: *** [vmlinux] Error 1
> 
> You don't have CONFIG_KALLSYMS enabled?

Never. I like to keep the kernel as lean as possible until some
bug-reporting requires otherwise.

> 
> Does this patch fix the build for you?

Perfect. Thanx. Built, but haven't booted yet.

Mvh
Mats Johannesson

