Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262841AbUCOWnZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 17:43:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262842AbUCOWnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 17:43:11 -0500
Received: from gprs40-147.eurotel.cz ([160.218.40.147]:19686 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262841AbUCOWmQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 17:42:16 -0500
Date: Mon, 15 Mar 2004 23:18:26 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Jouni Malinen <jkmaline@cc.hut.fi>,
       James Ketrenos <jketreno@linux.co.intel.com>, jt@hpl.hp.com,
       Christoph Hellwig <hch@infradead.org>,
       "David S. Miller" <davem@redhat.com>, netdev@oss.sgi.com,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6] Intersil Prism54 wireless driver
Message-ID: <20040315221826.GA305@elf.ucw.cz>
References: <20040304023524.GA19453@bougret.hpl.hp.com> <20040310165548.A24693@infradead.org> <20040310172114.GA8867@bougret.hpl.hp.com> <404F5097.4040406@pobox.com> <20040310175200.GA9531@bougret.hpl.hp.com> <404F5744.1040201@pobox.com> <404FA6AC.7040009@linux.co.intel.com> <20040311023141.GB3738@jm.kir.nu> <404FD23C.4020205@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <404FD23C.4020205@pobox.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On St 10-03-04 21:43:08, Jeff Garzik wrote:
> Jouni Malinen wrote:
> >done, I would hope to get the code merged into the kernel tree either
> >with full Host AP driver or separately. One option would be to first add
> >Host AP driver in its current structure (i.e., everything in
> >drivers/net/wireless) and then create a new directory (net/ieee80211 ?)
> >for generic IEEE 802.11 functionality and start moving things like the
> >IEEE 802.11 encryption into the new location.
> 
> Given the discussion today, I think my preference is to merge all of 
> HostAP into the wireless-2.6 tree I just created, then submit patches to 
> that which create and populate net/802_11.  Once the work on that is 
> mostly done, it can get merged back into the main upstream tree.

Can we have net/wifi? 802_11 looks ugly. 802.11 would be better, but
wifi seems best.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
