Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261532AbUCKCnX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 21:43:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261554AbUCKCnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 21:43:23 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3977 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261532AbUCKCnW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 21:43:22 -0500
Message-ID: <404FD23C.4020205@pobox.com>
Date: Wed, 10 Mar 2004 21:43:08 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jouni Malinen <jkmaline@cc.hut.fi>
CC: James Ketrenos <jketreno@linux.co.intel.com>, jt@hpl.hp.com,
       Christoph Hellwig <hch@infradead.org>,
       "David S. Miller" <davem@redhat.com>, netdev@oss.sgi.com,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6] Intersil Prism54 wireless driver
References: <20040304023524.GA19453@bougret.hpl.hp.com> <20040310165548.A24693@infradead.org> <20040310172114.GA8867@bougret.hpl.hp.com> <404F5097.4040406@pobox.com> <20040310175200.GA9531@bougret.hpl.hp.com> <404F5744.1040201@pobox.com> <404FA6AC.7040009@linux.co.intel.com> <20040311023141.GB3738@jm.kir.nu>
In-Reply-To: <20040311023141.GB3738@jm.kir.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jouni Malinen wrote:
> done, I would hope to get the code merged into the kernel tree either
> with full Host AP driver or separately. One option would be to first add
> Host AP driver in its current structure (i.e., everything in
> drivers/net/wireless) and then create a new directory (net/ieee80211 ?)
> for generic IEEE 802.11 functionality and start moving things like the
> IEEE 802.11 encryption into the new location.

Given the discussion today, I think my preference is to merge all of 
HostAP into the wireless-2.6 tree I just created, then submit patches to 
that which create and populate net/802_11.  Once the work on that is 
mostly done, it can get merged back into the main upstream tree.

	Jeff



