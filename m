Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264997AbUELAqc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264997AbUELAqc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 20:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265080AbUELAnD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 20:43:03 -0400
Received: from fw.osdl.org ([65.172.181.6]:9672 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265097AbUELAgj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 20:36:39 -0400
Date: Tue, 11 May 2004 17:37:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ashok Raj <ashok.raj@intel.com>
Cc: pj@sgi.com, ashok.raj@intel.com, davidm@hpl.hp.com,
       linux-kernel@vger.kernel.org, anil.s.keshavamurthy@intel.com
Subject: Re: (resend) take3: Updated CPU Hotplug patches for IA64 (pj
 blessed) Patch [6/7]
Message-Id: <20040511173715.748b1795.akpm@osdl.org>
In-Reply-To: <20040511165853.A21249@unix-os.sc.intel.com>
References: <20040504211755.A13286@unix-os.sc.intel.com>
	<20040511161653.49e836e5.pj@sgi.com>
	<20040511163801.2a657b07.akpm@osdl.org>
	<20040511165853.A21249@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ashok Raj <ashok.raj@intel.com> wrote:
>
> I had sent a private mail to davidm for inclusion in ia64 tree, he mentioned 
> that it would be preferable to cook akpm tree to make sure no build breaks, 
> and then he would consider those for inclusion in his tree. especially -mm gets
> more testing, but iam not sure how may would really try this hotplug :-)

Oh the patches are fine wrt side-effects.  I've had them for a couple of
weeks, they're tested on at least x86, ppc64, ppc, ia64, x86_64 and
sparc64.

It's just a question of whether David would prefer to handle them?

Affected files are:

arch/ia64/dig/Makefile
arch/ia64/dig/topology.c
arch/ia64/Kconfig
arch/ia64/kernel/iosapic.c
arch/ia64/kernel/irq.c
arch/ia64/kernel/irq_ia64.c
arch/ia64/kernel/palinfo.c
arch/ia64/kernel/process.c
arch/ia64/kernel/sal.c
arch/ia64/kernel/setup.c
arch/ia64/kernel/smpboot.c
arch/ia64/kernel/smp.c
arch/ia64/kernel/time.c
arch/ia64/mm/init.c
arch/ia64/mm/tlb.c
fs/proc/proc_misc.c
include/asm-ia64/cpu.h
include/asm-ia64/cpumask.h
include/asm-ia64/smp.h
include/linux/cpumask.h
init/main.c
kernel/cpu.c
kernel/sched.c
