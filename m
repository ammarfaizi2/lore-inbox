Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315239AbSFCMdc>; Mon, 3 Jun 2002 08:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315300AbSFCMdb>; Mon, 3 Jun 2002 08:33:31 -0400
Received: from [213.196.40.44] ([213.196.40.44]:64465 "EHLO blackstar.nl")
	by vger.kernel.org with ESMTP id <S314080AbSFCMd3>;
	Mon, 3 Jun 2002 08:33:29 -0400
Date: Mon, 3 Jun 2002 14:03:17 +0200 (CEST)
From: <bvermeul@devel.blackstar.nl>
To: <linux-kernel@vger.kernel.org>
Subject: [2.5.20] RTL8139 cardbus not found
Message-ID: <Pine.LNX.4.33.0206031358280.24283-100000@devel.blackstar.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've compiled 8139too into the kernel, but the driver isn't started
when I insert my cardbus card.

I get the following messages:

Jun  3 14:00:03 laptop kernel: cs: cb_alloc(bus 4): vendor 0x10ec, device 0x8139
Jun  3 14:00:03 laptop kernel: PCI: Enabling device 04:00.0 (0000 -> 0003)
Jun  3 14:00:03 laptop cardmgr[540]: initializing socket 1
Jun  3 14:00:03 laptop cardmgr[540]: unsupported card in socket 1
Jun  3 14:00:03 laptop /etc/hotplug/pci.agent: ... no modules for PCI slot 04:00.0
Jun  3 14:00:03 laptop cardmgr[540]:   product info: "Realtek", "Rtl8139"
Jun  3 14:00:03 laptop cardmgr[540]:   function: 6 (network)
Jun  3 14:00:03 laptop cardmgr[540]:   PCI id: 0x10ec, 0x8139

hotplug can't find a driver for the card (which isn't suprising, since 
it's built-in).

Anyone got an idea? In 2.5.19 the kernel just gave me an oops
when it came to the point that it saw the cardbus card.

Regards,

Bas Vermeulen

-- 
"God, root, what is difference?" 
	-- Pitr, User Friendly

"God is more forgiving." 
	-- Dave Aronson


