Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263340AbTE3Hwi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 03:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263349AbTE3Hwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 03:52:37 -0400
Received: from dp.samba.org ([66.70.73.150]:49548 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263340AbTE3Hwg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 03:52:36 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Paul Mackerras <paulus@samba.org>
Cc: davem@redhat.com, rth@twiddle.net, rmk@arm.linux.org.uk,
       jes@trained-monkey.org, ralf@gnu.org, matthew@wil.cx, jdike@karaya.com,
       uclinux-v850@lsi.nec.co.jp, davidm@hpl.hp.com, anton@samba.org,
       ak@suse.de, rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: Proposed patch to kernel.h 
In-reply-to: Your message of "Thu, 29 May 2003 22:32:35 +1000."
             <16085.64995.7031.949757@argo.ozlabs.ibm.com> 
Date: Fri, 30 May 2003 18:03:37 +1000
Message-Id: <20030530080555.BAF3A2C0D2@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <16085.64995.7031.949757@argo.ozlabs.ibm.com> you write:
> That meant that I needed to use find_sec(), which was static in
> kernel/module.c (to find the __bug_table section), so I renamed it to
> elf_find_sec() and made it externally accessible (once again at
> Rusty's suggestion).
> 
> Tested OK on ppc, and compile-tested on x86 successfully.
> 
> How does this look?

Looks fine to me.  If every arch goes this way in 2.7 (say) we can
fold it back into kernel/module.c like we do for exception tables.

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
