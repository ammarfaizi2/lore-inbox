Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292929AbSBVTAK>; Fri, 22 Feb 2002 14:00:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292933AbSBVTAA>; Fri, 22 Feb 2002 14:00:00 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:3846 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292929AbSBVS7y>; Fri, 22 Feb 2002 13:59:54 -0500
Subject: Re: AMD 760 Dual MP support in 2.2.20
To: nick@guardiandigital.com (Nick DeClario)
Date: Fri, 22 Feb 2002 19:14:21 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C768E10.B05DDA53@guardiandigital.com> from "Nick DeClario" at Feb 22, 2002 01:29:36 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16eL9B-0002q0-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am working with a client trying to get a 2.2.20 kernel to work on a
> Asus A7M266-D Revision 1.04 motherboard (Award Bios v6.0, Revision 1004)
> with a single Athlon MP 1500.  

To get SMP working you will almost certainly neee 2.4

> The system boots buts recognizes none of the hardware except for a
> Promise Fastrack 100 controller and an Intel eepro100.  /proc/pci
> displays everything as an Unknown device.

That is fine - use lspci.

> I checked the recent change logs for the 2.2.21 pre 1 and pre 2 kernel
> patches and didn't see anything regarding the AMD 760.  Is this a known

All the AMD 760 work is being done in the 2.4 series. I have no plan to
backport anything but the BIOS fixups to 2.2. You should still get basic
slow PIO IDE from the onboard IDE and nothing should fail outright though.

Alan
