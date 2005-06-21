Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbVFULsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbVFULsJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 07:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261192AbVFUL0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 07:26:55 -0400
Received: from ns1.suse.de ([195.135.220.2]:65419 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261199AbVFULO1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 07:14:27 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: -mm -> 2.6.13 merge status
References: <20050620235458.5b437274.akpm@osdl.org.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 21 Jun 2005 13:14:26 +0200
In-Reply-To: <20050620235458.5b437274.akpm@osdl.org.suse.lists.linux.kernel>
Message-ID: <p73d5qgc67h.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> perfctr
>
>    Not yet, but getting closer.  The PPC64 guys still need to sort out a
>    few interface issues with Mikael.  We might be able to fit this into
>    2.6.13 if people get a move on.

So the problems IA64 had with this are resolved now? 

Unfortunately there is a perfmon for i386/x86-64 implementation
floating around now (with some unmergeable stuff but might be fixable) 
which is kind of competing now :/

> reiser4
> 
>     Merge it, I guess.
> 
>     The patches still contain all the reiser4-specific namespace
>     enhancements, only it is disabled, so it is effectively dead code.  Maybe
>     we should ask that it actually be removed?

Has there been actually any serious review on this? 
Last time I looked there was a lot of very ugly code in there.

Also I'm not sure things like comming with an own profiler
and spinlock debugger are really acceptable. At least this stuff
should be removed too.

-Andi

