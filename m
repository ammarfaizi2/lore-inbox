Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262400AbTEIIuX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 04:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262385AbTEIIuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 04:50:23 -0400
Received: from outbound01.telus.net ([199.185.220.220]:20205 "EHLO
	priv-edtnes03-hme0.telusplanet.net") by vger.kernel.org with ESMTP
	id S262400AbTEIIuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 04:50:20 -0400
Subject: Re: 2.4.21-rc boot stalls
From: Bob Gill <gillb4@telusplanet.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1052392048.10038.9.camel@dhcp22.swansea.linux.org.uk>
References: <1052371307.2703.43.camel@localhost.localdomain> 
	<1052392048.10038.9.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 09 May 2003 03:04:22 -0600
Message-Id: <1052471062.2087.57.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-05-08 at 05:07, Alan Cox wrote:
> On Iau, 2003-05-08 at 06:21, Bob Gill wrote:
> > Hi. I just built 2.4.21-rc.  It hangs on boot.  More specifically, I
> > get: 
> > hda: (ide_dma_test_irq) called while not waiting
> > blk queue c031e840
> > I/O limit 4095 Mb (mask 0xffffffff)
> > setting using_dma_to 1 (on)
> 
> Do you have APIC support or ACPI enabled ?
> 
(from the build script)
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y

# CONFIG_HOTPLUG_PCI_ACPI is not set
# CONFIG_ACPI is not set

My motherboard has the SiS645 chipset.  
The SiS961 is the I/O APIC (ACPI 1.0b and APM 1.2 Compliant).

Currently my BIOS ACPI is set to suspend to standby (but I don't use it
and so haven't configured it in the kernel). 

I will rebuild the kernel with ACPI support and let you know the results
(later today...after sleep).

Thanks for your reply,

Bob 

