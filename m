Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268397AbUI2Njo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268397AbUI2Njo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 09:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268430AbUI2Njn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 09:39:43 -0400
Received: from bhhdoa.org.au ([216.17.101.199]:55051 "EHLO bhhdoa.org.au")
	by vger.kernel.org with ESMTP id S268425AbUI2NhC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 09:37:02 -0400
Date: Wed, 29 Sep 2004 16:36:15 +0300 (EAT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Suresh Siddha <suresh.b.siddha@intel.com>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, asit.k.mallick@intel.com,
       Andi Kleen <ak@suse.de>
Subject: Re: [Patch 0/2] Disable SW irqbalance/irqaffinity for E7520/E7320/E7525
In-Reply-To: <20040927110350.C18131@unix-os.sc.intel.com>
Message-ID: <Pine.LNX.4.61.0409281907020.3087@musoma.fsmlabs.com>
References: <20040923233410.A19555@unix-os.sc.intel.com>
 <Pine.LNX.4.53.0409241805020.2791@musoma.fsmlabs.com> <4154828F.6090205@pobox.com>
 <20040924152026.A25742@unix-os.sc.intel.com> <Pine.LNX.4.53.0409251206120.2914@musoma.fsmlabs.com>
 <20040927110350.C18131@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Sep 2004, Suresh Siddha wrote:

> As far as irq_affinity is concerned, workaround fits nicely in quirks.c
> infrastructure.
> 
> x86 irqbalance is the one which is causing the pain. Workaround will be more
> cleaner if we can move balanced_irq_init() to late_initcall.
> 
> If there is no objection, I can post a new patch with that change.

I don't see anything wrong with that, go ahead.

Thanks,
	Zwane
