Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261281AbUJaQ0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261281AbUJaQ0E (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 11:26:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbUJaQ0E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 11:26:04 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:27824 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261281AbUJaQZy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 11:25:54 -0500
Subject: Re: HP C2502 SCSI card (NCR 53C400A based) not working
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ondrej Zary <linux@rainbow-software.org>
Cc: ingmar@gonzo.schwaben.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4184D8EB.6000306@rainbow-software.org>
References: <4184D8EB.6000306@rainbow-software.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1099236179.16385.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 31 Oct 2004 15:23:03 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2004-10-31 at 12:22, Ondrej Zary wrote:
> Hello,
> I have an old ISA SCSI card that came with HP ScanJet IIP scanner. It's
> HP C2502 card based on NCR 53C400A chip. I was unable to get it working
> with g_NCR5380 driver so I tried loading the official MINI400I.SYS
> driver in DOSemu. I was surprised that the values sent to the ports are 
> not the same as in the g_NCR5380 driver.

It should work in 2.4 providing you use the loading options for
ncr53c400a and set a port and no IRQ (read mine did). What options are
you trying ?

> According to this, I think that my card has the 53C400A chip registers 
> mapped to different addresses (offsets) but I'm unable to determine what 
> the mapping is. I was also unable to find the 53C400A datasheet which 
> might help a bit.

The 53c400a can be programming to an address by software - either by
magic sequences or I believe according to pin strapping by ISAPnP.
Its been a long time since I touched such junk however and if you want
to do anything useful with your computer while scanning (like waving the
mouse point around) get something else!

