Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751042AbWJCSR1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbWJCSR1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 14:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751053AbWJCSR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 14:17:27 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:64913 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751041AbWJCSR0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 14:17:26 -0400
Subject: Re: 2.6.18-mm3
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>
In-Reply-To: <20061003110136.3a572578.akpm@osdl.org>
References: <20061003001115.e898b8cb.akpm@osdl.org>
	 <1159897051.9569.0.camel@dyn9047017100.beaverton.ibm.com>
	 <20061003110136.3a572578.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 03 Oct 2006 11:16:57 -0700
Message-Id: <1159899417.9569.11.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-03 at 11:01 -0700, Andrew Morton wrote:
...
> 
> http://userweb.kernel.org/~akpm/badari2.bz2 is a rollup against 2.6.18
> which omits the various zone changes.  Can you see if that also fails?

I can't compile this. I found the problem with -mm3 (I sent the patch
already). Networking is working fine now on -mm3. So I don't bother
trying this for now ?

  CHK     include/linux/version.h
  CHK     include/linux/utsrelease.h
  CC      arch/x86_64/kernel/asm-offsets.s
In file included from arch/x86_64/kernel/asm-offsets.c:7:
include/linux/crypto.h:20:24: error: asm/atomic.h: No such file or
directory
In file included from include/linux/sched.h:4,
                 from include/linux/module.h:9,
                 from include/linux/crypto.h:21,
                 from arch/x86_64/kernel/asm-offsets.c:7:
include/linux/auxvec.h:4:24: error: asm/auxvec.h: No such file or
directory
In file included from include/linux/module.h:9,
                 from include/linux/crypto.h:21,
                 from arch/x86_64/kernel/asm-offsets.c:7:
include/linux/sched.h:44:36: error: asm/param.h: No such file or
directory


Thanks,
Badari

