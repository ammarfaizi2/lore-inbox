Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263376AbTLEJLF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 04:11:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263448AbTLEJLF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 04:11:05 -0500
Received: from holomorphy.com ([199.26.172.102]:52946 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263376AbTLEJLD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 04:11:03 -0500
Date: Fri, 5 Dec 2003 01:10:51 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Hugang <hugang@soulinfo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test11-wli-1
Message-ID: <20031205091051.GC8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Hugang <hugang@soulinfo.com>, linux-kernel@vger.kernel.org
References: <20031204200120.GL19856@holomorphy.com> <20031205161451.790ae1ea.hugang@soulinfo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031205161451.790ae1ea.hugang@soulinfo.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Dec 2003 12:01:20 -0800 William Lee Irwin III <wli@holomorphy.com> wrote:
>> Successfully tested on a Thinkpad T21. Any feedback regarding
>> performance would be very helpful. Desktop users should notice top(1)
>> is faster, kernel hackers that kernel compiles are faster, and highmem
>> users should see much less per-process lowmem overhead.

On Fri, Dec 05, 2003 at 04:14:51PM +0800, Hugang wrote:
> I got this in ppc.
> fs/built-in.o: In function `proc_task_readdir':
> fs/built-in.o(.text+0x2ff44): undefined reference to `__cmpdi2'
> fs/built-in.o(.text+0x2ff44): relocation truncated to fit: R_PPC_REL24 __cmpdi2
> fs/built-in.o(.text+0x2ff6c): undefined reference to `__cmpdi2'
> fs/built-in.o(.text+0x2ff6c): relocation truncated to fit: R_PPC_REL24 __cmpdi2
> make: *** [.tmp_vmlinux1] Error 1

Thanks, I'll pick that up.


-- wli
