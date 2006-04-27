Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750896AbWD0HSg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbWD0HSg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 03:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbWD0HSg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 03:18:36 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:46209 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750896AbWD0HSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 03:18:36 -0400
Subject: Re: [2.6.16.11] Xircom RealPort RBEM56G-100 link change issue
From: Arjan van de Ven <arjan@infradead.org>
To: Karel Gardas <kgardas@objectsecurity.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.63.0604262337530.3859@silence.gardas.net>
References: <Pine.LNX.4.63.0604262337530.3859@silence.gardas.net>
Content-Type: text/plain
Date: Thu, 27 Apr 2006 09:18:33 +0200
Message-Id: <1146122314.2894.14.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-04-26 at 23:46 +0200, Karel Gardas wrote:
> Hello,
> 
> I'm trying to get working linux with Xircom RealPort CardBus Ethernet 
> 10/100+Modem 56 PCMCIA card. I only need ethernet working. The problem 
> with this is that I'm losing too many packets while syslog is filled with 
> messages like:
> 
> Apr 26 23:17:31 thinkpad kernel: pccard: CardBus card inserted into slot 1
> Apr 26 23:18:13 thinkpad kernel: PCI: Enabling device 0000:06:00.0 (0000 -> 0003)
> Apr 26 23:18:13 thinkpad kernel: PCI: Setting latency timer of device 0000:06:00.0 to 64
> Apr 26 23:18:13 thinkpad kernel: eth1: Xircom cardbus revision 3 at irq 11
> Apr 26 23:19:31 thinkpad kernel: xircom cardbus adaptor found, registering as eth1, using irq 11
> Apr 26 23:19:52 thinkpad kernel: xircom_cb: Link status has changed
> Apr 26 23:19:52 thinkpad kernel: xircom_cb: Link is 100 mbit
> Apr 26 23:19:52 thinkpad kernel: xircom_cb: Link status has changed
> Apr 26 23:19:52 thinkpad kernel: xircom_cb: Link is 0 mbit
> Apr 26 23:19:54 thinkpad kernel: xircom_cb: Link status has changed

you should really check your cable; the card is flip-flopping between
link-nolink-link-nolink ...

that's either a cable bug or something like a mismatching duplex...
(well most of the time at least, in my experience)

