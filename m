Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316586AbSFALf3>; Sat, 1 Jun 2002 07:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317005AbSFALf2>; Sat, 1 Jun 2002 07:35:28 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:25589 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316586AbSFALf2>; Sat, 1 Jun 2002 07:35:28 -0400
Subject: Re: INTEL 845G Chipset IDE Quandry
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Anthony Spinillo <tspinillo@linuxmail.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020601110355.26944.qmail@linuxmail.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 01 Jun 2002 13:40:03 +0100
Message-Id: <1022935203.20348.22.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-06-01 at 12:03, Anthony Spinillo wrote:
> PCI_IDE: unknown IDE controller on PCI bus 00 device
> f9, VID=8086, DID=24cb
> PCI: Device 00:1f.1 not available because of resource
> collisions
> PCI_IDE: (ide_setup_pci_device:) Could not enable
> device.

If you look with lspci -v you will find your BIOS has mismapped or
forgotten to map some of the control register space for that device.

Alan

