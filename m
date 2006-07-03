Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750840AbWGCLBH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750840AbWGCLBH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 07:01:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750863AbWGCLBH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 07:01:07 -0400
Received: from tornado.reub.net ([202.89.145.182]:31724 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S1750840AbWGCLBG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 07:01:06 -0400
Message-ID: <44A8F8D2.1030101@reub.net>
Date: Mon, 03 Jul 2006 23:00:34 +1200
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 3.0a1 (Windows/20060701)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, greg@kroah.com, brice@myri.com
Subject: Re: 2.6.17-mm6
References: <20060703030355.420c7155.akpm@osdl.org>
In-Reply-To: <20060703030355.420c7155.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/07/2006 10:03 p.m., Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm6/
> 
> 
> - A major update to the e1000 driver.
> 
> - 1394 updates


audit: initializing netlink socket (disabled)
audit(1151924044.008:1): initialized
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered (default)
PCI: Setting latency timer of device 0000:00:1c.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.0:pcie0]
Allocate Port Service[0000:00:1c.0:pcie0]
kobject_add failed for 0000:00:1c.0:pcie0 with -EEXIST, don't try to register 
things with the same name in the same directory.

Call Trace:
  [<ffffffff80358298>] kobject_put+0x19/0x21
  [<ffffffff80358741>] kobject_add+0x181/0x1ac
  [<ffffffff803aa378>] device_add+0x88/0x4b9
  [<ffffffff803aa7c2>] device_register+0x19/0x27
  [<ffffffff80363e90>] pcie_port_device_register+0x3a0/0x3de
  [<ffffffff8042fa10>] pcibios_set_master+0x7f/0x86
  [<ffffffff80364004>] pcie_portdrv_probe+0x64/0x80
  [<ffffffff803612ac>] pci_device_probe+0x4d/0x78
  [<ffffffff803ac08f>] driver_probe_device+0x5c/0xb4
  [<ffffffff803ac1c9>] __driver_attach+0x67/0xb9
  [<ffffffff803ac162>] __driver_attach+0x0/0xb9
  [<ffffffff803aba4f>] bus_for_each_dev+0x4f/0x79
  [<ffffffff803abfbc>] driver_attach+0x1c/0x1e
  [<ffffffff803ab61a>] bus_add_driver+0x7a/0x143
  [<ffffffff803ac463>] driver_register+0x9f/0xa6
  [<ffffffff80361497>] __pci_register_driver+0x59/0x7e
  [<ffffffff806b7a57>] pcie_portdrv_init+0x1c/0x30
  [<ffffffff80267f3e>] init+0x14e/0x2d0
  [<ffffffff80260a12>] child_rip+0x8/0x12
  [<ffffffff80267df0>] init+0x0/0x2d0
  [<ffffffff80260a0a>] child_rip+0x0/0x12

The trace shows up 5 times in quick succession, all traces looking the same.......

Box otherwise boots up OK.

reuben


