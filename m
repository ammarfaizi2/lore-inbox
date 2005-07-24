Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261372AbVGXPNV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261372AbVGXPNV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 11:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261378AbVGXPNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 11:13:21 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:50112 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261372AbVGXPNQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 11:13:16 -0400
Date: Sun, 24 Jul 2005 17:13:05 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: Pierre Ossman <drzeus-list@drzeus.cx>, LKML <linux-kernel@vger.kernel.org>,
       Greg Kroah-Hartman <greg@kroah.com>
Subject: Re: IRQ routing problem in 2.6.10-rc2
In-Reply-To: <9a87484905072407164f0e0eb5@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0507241711040.11580@yvahk01.tjqt.qr>
References: <42E395F6.8070301@drzeus.cx> <9a87484905072407164f0e0eb5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> PCI: Using ACPI for IRQ routing
>> ** PCI interrupts are no longer routed automatically.  If this
>> ** causes a device to stop working, it is probably because the
>> ** driver failed to call pci_enable_device().  As a temporary
>> ** workaround, the "pci=routeirq" argument restores the old
>> ** behavior.  If this argument makes the device work again,
>> ** please email the output of "lspci" to bjorn.helgaas@hp.com
>> ** so I can fix the driver.
>Have you tried the suggestion given "... As a temporary workaround,
>the "pci=routeirq" argument..." ?
>You could also try the pci=noacpi boot option to see if that changes anything.

Hi,

and what's the proper fix for pci=routeirq? I got a driver that is only 
maintained by myself and would like to fix up the issue.



Jan Engelhardt
-- 
