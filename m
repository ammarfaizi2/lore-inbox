Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290762AbSAYS3m>; Fri, 25 Jan 2002 13:29:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290763AbSAYS3c>; Fri, 25 Jan 2002 13:29:32 -0500
Received: from postal2.lbl.gov ([131.243.248.26]:19125 "EHLO postal2.lbl.gov")
	by vger.kernel.org with ESMTP id <S290762AbSAYS3P>;
	Fri, 25 Jan 2002 13:29:15 -0500
Message-ID: <3C51A1D7.74539585@lbl.gov>
Date: Fri, 25 Jan 2002 10:20:07 -0800
From: Thomas Davis <tadavis@lbl.gov>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Brian Lavender <brian@brie.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: VAIO IRQ assignment problem of USB controller
In-Reply-To: <20020124173421.B8732@brie.com> <20020125003306.A9759@brie.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Lavender wrote:
> 
> On Thu, Jan 24, 2002 at 05:34:21PM -0800, Brian Lavender wrote:
> > I have a Sony VAIO PCG-GR170K laptop with a memory stick which operates
> > off of the USB controller with device ID 00:1d.2. The laptop has a total
> > of three USB controllers.  The first two are getting IRQ's, but the third
> > one is not. Under Win2k, it assigns all three USB controllers IRQ 9. I
> > checked the bios for USB options, and the only option I could find is to
> > set a "Non PNP" OS.  I found no other USB options. I am currently using
> > kernel 2.4.9 from Redhat compiled from the source RPM.  I am guessing
> > that this must be a problem somewhere in the PCI IRQ configuration.
> > Any other suggestions aside from downloading 2.4.17?
> 
> I downloaded the 2.4.17-pre3 kernel from Redhat's site with their patches,
> and I compiled it. Still having the same problem with the IRQ. Below is
> what I get from lspci and dmesg. This time I did not pass the kernel
> pci=biosirq which I had done in the past. Is this something that the
> bios just isn't reporting or is there some sort of fix I can do?
> 

This is another device that Sony has decided to configure via ACPI.

You'll need to check out the Linux ACPI project, and see about getting
the ACPI IRQ routing patch.

No, I don't know where it's at exactly..  try using google.

-- 
------------------------+--------------------------------------------------
Thomas Davis		| ASG Cluster guy
tadavis@lbl.gov		| 
(510) 486-4524		| "80 nodes and chugging Captain!"
