Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268817AbUIXPNd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268817AbUIXPNd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 11:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268800AbUIXPNd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 11:13:33 -0400
Received: from bhhdoa.org.au ([216.17.101.199]:58380 "EHLO bhhdoa.org.au")
	by vger.kernel.org with ESMTP id S269140AbUIXPGj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 11:06:39 -0400
Date: Fri, 24 Sep 2004 18:05:36 +0300 (EAT)
From: Zwane Mwaikambo <zwane@fsmlabs.com>
To: Suresh Siddha <suresh.b.siddha@intel.com>
Cc: linux-kernel@vger.kernel.org, asit.k.mallick@intel.com
Subject: Re: [Patch 0/2] Disable SW irqbalance/irqaffinity for E7520/E7320/E7525
In-Reply-To: <20040923233410.A19555@unix-os.sc.intel.com>
Message-ID: <Pine.LNX.4.53.0409241805020.2791@musoma.fsmlabs.com>
References: <20040923233410.A19555@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Sep 2004, Suresh Siddha wrote:

> As part of the workaround for the "Interrupt message re-ordering across
> hub interface" errata (page #16 in
> http://developer.intel.com/design/chipsets/specupdt/30288402.pdf),
> BIOS may enable hardware IRQ balancing for Lindenhurst/Tumwater based chipset
> platforms. Software based irq_balance/irq_affinity should be disabled if
> hardware IRQ balancing is enabled.

Can we avoid those tests? Like not starting the irq balancer code at all 
with those chipsets?

Thanks,
	Zwane

