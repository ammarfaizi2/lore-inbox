Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbTKXVtf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 16:49:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbTKXVtf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 16:49:35 -0500
Received: from pop.gmx.net ([213.165.64.20]:57569 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261262AbTKXVsa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 16:48:30 -0500
X-Authenticated: #20450766
Date: Mon, 24 Nov 2003 22:47:35 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Bradley Chapman <kakadu_croc@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: What exactly are the issues with 2.6.0-test10 preempt?
In-Reply-To: <20031124212929.94319.qmail@web40904.mail.yahoo.com>
Message-ID: <Pine.LNX.4.44.0311242240410.2874-100000@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Nov 2003, Bradley Chapman wrote:

> Hmmm. This is what I have enabled under "Kernel hacking":
>
> #
> # Kernel hacking
> #
> CONFIG_DEBUG_KERNEL=y
> CONFIG_DEBUG_STACKOVERFLOW=y
> CONFIG_DEBUG_SLAB=y
> CONFIG_DEBUG_IOVIRT=y
> CONFIG_MAGIC_SYSRQ=y
> CONFIG_DEBUG_SPINLOCK=y
> # CONFIG_DEBUG_PAGEALLOC is not set
    ^^^^^^^^^^^^^^^^^^^^^^

Here's a candidate. I did have it on. Yes, I know it causes a slowdown -
that was for testing. I could try to double check, if disabling that
single option fixes the problem - but for that I'd need to recompile and
re-install kernel and modules... I also didn't have
CONFIG_DEBUG_STACKOVERFLOW switched on - but I don't think that could be
the reason.

> # CONFIG_DEBUG_INFO is not set
> CONFIG_DEBUG_SPINLOCK_SLEEP=y
> # CONFIG_FRAME_POINTER is not set
> CONFIG_X86_EXTRA_IRQS=y
> CONFIG_X86_FIND_SMP_CONFIG=y
> CONFIG_X86_MPPARSE=y
>
> So far, though, not a single problem -- I was playing Flash animations while
> printing a huge document without a single hiccup (I have an HP DeskJet 880C with
> very little memory, so there was a lot of in-kernel activity).

Guennadi
---
Guennadi Liakhovetski


