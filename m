Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315595AbSFEQwM>; Wed, 5 Jun 2002 12:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315606AbSFEQwL>; Wed, 5 Jun 2002 12:52:11 -0400
Received: from jffdns02.or.intel.com ([134.134.248.4]:61387 "EHLO
	hebe.or.intel.com") by vger.kernel.org with ESMTP
	id <S315595AbSFEQwK>; Wed, 5 Jun 2002 12:52:10 -0400
Message-ID: <59885C5E3098D511AD690002A5072D3C02AB7EDC@orsmsx111.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Joseph Pingenot'" <trelane@digitasaru.net>, linux-kernel@vger.kernel.org
Subject: RE: And one last build error (2.5.20)
Date: Wed, 5 Jun 2002 09:52:01 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Joseph Pingenot [mailto:trelane@digitasaru.net] 
> when making modules_install:
> make[1]: Leaving directory 
> `/usr/local/src/kernel/linux-2.5.20/arch/i386/pci'
> if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.20; fi
> depmod: *** Unresolved symbols in 
> /lib/modules/2.5.20/kernel/drivers/acpi/thermal.o
> depmod:         acpi_processor_set_thermal_limit
> make: [_modinst_post] Error 1 (ignored)

Whups, acpi_processor_set_thermal_limit needs to be listed in acpi_ksyms.c.

-- Andy
