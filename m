Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261702AbUB0FpY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 00:45:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261703AbUB0FpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 00:45:24 -0500
Received: from dp.samba.org ([66.70.73.150]:32904 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261702AbUB0FpV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 00:45:21 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-mm@kvack.org, mbligh@aracnet.com, akpm <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: shutdown panic in mm_release (really flush_tlb_others?) (fwd) 
In-reply-to: Your message of "Thu, 26 Feb 2004 16:45:23 -0800."
             <20040226164523.660a5496.rddunlap@osdl.org> 
Date: Fri, 27 Feb 2004 16:23:56 +1100
Message-Id: <20040227054531.DD8362C2A2@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20040226164523.660a5496.rddunlap@osdl.org> you write:
> Martin's patch didn't help me the first time that I tried it,
> but I'll try it again.  Rusty, is the patch that you posted
> complete (regarding arch/i386/kernel/smp.c), or are there other
> patch components that I might need?  It's queued up for next...

Um, please don't confuse my hotplug cpus patch with the half-assed
attempt to take CPUs down on shutdown.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
