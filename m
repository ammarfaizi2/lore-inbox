Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262266AbTAEAoP>; Sat, 4 Jan 2003 19:44:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262296AbTAEAoP>; Sat, 4 Jan 2003 19:44:15 -0500
Received: from dp.samba.org ([66.70.73.150]:48054 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262266AbTAEAoJ>;
	Sat, 4 Jan 2003 19:44:09 -0500
Date: Sun, 5 Jan 2003 11:50:44 +1100
From: Anton Blanchard <anton@samba.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] irq handling code consolidation, second try (ppc part)
Message-ID: <20030105005044.GB4217@krispykreme>
References: <20030104115910.GF10477@pazke>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030104115910.GF10477@pazke>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> attached patch is a second try of IRQ handling code consolidation.
> This is a ppc specific patch (compiled successfuly).
> 
> Beware, this patch removes some old(?) and crappy code:
> 	- irq_kmalloc(), irq_kfree() removed. If ppc need to register
> 	  irqs early, it should use setup_irq() as all decent people do :))
> 	- request_irq() with NULL handler argument == free_irq(), does
> 	  anyone use this kludge ?

Similar issues on ppc64 (since it started life as a copy of the ppc32 code :)
Im interested in moving to something generic.

Anton
