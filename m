Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313113AbSHNKGp>; Wed, 14 Aug 2002 06:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315374AbSHNKGp>; Wed, 14 Aug 2002 06:06:45 -0400
Received: from skynet.stack.nl ([131.155.140.225]:55311 "EHLO skynet.stack.nl")
	by vger.kernel.org with ESMTP id <S313113AbSHNKGo>;
	Wed, 14 Aug 2002 06:06:44 -0400
Date: Wed, 14 Aug 2002 12:10:34 +0200 (CEST)
From: Jos Hulzink <josh@stack.nl>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Matt Dobson <colpatch@us.ibm.com>
Subject: Re: [PATCH] NUMA-Q disable irqbalance
In-Reply-To: <Pine.LNX.4.44.0208131320280.1260-100000@home.transmeta.com>
Message-ID: <20020814115944.Q22573-100000@toad.stack.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Aug 2002, Linus Torvalds wrote:

> There are tons of reasons to run the same kernel on a multitude of
> machines, even ignoring the issue of things like installers etc.
>
> We had this CONFIG_xxxx disease when it came to SSE, we had it when it
> came to TSC, etc. And in every case it ended up being bad, simply because
> it's not the right interface for _users_.

True, but the nice thing about the linux kernel is that every little
detail can be modified as you like. I think it is very important to answer
the question what skills a person that wants to compile a kernel needs. If
you want to lower the threshold, this sure is an config option that
shouldn't be there.

Maybe the config system should provide an expert-mode to tweak stuff like
this, and enable / disable the irq balancing by default according to the
processor type selected.

Jos

