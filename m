Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269772AbUJHLQV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269772AbUJHLQV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 07:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269824AbUJHLQT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 07:16:19 -0400
Received: from holomorphy.com ([207.189.100.168]:3030 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269772AbUJHLNn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 07:13:43 -0400
Date: Fri, 8 Oct 2004 04:12:49 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc3-mm3 BUG() in flush_tlb_pending() on ppc64
Message-ID: <20041008111249.GE9106@holomorphy.com>
References: <1097187487.12861.308.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097187487.12861.308.camel@dyn318077bld.beaverton.ibm.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2004 at 03:18:07PM -0700, Badari Pulavarty wrote:
> I get following assert while booting 2.6.9-rc3-mm3 on p3 machine. 
> Any fixes ?
>         scanning pci: *..kernel BUG in __flush_tlb_pending at
> arch/ppc64/mm/tlb.c:125!
> Oops: Exception in kernel mode, sig: 5 [#1]
> SMP NR_CPUS=128 NUMA PSERIES
> NIP: C00000000003E39C XER: 0000000020000000 LR: C000000000014DF8
> REGS: c00000000f0c3550 TRAP: 0700   Not tainted  (2.6.9-rc3-mm3)
> MSR: a000000000023032 EE: 0 PR: 0 FP: 1 ME: 1 IR/DR: 11
> TASK: c00000013e983030[1401] 'pci.agent' THREAD: c00000000f0c0000 CPU: 0

Now we all have to disambiguate Power3 from Pentium III...


-- wli
