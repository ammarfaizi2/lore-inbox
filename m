Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267783AbUICMoI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267783AbUICMoI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 08:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269665AbUICMoI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 08:44:08 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:40690 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S267783AbUICMoA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 08:44:00 -0400
Date: Fri, 3 Sep 2004 08:48:27 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: takata@linux-m32r.org
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-rc1-mm3
In-Reply-To: <Pine.LNX.4.58.0409030814100.4481@montezuma.fsmlabs.com>
Message-ID: <Pine.LNX.4.58.0409030823530.4481@montezuma.fsmlabs.com>
References: <20040903014811.6247d47d.akpm@osdl.org> <20040903104239.A3077@infradead.org>
 <Pine.LNX.4.58.0409030814100.4481@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a few comments.

- There appears to be yet another smc 91C111 driver in there, Takata,
  there should be a unified one in drivers/net/smc91x.c.

- arch/m32r/Kconfig could do with some trimming.

- arch/m32r/kernel/irq.c shows that we really could do with that irq
  consolidation.

- arch/m32r/kernel/m32r_ksyms, EXPORT_SYMBOL_NOVERS is deprecated, use
  EXPORT_SYMBOL.

Thanks,
	Zwane
