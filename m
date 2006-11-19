Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756535AbWKSJxG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756535AbWKSJxG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 04:53:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756533AbWKSJxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 04:53:06 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:51363 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1756535AbWKSJxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 04:53:03 -0500
Date: Sun, 19 Nov 2006 11:52:58 +0200
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Adrian Bunk <bunk@stusta.de>, Alan Cox <alan@redhat.com>,
       Andrew Morton <akpm@osdl.org>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [2.6 patch] mark pci_find_device() as __deprecated
Message-ID: <20061119095258.GK3735@rhun.zurich.ibm.com>
References: <20061114014125.dd315fff.akpm@osdl.org> <20061117142145.GX31879@stusta.de> <20061117143236.GA23210@devserv.devel.redhat.com> <20061118000629.GW31879@stusta.de> <1163929632.31358.481.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1163929632.31358.481.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 19, 2006 at 10:47:12AM +0100, Arjan van de Ven wrote:
> 
> > 
> > Oh, and if anything starts complaining "But this adds some warnings to 
> > my kernel build!", he should either first fix the 200 kB (sic) of 
> > warnings I'm getting in 2.6.19-rc5-mm2 starting at MODPOST or go to hell.
> 
> we can solve this btw; we could have a
> 
> #define THIS_MODULE_IS_LEGACY_CRAP_AND_WONT_GET_FIXED
> 
> that would turn __deprecated into a nop for those few legacy modules
> inside the kernel that nobody really is looking after.

If no one is looking after them, shouldn't they just be removed?

Cheers,
Muli
