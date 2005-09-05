Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751248AbVIENGx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbVIENGx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 09:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbVIENGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 09:06:53 -0400
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:48145 "EHLO
	roarinelk.homelinux.net") by vger.kernel.org with ESMTP
	id S1751248AbVIENGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 09:06:53 -0400
Date: Mon, 5 Sep 2005 15:06:43 +0200
From: Manuel Lauss <mano@roarinelk.homelinux.net>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.13 repeated ACPI events?
Message-ID: <20050905130643.GA30428@roarinelk.homelinux.net>
References: <Pine.LNX.4.63.0509050853310.3389@p34>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0509050853310.3389@p34>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2005 at 08:54:59AM -0400, Justin Piszcz wrote:
> I have a box where I keep getting this in dmesg:
> 
> ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKD] -> GSI 5 (level, low) 
> -> IRQ 5
> ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKD] -> GSI 5 (level, low) 
> -> IRQ 5
> ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKD] -> GSI 5 (level, low) 
> -> IRQ 5
> ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKD] -> GSI 5 (level, low) 
> -> IRQ 5
> ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKD] -> GSI 5 (level, low) 
> -> IRQ 5
> ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKD] -> GSI 5 (level, low) 
> -> IRQ 5
> ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKD] -> GSI 5 (level, low) 
> -> IRQ 5
> ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKD] -> GSI 5 (level, low) 
> -> IRQ 5

> 01:00.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone]
> 01:04.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] 

I have a 3c905B nic that was sometimes enumerated up to 15 times (Intel
BX Chipset)
Plugging the thing out of its pci socket and back in always cured it.

maybe yours suffers from the same "bug" ?

-- 
 Manuel Lauss
