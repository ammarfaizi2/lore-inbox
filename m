Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265742AbTGIG3P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 02:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265756AbTGIG3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 02:29:15 -0400
Received: from mx2.elte.hu ([157.181.151.9]:50825 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S265742AbTGIG3O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 02:29:14 -0400
Date: Wed, 9 Jul 2003 08:42:53 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org, <linux-mm@kvack.org>
Subject: Re: [announce, patch] 4G/4G split on x86, 64 GB RAM (and more)
 support
In-Reply-To: <55580000.1057727591@[10.10.2.4]>
Message-ID: <Pine.LNX.4.44.0307090841410.4997-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 8 Jul 2003, Martin J. Bligh wrote:

> > i'm pleased to announce the first public release of the "4GB/4GB VM split"
> > patch, for the 2.5.74 Linux kernel:
> > 
> >    http://redhat.com/~mingo/4g-patches/4g-2.5.74-F8
> 
> I presume this was for -bk something as it applies clean to -bk6, but
> not virgin.

indeed - it's for BK-curr.

> However, it crashes before console_init on NUMA ;-( I'll shove early
> printk in there later.

wli found the bug meanwhile - i'll do a new patch later today.

	Ingo

