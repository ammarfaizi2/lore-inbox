Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261734AbVCaUEC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261734AbVCaUEC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 15:04:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261741AbVCaUEC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 15:04:02 -0500
Received: from fire.osdl.org ([65.172.181.4]:33982 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261734AbVCaUD6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 15:03:58 -0500
Date: Thu, 31 Mar 2005 12:05:53 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
cc: "'Ingo Molnar'" <mingo@elte.hu>, "'Nick Piggin'" <nickpiggin@yahoo.com.au>,
       "'Andrew Morton'" <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: RE: Industry db benchmark result on recent 2.6 kernels
In-Reply-To: <200503311953.j2VJrog22170@unix-os.sc.intel.com>
Message-ID: <Pine.LNX.4.58.0503311204050.4774@ppc970.osdl.org>
References: <200503311953.j2VJrog22170@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 31 Mar 2005, Chen, Kenneth W wrote:
> 
> No, there are no idle time on the system. If system become I/O bound, we
> would do everything we can to remove that bottleneck, i.e., throw a couple
> hundred GB of memory to the system, or add a couple hundred disk drives,
> etc.  Believe it or not, we are currently CPU bound and that's the reason
> why I care about every single cpu cycle being spend in the kernel code.

Can you post oprofile data for a run? Preferably both for the "best case"  
2.6.x thing (no point in comparing 2.4.x oprofiles with current) and for
"current kernel", whether that be 2.6.11 or some more recent snapshot?

		Linus
