Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268344AbUHKXUQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268344AbUHKXUQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 19:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268308AbUHKXRi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 19:17:38 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:53715 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S268314AbUHKXPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 19:15:49 -0400
Date: Thu, 12 Aug 2004 01:15:46 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Len Brown <len.brown@intel.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc4-mm1 doesn't boot
Message-ID: <20040811231546.GT26174@fs.tum.de>
References: <566B962EB122634D86E6EE29E83DD808182C2B33@hdsmsx403.hd.intel.com> <1092259920.5021.117.camel@dhcppc4> <20040811215105.GK26174@fs.tum.de> <1092262929.7765.132.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092262929.7765.132.camel@dhcppc4>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2004 at 06:22:09PM -0400, Len Brown wrote:

> Does the system have any BIOS settings to enable/disable the floppy?

Yes, the settings for both floppies are set to "Not Installed".

> Is the floppy physically present on the system?

No.

> ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 *6 7 10 11 12 14 15)
>         ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 6
> 
> I assert it is a BIOS bug for the BIOS to set LNKD to
> IRQ6 if there is a floppy present and enabled; but fair
> game if there is no floppy.  Though perhaps floppy.c
> doesn't understand that.
> 
> -Len

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

