Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262369AbTKNK0G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 05:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262373AbTKNK0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 05:26:06 -0500
Received: from top-elite.org ([217.160.94.140]:63651 "EHLO
	p15094795.pureserver.de") by vger.kernel.org with ESMTP
	id S262369AbTKNK0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 05:26:03 -0500
Date: Fri, 14 Nov 2003 11:26:04 +0100
From: Klaus Umbach <Klaus.Umbach@doppelhertz.homelinux.org>
To: Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org
Subject: Re: ide-scsi and SMP does not work together.
Message-ID: <20031114102604.GA659@DualPrinzip>
References: <20031104234828.GA1641@DualPrinzip> <16297.3166.937468.9288@alkaid.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <16297.3166.937468.9288@alkaid.it.uu.se>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mi, Nov 05, 2003 at 15:42:38 +0100, Mikael Pettersson wrote:
> Klaus Umbach writes:
>  > Hello Support Center :-)
>  > 
>  > Since I have 2 CPUs on my mainboard and compiled the SMP-support in, I
>  > cannot use ide-scsi anymore. I guess it must have something to do with
>  > apic, because when I use "Local APIC support on uniprocessors", I have
>  > the same problem. With no SMP and no local APIC everything works fine.
>  > (except the second CPU, of course). Normal ide-cdrom support works, but
>  > recording CDs over atapi is not really what I want at the moment.
>  > 
>  > Mainboard: MSI 694D pro
>  > 
>  > 00:07.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 10)
> 
> SMP by default uses the I/O-APIC, and may (depending on kernel version
> and .config) also use ACPI, which in turn may trigger ACPI-controlled
> PCI IRQ routing.
> 
> Try "acpi=off", "pci=noacpi" (or however that don't-use-ACPI-for-PCI
> option is spelled), and "noapic" (don't use I/O-APIC).

No, that didn't work. I got the same error-messages. :-(

> 
> /Mikael
> 


Klaus

--
Klaus Umbach <Klaus.Umbach@doppelhertz.homelinux.org>
