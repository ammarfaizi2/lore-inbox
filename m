Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964850AbWA3Smy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964850AbWA3Smy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 13:42:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964856AbWA3Smy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 13:42:54 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:29651 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S964850AbWA3Smx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 13:42:53 -0500
Subject: Re: 2.6.15-rt16
From: Steven Rostedt <rostedt@goodmis.org>
To: chris perkins <cperkins@OCF.Berkeley.EDU>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.SOL.4.63.0601300917120.8546@conquest.OCF.Berkeley.EDU>
References: <Pine.SOL.4.63.0601300839050.8546@conquest.OCF.Berkeley.EDU>
	 <1138640592.12625.0.camel@localhost.localdomain>
	 <Pine.SOL.4.63.0601300917120.8546@conquest.OCF.Berkeley.EDU>
Content-Type: text/plain
Date: Mon, 30 Jan 2006 13:42:41 -0500
Message-Id: <1138646561.7088.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-30 at 09:24 -0800, chris perkins wrote:
> >> i'm trying to use ingo's 2.6.15-rt16 patch on an x86_64 machine but it
> >> keeps crashing in kmem_cache_init during bootup. i've tried older
> >> 2.6.15-rtX patches and they all crash during startup but vanilla 2.6.15
> >> works fine for me. anyone else seen this happen with realtime-preempt
> >> patches? here's the message:
> >
> > Can you please send me your .config file ?
> >

[...]

> CONFIG_PREEMPT_BKL=y
> CONFIG_PREEMPT_RCU=y
> CONFIG_RCU_STATS=y
> CONFIG_NUMA=y

The -rt patch currently doesn't support NUMA.  Please turn in off for
now (do you really need it?).

-- Steve


