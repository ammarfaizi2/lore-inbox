Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267818AbUHUUl5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267818AbUHUUl5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 16:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267817AbUHUUkH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 16:40:07 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:38357 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S267811AbUHUUjy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 16:39:54 -0400
Date: Sat, 21 Aug 2004 09:50:24 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Kjartan Maraas <kmaraas@broadpark.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops on suspend/resume
Message-ID: <20040821075023.GA603@openzaurus.ucw.cz>
References: <1092862850.7890.3.camel@home.gnome.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092862850.7890.3.camel@home.gnome.no>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I got this when trying out suspend/resume on a HP NC8000 laptop. The
> kernel is one of the latest from fedora development, 2.6.8-rc4-bk4 or
> something based.

Its not oops. Try disabling preempt.

				Pavel


> Aug 18 22:24:50 home kernel: Badness in ide_wait_not_busy at
> drivers/ide/ide-iops.c:1278
> Aug 18 22:24:50 home kernel:  [<02251a02>] ide_wait_not_busy+0x4b/0x7d
> Aug 18 22:24:50 home kernel:  [<0224f500>] start_request+0xb8/0x1b9
> Aug 18 22:24:50 home kernel:  [<0224f8c2>] ide_do_request+0x2a7/0x36a
> Aug 18 22:24:50 home kernel:  [<02250273>] ide_intr+0x3c2/0x450
> Aug 18 22:24:50 home kernel:  [<022557bb>] ide_dma_intr+0x0/0x7a
> Aug 18 22:24:50 home kernel:  [<0210782f>] handle_IRQ_event+0x21/0x41
> Aug 18 22:24:51 home kernel:  [<02107d2e>] do_IRQ+0x1be/0x303
> Aug 18 22:24:51 home kernel:  =======================
> Aug 18 22:24:51 home kernel:  [<021fc4c1>] acpi_processor_idle
> +0xd3/0x1c5
> Aug 18 22:24:51 home kernel:  [<0210408c>] cpu_idle+0x1f/0x34
> Aug 18 22:24:51 home kernel:  [<0239b6ae>] start_kernel+0x221/0x224
> Aug 18 22:24:51 home kernel: Restarting tasks... done
> Aug 18 22:24:51 home kernel: tg3: eth0: Link is up at 100 Mbps, full
> duplex.
> Aug 18 22:24:51 home kernel: tg3: eth0: Flow control is on for TX and on
> for RX.
> 

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

