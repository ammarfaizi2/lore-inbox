Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262353AbVAEMPe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262353AbVAEMPe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 07:15:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262356AbVAEMPe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 07:15:34 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15844 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262353AbVAEMP0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 07:15:26 -0500
Date: Wed, 5 Jan 2005 07:42:36 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Marek Habersack <grendel@caudium.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Very high load on P4 machines with 2.4.28
Message-ID: <20050105094236.GG10036@logos.cnet>
References: <20050104195636.GA23034@beowulf.thanes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050104195636.GA23034@beowulf.thanes.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2005 at 08:56:36PM +0100, Marek Habersack wrote:
> Hello,
> 
>  We have several machines with similar configurations
> 
> 0000:00:00.0 Host bridge: Intel Corp. 82875P Memory Controller Hub (rev 02)
> 0000:00:01.0 PCI bridge: Intel Corp. 82875P Processor to AGP Controller (rev 02)
> 0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev c2)
> 0000:00:1f.0 ISA bridge: Intel Corp. 82801EB/ER (ICH5/ICH5R) LPC Bridge (rev 02)
> 0000:00:1f.2 IDE interface: Intel Corp. 82801EB (ICH5) Serial ATA 150 Storage Controller (rev 02)
> 0000:00:1f.3 SMBus: Intel Corp. 82801EB/ER (ICH5/ICH5R) SMBus Controller (rev 02)
> 0000:02:09.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
> 0000:02:0a.0 Ethernet controller: Intel Corp. 82541EI Gigabit Ethernet Controller (Copper)
> 0000:02:0b.0 Ethernet controller: Intel Corp. 82541EI Gigabit Ethernet Controller (Copper)
> 
> and
> 
> 0000:00:00.0 Host bridge: Intel Corp. 82845G/GL[Brookdale-G]/GE/PE DRAM Controller/Host-Hub Interface (rev 03)
> 0000:00:02.0 VGA compatible controller: Intel Corp. 82845G/GL[Brookdale-G]/GE Chipset Integrated Graphics Device (rev 03)
> 0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev 82)
> 0000:00:1f.0 ISA bridge: Intel Corp. 82801DB/DBL (ICH4/ICH4-L) LPC Bridge (rev 02)
> 0000:00:1f.1 IDE interface: Intel Corp. 82801DB/DBL (ICH4/ICH4-L) UltraATA-100 IDE Controller (rev 02)
> 0000:00:1f.3 SMBus: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) SMBus Controller (rev 02)
> 0000:01:05.0 Ethernet controller: Intel Corp. 82540EM Gigabit Ethernet Controller (rev 02)
> 0000:01:06.0 Ethernet controller: Intel Corp. 82540EM Gigabit Ethernet Controller (rev 02)
> 
> equipped with 2.6Ghz P4 CPUs, 1Gb of ram, 2-4gb of swap, the kernel config
> is attached. The machines have normal load averages hovering not higher than
> 7.0, depending on the time of the day etc. Two of the machines run 2.4.25,
> one 2.4.27 and they work fine. When booted with 2.4.28, though (compiled
> with Debian's gcc 2.3.5, with p3 or p4 CPU selected in the config), the load
> is climbing very fast and hovers around a value 3-4 times higher than with
> the older kernels. Booted back in the old kernel, the load comes to its
> usual level. The logs suggest nothing, no errors, nothing unusual is
> happening. 
> 
> Has anyone had similar problems with 2.4.28 in an environment resembling the
> above? Could it be a problem with highmem i/o?

Nothing that I'm aware of should cause such increase in loadavg.

Marek, can you please try 2.4.28-pre1 ?
