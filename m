Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318057AbSGRM6i>; Thu, 18 Jul 2002 08:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318061AbSGRM6i>; Thu, 18 Jul 2002 08:58:38 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:6901 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318057AbSGRM6h>; Thu, 18 Jul 2002 08:58:37 -0400
Subject: Re: Asus P4B533 and resource conflict on IDE
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Halliwell <spike1@cyberspace.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200207181245.IAA14216@grex.cyberspace.org>
References: <200207181245.IAA14216@grex.cyberspace.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 18 Jul 2002 15:12:02 +0100
Message-Id: <1027001522.8154.15.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-07-18 at 13:45, Andrew Halliwell wrote:
> The P4B533 has the intel 801DB IDE controller (stated as supported in rc1)
> but in every 2.4 kernel I've seen so far, this appears in the bootup.
> 
> Uniform Multi-Platform E-IDE driver Revision: 6.31
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> PCI_IDE: unknown IDE controller on PCI bus 00 device f9, VID=8086, DID=24cb
> PCI: Device 00:1f.1 not available because of resource collisions
> PCI_IDE: (ide_setup_pci_device:) Could not enable device

Blame your BIOS vendor

The -ac tree has workarounds for the BIOS forgetting to set up the chip.
Let me know if rc1-ac7 works for you 

