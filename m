Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313786AbSDUThQ>; Sun, 21 Apr 2002 15:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313787AbSDUThP>; Sun, 21 Apr 2002 15:37:15 -0400
Received: from natwar.webmailer.de ([192.67.198.70]:43632 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S313786AbSDUThO>; Sun, 21 Apr 2002 15:37:14 -0400
Content-Type: text/plain; charset=US-ASCII
From: Dominik Brodowski <devel@brodo.de>
To: josh@stack.nl
Subject: Re: [BUG] 2.5.8: ACPI: PCI IRQ remapping goes wrong.
Date: Sun, 21 Apr 2002 21:34:25 +0200
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <02042121333100.02835@sonnenschein>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jos:

Using IO[S]APIC and ACPI_BOOT is broken in 2.5.8 and the acpi-patches 
acpi-20020404 and acpi-20020419. The ACPI SMP booting code is re-worked, and 
so this problem should be resolved soon. FYI, acpi-20020419 informs you of 
this in a nice kernel panic.

Dominik

On 2002-04-20 8:23:22 Jos Hulzink wrote:
> My SCSI card didn't work anymore, my NIC was unable to connect and my SB
> Live! didn't work anymore. I thought 2.5.8 was a huge mess :)
> 
> Anyway: ACPI sets up IRQ remapping to IRQs > 15, but all PCI devices claim
> the old =< 15 IRQ's. My guess is that the ACPI code doesn't update the pci
> irq data.
>
> If it matters: The system I talk about is a dual PII 333, on an Intel LX
> chipset. 2.5.6 did boot fine.
>
> Jos
