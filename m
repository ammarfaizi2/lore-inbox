Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264073AbUDFXus (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 19:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264076AbUDFXus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 19:50:48 -0400
Received: from main.gmane.org ([80.91.224.249]:18626 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264073AbUDFXuq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 19:50:46 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Joshua Kwan <joshk@triplehelix.org>
Subject: Re: 2.6.2-rc3: irq#19 - nobody cared - with an au88xx
Date: Tue, 06 Apr 2004 16:43:35 -0700
Message-ID: <pan.2004.04.06.23.43.34.966355@triplehelix.org>
References: <BF1FE1855350A0479097B3A0D2A80EE0023E89C2@hdsmsx402.hd.intel.com> <1076134307.2562.1553.camel@dhcppc4> <20040406180238.GA7439@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-68-126-186-145.dsl.pltn13.pacbell.net
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 06 Apr 2004 14:02:38 -0400, Daniel Jacobowitz wrote:
> I still haven't figured out which kernel first introduced the problem,
> but it's still present, at 2.6.5.  I didn't see it while I was running
> 2.6.3-rc3, for some reason.
> 
> Now I'm using the ALSA au8830 driver.  There was no output from the
> driver before the nobody-cared message, so it was caused by one of
> these (sound/pci/au88x0/au88x0_core.c):

I'm *completely* stabbing in the dark, but ISTR lots of problems with
Vortices (?), even on Windows, were caused by the card not being on the
bus master PCI slot (which is typically the first one on most
motherboards.) Possibly the IRQ assignment depends on the location of the
card?

Actually I am using my Vortex2 in a non-mastering PCI slot right now so
maybe that's not the problem. But I'm using the snd-au8830 driver and it
seems to work just fine in 2.6.5-mm1.

I'm most likely completely wrong, so feel free to correct me.

-- 
Joshua Kwan


