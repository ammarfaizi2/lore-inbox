Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262462AbUCEK50 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 05:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262476AbUCEK50
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 05:57:26 -0500
Received: from smtp1.infineon.com ([194.175.117.76]:64664 "EHLO
	smtp1.infineon.com") by vger.kernel.org with ESMTP id S262462AbUCEK45
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 05:56:57 -0500
Date: Fri, 5 Mar 2004 11:56:41 +0100 (MET)
From: Florian Krueger <tdsc.fkr@infineon.com>
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>
cc: linux-kernel@vger.kernel.org
Subject: Re: Silent Northbridge MCE Messages / Kernel 2.4.21-9.0.1.ELsmp
In-Reply-To: <200403051056.39452.vda@port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.GSO.4.20.0403051142050.25375-100000@balu.muc.infineon.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Mar 2004, vda wrote:

> On Friday 05 March 2004 09:52, Florian Krueger wrote:
> > Northbridge Machine Check exception b60000010005001b 0
> > Uncorrectable condition
> > Unrecoverable condition
> .......
> > We aren't able to reproduce the crashes with the new Kernel but have more
> > and more Messages in Kernel log like this:
> >
> > CPU 1: Silent Northbridge MCE
> > Northbridge status a60000010005001b
> >     GART TLB error generic level generic
> 
> Do you use AGP? AFAIK GART is an AGP thing. Can you disable AGP
> and plug in PCI video?

The machines run in a HPC Compute Cluster. Graphics is on Board. No
Graphical Login is configured. Machines are running Simulations over
Network Cluster. We don't have PCI Graphic Cards available.

Boot shows following:

Mar  1 16:13:25 localhost kernel: Linux agpgart interface v0.99 (c) Jeff
Hartmann
Mar  1 16:13:25 localhost kernel: agpgart: Maximum main memory to use for
agp
memory: 5944M
Mar  1 16:13:25 localhost kernel: PCI-DMA: Disabling AGP.
Mar  1 16:13:25 localhost kernel: PCI-DMA: aperture base @ c000000 size
65536
KB
Mar  1 16:13:25 localhost kernel: PCI-DMA: Reserving 64MB of IOMMU area in
the AGP aperture

> 
> Also, did you run memtest86? I don't know whether it
> supports AMD64 and >4Gb mem, but maybe it does.
> --
> vda
> 

Cheers

florian krueger
> 

Dipl. Informatiker Florian Krueger       science+computing ag
Contact at Infineon Technologies
Phone  +49-89-234-20167
Mobile +49-171-317-5441
email  tdsc.fkr@infineon.com

