Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262780AbUCOW5y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 17:57:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262667AbUCOW5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 17:57:54 -0500
Received: from palrel13.hp.com ([156.153.255.238]:1973 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S262780AbUCOWzo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 17:55:44 -0500
Date: Mon, 15 Mar 2004 14:55:38 -0800
To: Pavel Machek <pavel@ucw.cz>
Cc: Jeff Garzik <jgarzik@pobox.com>, Jouni Malinen <jkmaline@cc.hut.fi>,
       James Ketrenos <jketreno@linux.co.intel.com>,
       Christoph Hellwig <hch@infradead.org>,
       "David S. Miller" <davem@redhat.com>, netdev@oss.sgi.com,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6] Intersil Prism54 wireless driver
Message-ID: <20040315225538.GA7251@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20040304023524.GA19453@bougret.hpl.hp.com> <20040310165548.A24693@infradead.org> <20040310172114.GA8867@bougret.hpl.hp.com> <404F5097.4040406@pobox.com> <20040310175200.GA9531@bougret.hpl.hp.com> <404F5744.1040201@pobox.com> <404FA6AC.7040009@linux.co.intel.com> <20040311023141.GB3738@jm.kir.nu> <404FD23C.4020205@pobox.com> <20040315221826.GA305@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040315221826.GA305@elf.ucw.cz>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2004 at 11:18:26PM +0100, Pavel Machek wrote:
> On St 10-03-04 21:43:08, Jeff Garzik wrote:
> > Jouni Malinen wrote:
> > >done, I would hope to get the code merged into the kernel tree either
> > >with full Host AP driver or separately. One option would be to first add
> > >Host AP driver in its current structure (i.e., everything in
> > >drivers/net/wireless) and then create a new directory (net/ieee80211 ?)
> > >for generic IEEE 802.11 functionality and start moving things like the
> > >IEEE 802.11 encryption into the new location.
> > 
> > Given the discussion today, I think my preference is to merge all of 
> > HostAP into the wireless-2.6 tree I just created, then submit patches to 
> > that which create and populate net/802_11.  Once the work on that is 
> > mostly done, it can get merged back into the main upstream tree.
> 
> Can we have net/wifi? 802_11 looks ugly. 802.11 would be better, but
> wifi seems best.
> 								Pavel

	IEEE 802.11 is a technical standard. WiFi is a marketing
certification. There are 802.11 products which are not WiFi certified
(actually, there is one such driver already in the kernel).
	By the way, I don't really care about the final name, I'm hust
being pedantic ;-)
	Have fun...

	Jean

