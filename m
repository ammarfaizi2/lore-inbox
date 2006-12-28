Return-Path: <linux-kernel-owner+w=401wt.eu-S1754935AbWL1TCp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754935AbWL1TCp (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 14:02:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754936AbWL1TCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 14:02:44 -0500
Received: from smtp.osdl.org ([65.172.181.25]:51591 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754934AbWL1TCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 14:02:44 -0500
Date: Thu, 28 Dec 2006 11:01:53 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Gordon Farquharson <gordonfarquharson@gmail.com>,
       David Miller <davem@davemloft.net>, ranma@tdiedrich.de, tbm@cyrius.com,
       Peter Zijlstra <a.p.zijlstra@chello.nl>, andrei.popa@i-neo.ro,
       Andrew Morton <akpm@osdl.org>, hugh@veritas.com,
       nickpiggin@yahoo.com.au, arjan@infradead.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: fix page_mkclean_one
In-Reply-To: <20061228184440.GC20596@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0612281101180.4473@woody.osdl.org>
References: <20061226.205518.63739038.davem@davemloft.net>
 <Pine.LNX.4.64.0612271601430.4473@woody.osdl.org>
 <Pine.LNX.4.64.0612271636540.4473@woody.osdl.org> <20061227.165246.112622837.davem@davemloft.net>
 <Pine.LNX.4.64.0612271835410.4473@woody.osdl.org>
 <97a0a9ac0612272032uf5358c4qf12bf183f97309a6@mail.gmail.com>
 <Pine.LNX.4.64.0612272039411.4473@woody.osdl.org>
 <97a0a9ac0612272120g144d2364n932d6f66728f162e@mail.gmail.com>
 <20061228101311.GA9672@flint.arm.linux.org.uk> <Pine.LNX.4.64.0612280917000.4473@woody.osdl.org>
 <20061228184440.GC20596@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 28 Dec 2006, Russell King wrote:
> 
> Yup, but I have nothing to do with glibc because I refuse to do that
> silly copyright assignment FSF thing.  Hopefully someone else can
> resolve it, but...

Yeah, me too.

> _is_ a fix whether _you_ like it or not to work around the issue so
> people can at least run your test program.  I'm not saying it's a
> proper fix though.

My point was that it wasn't a "fix", it's a "workaround". The _fix_ would 
be in glibc.

Nothing more..

		Linus
