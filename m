Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263410AbTDMKLF (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 06:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263411AbTDMKLF (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 06:11:05 -0400
Received: from 82-41-208-76.cable.ubr12.edin.blueyonder.co.uk ([82.41.208.76]:4224
	"EHLO savagelandz.cjb.net") by vger.kernel.org with ESMTP
	id S263410AbTDMKLE (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 13 Apr 2003 06:11:04 -0400
Message-ID: <36716.192.18.240.6.1050229446.squirrel@savagelandz.cjb.net>
Date: Sun, 13 Apr 2003 11:24:06 +0100 (BST)
Subject: PCI: Device 02:04.0 not available because of resource collisions
From: <iain@savagelandz.cjb.net>
To: <linux-kernel@vger.kernel.org>
X-Priority: 3
Importance: Normal
X-Mailer: SquirrelMail (version 1.2.11)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kernel Developers,

I have been trying to get this Texas Instruments PCI1410 PC card Cardbus
Controller to work in a l440gx+ based SMP system. However whenever pcmcia
tries to start I get the following

* Starting pcmcia...
cardmgr[5854]: no sockets found!
 * cardmgr failed to start.  Make sure that you have PCMCIA
 * modules built or support compiled into the kernel

A look in the system log reveals the following

Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
PCI: Device 02:04.0 not available because of resource collisions

This error occurs with both 2.5.66 and 2.5.67. I submitted this query to
David Hinds on the PCMCIA forum and he suggested that I should bring this
to you guys.

I also recieved similar errors under 2.4.20. This kernel was patched with
the xfs patches from SGI. Ihave tried this with both the in-kernel pcmcia
and the drivers from the the pcmcia-cs package but the same is always
recieved.

What other information do you need? I'm afraid I'm not really a programmer
and the insides of the kernel are a bit beyond me.

Anyway any help would be greatly appreciated.

Cheers

iain



