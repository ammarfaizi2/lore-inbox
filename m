Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261197AbULDXsZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbULDXsZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 18:48:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261198AbULDXsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 18:48:25 -0500
Received: from main.gmane.org ([80.91.229.2]:4528 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261197AbULDXsV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 18:48:21 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Paul Ionescu <i_p_a_u_l@yahoo.com>
Subject: Re: Linux 2.6.10-rc3
Date: Sun, 05 Dec 2004 01:48:04 +0200
Message-ID: <pan.2004.12.04.23.48.03.367311@yahoo.com>
References: <Pine.LNX.4.58.0412031611460.22796@ppc970.osdl.org> <pan.2004.12.04.09.06.09.707940@nn7.de> <87oeha6lj1.fsf@sycorax.lbl.gov> <cosrt1$j67$1@sea.gmane.org> <87eki66jx8.fsf@sycorax.lbl.gov> <1102195032.1560.58.camel@tux.rsn.bth.se> <877jnxago0.fsf@sycorax.lbl.gov> <Pine.LNX.4.58.0412042241070.13328@tux.rsn.bth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: home-33027.b.astral.ro
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity.)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 04 Dec 2004 22:42:11 +0100, Martin Josefsson wrote:
> That's an usb2.0 bug, the ehci driver sleeps when it can't sleep.

I have the message bellow without ehci-hcd module loaded, so I took out
USB2 problem, but this one I don't know what it means:


Warning: CPU frequency is 1700000, cpufreq assumed 600000 kHz.
Debug: sleeping function called from invalid context at mm/slab.c:2063
in_atomic():0[expected: 0], irqs_disabled():1
 [<0211cbcb>] __might_sleep+0x7d/0x8a
 [<0214bf9f>] __kmalloc+0x42/0x7d
 [<021f48e9>] acpi_os_allocate+0xa/0xb
 [<0220878a>] acpi_ut_allocate+0x2e/0x52
 [<02208721>] acpi_ut_initialize_buffer+0x41/0x7c
 [<02205474>] acpi_rs_create_byte_stream+0x23/0x3b
 [<02206976>] acpi_rs_set_srs_method_data+0x1b/0x9d
 [<0211b101>] recalc_task_prio+0x128/0x133
 [<0220e15c>] acpi_pci_link_set+0xfe/0x176
 [<0220e4e0>] irqrouter_resume+0x1c/0x24
 [<0224366a>] sysdev_resume+0x3e/0xa5
 [<02246564>] device_power_up+0x5/0xa
 [<0213db9a>] suspend_enter+0x25/0x2d
 [<0213dc08>] enter_state+0x3f/0x5e
 [<0220ad54>] acpi_suspend+0x28/0x34
 [<0220b7c4>] acpi_system_write_sleep+0x5c/0x6d
 [<02179769>] locate_fd+0x5c/0x78
 [<02165c82>] vfs_write+0xb6/0xe2
 [<02165d4c>] sys_write+0x3c/0x62
PCI: Setting latency timer of device 0000:00:1d.0 to 64


