Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268524AbUI2PU0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268524AbUI2PU0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 11:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268633AbUI2PUU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 11:20:20 -0400
Received: from bhhdoa.org.au ([216.17.101.199]:34572 "EHLO bhhdoa.org.au")
	by vger.kernel.org with ESMTP id S268524AbUI2PRB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 11:17:01 -0400
Date: Wed, 29 Sep 2004 18:16:24 +0300 (EAT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Suresh Siddha <suresh.b.siddha@intel.com>
Cc: akpm@osdl.org, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, asit.k.mallick@intel.com,
       Andi Kleen <ak@suse.de>
Subject: Re: [Patch 0/2] Disable SW irqbalance/irqaffinity for E7520/E7320/E7525
In-Reply-To: <20040928141157.D18131@unix-os.sc.intel.com>
Message-ID: <Pine.LNX.4.61.0409291815310.3056@musoma.fsmlabs.com>
References: <20040923233410.A19555@unix-os.sc.intel.com>
 <Pine.LNX.4.53.0409241805020.2791@musoma.fsmlabs.com> <4154828F.6090205@pobox.com>
 <20040924152026.A25742@unix-os.sc.intel.com> <Pine.LNX.4.53.0409251206120.2914@musoma.fsmlabs.com>
 <20040927110350.C18131@unix-os.sc.intel.com> <20040928141157.D18131@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Sep 2004, Suresh Siddha wrote:

> On Mon, Sep 27, 2004 at 11:03:51AM -0700, Suresh Siddha wrote:
> > As far as irq_affinity is concerned, workaround fits nicely in quirks.c
> > infrastructure.
> > 
> > x86 irqbalance is the one which is causing the pain. Workaround will be more
> > cleaner if we can move balanced_irq_init() to late_initcall.
> > 
> > If there is no objection, I can post a new patch with that change.
> 
> Here is a new patch. Andrew please apply.

Thanks Suresh, looks good.

	Zwane
