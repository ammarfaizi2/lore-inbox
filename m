Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263230AbTHWUCb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 16:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263944AbTHWUCa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 16:02:30 -0400
Received: from adsl-217-226.38-151.net24.it ([151.38.226.217]:15883 "EHLO
	gateway.milesteg.arr") by vger.kernel.org with ESMTP
	id S263230AbTHWUCX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 16:02:23 -0400
Date: Sat, 23 Aug 2003 22:02:20 +0200
From: Daniele Venzano <webvenza@libero.it>
To: Matthew Wilcox <willy@debian.org>
Cc: acpi-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [ACPI] Invalid PBLK length for athlon XP-M on Asus laptop
Message-ID: <20030823200220.GA914@renditai.milesteg.arr>
Mail-Followup-To: Matthew Wilcox <willy@debian.org>,
	acpi-devel@lists.sourceforge.net,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030823125812.GC913@renditai.milesteg.arr> <20030823173423.GQ18834@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030823173423.GQ18834@parcelfarce.linux.theplanet.co.uk>
X-Operating-System: Debian GNU/Linux on kernel Linux 2.4.21
X-Copyright: Forwarding or publishing without permission is prohibited.
X-Truth: La vita e' una questione di culo, o ce l'hai o te lo fanno.
X-GPG-Fingerprint: 642A A345 1CEF B6E3 925C  23CE DAB9 8764 25B3 57ED
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 23, 2003 at 06:34:23PM +0100, Matthew Wilcox wrote:
> > [.....]
> > ACPI: Fan [FAN0] (on)
> > acpi_processor-1626 [30] acpi_processor_get_inf: Invalid PBLK length [5]
> 
> This is a bug in your ACPI bios, you need a vendor update.  We tried
> fixing this but it broke a number of laptops, so we had to revert it.

I already have the latest bios according to Asus site. 
I sent a complain to Asus support, we'll see...

Those fixes can still be found somewhere ? I'd like to play with them.

> > NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> > acpi_processor_perf-0104 [28] acpi_processor_get_per: Unsupported address space [127] (control_register)
> > cpufreq: No CPUs supporting ACPI performance management found.
> 
> That means that you need a non-acpi driver for perf throttling.  Did you
> try enabling some of the other cpufreq drivers?

I tried with the P-state driver compiled in with the Athlon driver, or
only with the Athlon driver without P-state. The result is the same,
when I try to set a governor through sysfs the system freezes and a
hard reset is required.
However without P-state driver the above message disappers.

So I'm getting neither scaling or throttling... it's not much a surprise
that the battery was discharging at that rate...

-- 
----------------------------------------
Daniele Venzano
Web: http://digilander.iol.it/webvenza/

