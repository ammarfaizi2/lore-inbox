Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965444AbWFYT4q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965444AbWFYT4q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 15:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965445AbWFYT4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 15:56:46 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:8782 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S965444AbWFYT4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 15:56:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=txf+8M4yCK8WNC5i5cSCI7SL7g0i+19PMwQDkXj3SSx4wP7CRypv4Ie6dacOVBTjvx3PwoOUsSIuEZ/M4scttGRC+q4l2tOiGgfh7FPochqTwQPGUQQ9Ed4Dr6rZam8838Yl9GLB1jrJ0MYrLx2owGNsSaKZOKbJnu6FKSv/zJQ=
Message-ID: <a44ae5cd0606251256m74182e7fw4eb2692c89b0e2f8@mail.gmail.com>
Date: Sun, 25 Jun 2006 12:56:44 -0700
From: "Miles Lane" <miles.lane@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: 2.6.17-mm2 -- drivers/built-in.o: In function `is_pci_dock_device':acpiphp_glue.c:(.text+0x12364): undefined reference to `is_dock_device'
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/built-in.o: In function
`is_pci_dock_device':acpiphp_glue.c:(.text+0x12364): undefined
reference to `is_dock_device'
drivers/built-in.o: In function
`cleanup_bridge':acpiphp_glue.c:(.text+0x12bc4): undefined reference
to `is_dock_device'
:acpiphp_glue.c:(.text+0x12bd3): undefined reference to
`unregister_hotplug_dock_device'
:acpiphp_glue.c:(.text+0x12bdb): undefined reference to
`unregister_dock_notifier'
drivers/built-in.o: In function
`register_slot':acpiphp_glue.c:(.text+0x13ac0): undefined reference to
`is_dock_device'
:acpiphp_glue.c:(.text+0x13cd9): undefined reference to `is_dock_device'
:acpiphp_glue.c:(.text+0x13cf0): undefined reference to
`register_hotplug_dock_device'
:acpiphp_glue.c:(.text+0x13d1d): undefined reference to `register_dock_notifier'
make: *** [.tmp_vmlinux1] Error 1

#
# PCI Hotplug Support
#
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_FAKE=y
CONFIG_HOTPLUG_PCI_COMPAQ=y
# CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM is not set
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=y
CONFIG_HOTPLUG_PCI_CPCI=y
# CONFIG_HOTPLUG_PCI_CPCI_ZT5550 is not set
CONFIG_HOTPLUG_PCI_CPCI_GENERIC=y
CONFIG_HOTPLUG_PCI_SHPC=y
# CONFIG_HOTPLUG_PCI_SHPC_POLL_EVENT_MODE is not set
