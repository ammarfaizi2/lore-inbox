Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268909AbUHMAYL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268909AbUHMAYL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 20:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268908AbUHMAYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 20:24:11 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:9693 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S268909AbUHMAYC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 20:24:02 -0400
Date: Fri, 13 Aug 2004 02:23:59 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Len Brown <len.brown@intel.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc4-mm1 doesn't boot
Message-ID: <20040813002358.GQ13377@fs.tum.de>
References: <566B962EB122634D86E6EE29E83DD808182C2B33@hdsmsx403.hd.intel.com> <1092259920.5021.117.camel@dhcppc4> <200408121550.15892.bjorn.helgaas@hp.com> <1092350580.7765.190.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092350580.7765.190.camel@dhcppc4>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2004 at 06:43:00PM -0400, Len Brown wrote:
>...
> Adrian, if you enable your not-present floppy in the BIOS,
> what does Linux do?

2.6.8-rc3-mm1 boots, 2.6.8-rc4-mm1 fails.

>From the 2.6.8-rc3-mm1 boot log:

<--  snip  -->

...
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
lp0: using parport0 (polling).
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M


--->> 2.6.8-rc4-mm1 stops here


floppy0: no floppy controllers found
loop: loaded (max 8 devices)
sis900.c: v1.08.07 11/02/2003
ACPI: PCI interrupt 0000:00:04.0[A] -> GSI 6 (level, low) -> IRQ 6
eth0: Realtek RTL8201 PHY transceiver found at address 1.
eth0: Using transceiver found at address 1 as default
eth0: SiS 900 PCI Fast Ethernet at 0xdc00, IRQ 6, 00:0b:6a:3b:93:a8.
...

<--  snip  -->

> thanks,
> -Len

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

