Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267956AbTAMFcY>; Mon, 13 Jan 2003 00:32:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267961AbTAMFcY>; Mon, 13 Jan 2003 00:32:24 -0500
Received: from samar.sasken.com ([164.164.56.2]:6277 "EHLO samar.sasken.com")
	by vger.kernel.org with ESMTP id <S267956AbTAMFcX>;
	Mon, 13 Jan 2003 00:32:23 -0500
Date: Mon, 13 Jan 2003 11:11:04 +0530 (IST)
From: Madhavi <madhavis@sasken.com>
To: <linux-kernel@vger.kernel.org>
Subject: writel hang problem
Message-ID: <Pine.LNX.4.33.0301131108300.12085-100000@pcz-madhavis.sasken.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi

I am writing a device driver for a PCI device on linux 2.4.19 and i386
processor. I am initializing the memory mapped IO for this device in the
same way as it is shown in linux/drivers/net/pci-skeleton.c. I am using
readl and writel for accessing this PCI memory mapped IO.

The problem I am facing is -

When I try to write to a particular configuration register in this PCI MMIO
region, the system hangs. I am able to write properly and read back the
contents from other registers in this PCI MMIO region.

* Could anyone tell me why this might be happening?

* Could anyone tell me for what all reasons writel might hang?

When I request for an IRQ, I got an error which says:

"PCI: No IRQ known for interrupt pin A of device 00:e0.0. Using IRQ 11"

* Could this problem be related to the system hang problem in any way. Is this
IRQ problem fatal? I seem to be getting some interrupts from my device, though
they are not the same as expected.

Could anyone tell me what might be happening?

Thanks in advance.

regards
Madhavi.

