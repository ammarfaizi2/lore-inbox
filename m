Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269345AbUIYPBK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269345AbUIYPBK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 11:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269347AbUIYPBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 11:01:10 -0400
Received: from bhhdoa.org.au ([216.17.101.199]:51209 "EHLO bhhdoa.org.au")
	by vger.kernel.org with ESMTP id S269345AbUIYPBI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 11:01:08 -0400
Date: Sat, 25 Sep 2004 18:00:03 +0300 (EAT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Greg Kroah-Hartmann <greg@kroah.com>, Len Brown <len.brown@intel.com>,
       tony.luck@intel.com, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: acpi-devel@lists.sourceforge.net, linux-ia64@vger.kernel.orgRe:
 [PATCH] Updated patches for PCI IRQ resource deallocation support [3/3]
In-Reply-To: <Pine.LNX.4.53.0409251436390.2914@musoma.fsmlabs.com>
Message-ID: <Pine.LNX.4.53.0409251730580.2763@musoma.fsmlabs.com>
References: <2HRhX-6Ad-21@gated-at.bofh.it> <Pine.LNX.4.53.0409251436390.2914@musoma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Sep 2004, Zwane Mwaikambo wrote:

> Hmm, what happens here if that vector was queued just before the local irq 
> disable in spin_lock_irqsave(idesc->lock...) ? Then when we unlock we'll 
> call do_IRQ to handle the irq associated with that vector. I haven't seen 
> the usage but it appears that iosapic_unregister_intr requires some 
> serialisation.

Ignore this, i misread some of the code.

Thanks Kenji,
	Zwane
