Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750719AbWDZXFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbWDZXFF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 19:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbWDZXFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 19:05:05 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:2530 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1750719AbWDZXFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 19:05:04 -0400
From: Grant Coady <gcoady.lk@gmail.com>
To: Karel Gardas <kgardas@objectsecurity.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.16.11] Xircom RealPort RBEM56G-100 link change issue
Date: Thu, 27 Apr 2006 09:05:23 +1000
Organization: http://bugsplatter.mine.nu/
Message-ID: <jnuv42pk5jtqvn21sgqs1l6qf555fjjrvf@4ax.com>
References: <Pine.LNX.4.63.0604262337530.3859@silence.gardas.net>
In-Reply-To: <Pine.LNX.4.63.0604262337530.3859@silence.gardas.net>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Apr 2006 23:46:27 +0200 (CEST), Karel Gardas <kgardas@objectsecurity.com> wrote:

>
>Hello,
>
>I'm trying to get working linux with Xircom RealPort CardBus Ethernet 
>10/100+Modem 56 PCMCIA card. I only need ethernet working. The problem 
>with this is that I'm losing too many packets while syslog is filled with 
>messages like:
>
>Apr 26 23:17:31 thinkpad kernel: pccard: CardBus card inserted into slot 1
>Apr 26 23:18:13 thinkpad kernel: PCI: Enabling device 0000:06:00.0 (0000 -> 0003)
>Apr 26 23:18:13 thinkpad kernel: PCI: Setting latency timer of device 0000:06:00.0 to 64
>Apr 26 23:18:13 thinkpad kernel: eth1: Xircom cardbus revision 3 at irq 11
>Apr 26 23:19:31 thinkpad kernel: xircom cardbus adaptor found, registering as eth1, using irq 11
>Apr 26 23:19:52 thinkpad kernel: xircom_cb: Link status has changed
>Apr 26 23:19:52 thinkpad kernel: xircom_cb: Link is 100 mbit

I use same driver with Xircom RBE-100, no problems, .config + dmesg on 
  http://bugsplatter.mine.nu/test/boxen/tosh/

The xircom_cb driver on 2.6.16.11 is okay here.

Grant.
