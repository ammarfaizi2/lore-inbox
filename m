Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263282AbTEMIoU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 04:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263286AbTEMIoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 04:44:20 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:40196 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S263282AbTEMIoT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 04:44:19 -0400
Date: Tue, 13 May 2003 10:55:25 +0200
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Alexander Hoogerhuis <alexh@ihatent.com>,
       James Simmons <jsimmons@infradead.org>
Subject: Re: 2.5.69-mm4
Message-ID: <20030513085525.GA7730@hh.idb.hist.no>
References: <20030512225504.4baca409.akpm@digeo.com> <87vfwf8h2n.fsf@lapper.ihatent.com> <20030513001135.2395860a.akpm@digeo.com> <87n0hr8edh.fsf@lapper.ihatent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87n0hr8edh.fsf@lapper.ihatent.com>
User-Agent: Mutt/1.5.4i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 10:00:58AM +0200, Alexander Hoogerhuis wrote:
> And this one :)
> 
>         ld -m elf_i386  -T arch/i386/vmlinux.lds.s arch/i386/kernel/head.o arch/i386/kernel/init_task.o   init/built-in.o --start-group  usr/built-in.o  arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o  arch/i386/mach-default/built-in.o  kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o  security/built-in.o  crypto/built-in.o  lib/lib.a  arch/i386/lib/lib.a  drivers/built-in.o  sound/built-in.o  arch/i386/pci/built-in.o  net/built-in.o --end-group  -o .tmp_vmlinux1
> kernel/built-in.o(.text+0x1005): In function `schedule':
> : undefined reference to `active_load_balance'

I got this one too, as well as:
drivers/built-in.o(.text+0x7d534): In function `fb_prepare_logo':
: undefined reference to `find_logo'

Helge Hafting

