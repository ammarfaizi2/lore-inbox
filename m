Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282904AbRLGSN6>; Fri, 7 Dec 2001 13:13:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281719AbRLGSNt>; Fri, 7 Dec 2001 13:13:49 -0500
Received: from fmr01.intel.com ([192.55.52.18]:31468 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S282904AbRLGSNi>;
	Fri, 7 Dec 2001 13:13:38 -0500
Message-ID: <59885C5E3098D511AD690002A5072D3C42D7C3@orsmsx111.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Patrick Mochel'" <mochel@osdl.org>, Cory Bell <cory.bell@usa.net>
Cc: linux-kernel@vger.kernel.org
Subject: RE: IRQ Routing Problem on ALi Chipset Laptop (HP Pavilion N5425)
Date: Fri, 7 Dec 2001 10:13:25 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Patrick Mochel [mailto:mochel@osdl.org]
> The Intel ACPI guys kinda have this working. They are able to 
> extract and
> execute the methods. But, they still have yet to make devices 
> request and
> use that information. Maybe Andy Grover can comment on this..
> 
> BTW, The latest ACPI patch is at: 
> http://sourceforge.net/projects/acpi/.

Exactly right. Our current patch will print a nice list for each PCI to PCI
bridge, but pci-irq.c isn't actually using the data yet on IA32. (IA64 does
use _PRT data.) We'll get around to doing this (eventually) but it would
happen sooner if someone else stepped up and lent a hand...

Regards -- Andy
