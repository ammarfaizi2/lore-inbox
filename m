Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932181AbWHHKBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbWHHKBj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 06:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932432AbWHHKBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 06:01:39 -0400
Received: from kunzite.stewarts.org.uk ([80.68.93.148]:16141 "EHLO
	kunzite.stewarts.org.uk") by vger.kernel.org with ESMTP
	id S932181AbWHHKBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 06:01:39 -0400
Date: Tue, 8 Aug 2006 11:01:37 +0100
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Only 3.2G ram out of 4G seen in an i386 box
Message-ID: <20060808100137.GA5233@stewarts.org.uk>
References: <200608080913.k789D0fC019037@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608080913.k789D0fC019037@harpo.it.uu.se>
User-Agent: Mutt/1.5.9i
From: Thomas Stewart <thomas@stewarts.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2006 at 11:13:00AM +0200, Mikael Pettersson wrote:
> Most likely the BIOS is reserving large parts of the [0,4GB[ range for
> PCI devices and some for itself. Please post the E820 memory map the
> kernel prints near the start of the boot sequence on your machine.

Linux version 2.6.16-2-686 (Debian 2.6.16-17) (waldi@debian.org) (gcc version 4.6BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000cfe86c00 (usable)
 BIOS-e820: 00000000cfe86c00 - 00000000cfe88c00 (ACPI NVS)
 BIOS-e820: 00000000cfe88c00 - 00000000cfe8ac00 (ACPI data)
 BIOS-e820: 00000000cfe8ac00 - 00000000d0000000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fed00400 (reserved)
 BIOS-e820: 00000000fed20000 - 00000000feda0000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fef00000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
2174MB HIGHMEM available.
1152MB LOWMEM available.

Linux version 2.6.18-rc3-git3-ts1 (root@coke) (gcc version 4.0.4 20060507 (prer6BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000cfe86c00 (usable)
 BIOS-e820: 00000000cfe86c00 - 00000000cfe88c00 (ACPI NVS)
 BIOS-e820: 00000000cfe88c00 - 00000000cfe8ac00 (ACPI data)
 BIOS-e820: 00000000cfe8ac00 - 00000000d0000000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fed00400 (reserved)
 BIOS-e820: 00000000fed20000 - 00000000feda0000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fef00000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
2430MB HIGHMEM available.
896MB LOWMEM available.

Linux version 2.6.18-rc2-mm1-ts1 (root@coke) (gcc version 4.0.4 20060507 (prere6BIOS-provided physical RAM map:
sanitize start
sanitize end
copy_e820_map() start: 0000000000000000 size: 00000000000a0000 end: 000000000001copy_e820_map() type is E820_RAM
copy_e820_map() start: 00000000000f0000 size: 0000000000010000 end: 000000000012copy_e820_map() start: 0000000000100000 size: 00000000cfd86c00 end: 00000000cfe1copy_e820_map() type is E820_RAM
copy_e820_map() start: 00000000cfe86c00 size: 0000000000002000 end: 00000000cfe4copy_e820_map() start: 00000000cfe88c00 size: 0000000000002000 end: 00000000cfe3copy_e820_map() start: 00000000cfe8ac00 size: 0000000000175400 end: 00000000d002copy_e820_map() start: 00000000e0000000 size: 0000000010000000 end: 00000000f002copy_e820_map() start: 00000000fec00000 size: 0000000000100400 end: 00000000fed2copy_e820_map() start: 00000000fed20000 size: 0000000000080000 end: 00000000fed2copy_e820_map() start: 00000000fee00000 size: 0000000000100000 end: 00000000fef2copy_e820_map() start: 00000000ffb00000 size: 0000000000500000 end: 000000010002 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000cfe86c00 (usable)
 BIOS-e820: 00000000cfe86c00 - 00000000cfe88c00 (ACPI NVS)
 BIOS-e820: 00000000cfe88c00 - 00000000cfe8ac00 (ACPI data)
 BIOS-e820: 00000000cfe8ac00 - 00000000d0000000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fed00400 (reserved)
 BIOS-e820: 00000000fed20000 - 00000000feda0000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fef00000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
2430MB HIGHMEM available.
896MB LOWMEM available.

Regards
--
Tom
