Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278381AbRJ1NsF>; Sun, 28 Oct 2001 08:48:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278382AbRJ1Nrp>; Sun, 28 Oct 2001 08:47:45 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:52747 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S278381AbRJ1Nrl>; Sun, 28 Oct 2001 08:47:41 -0500
Subject: Re: [PATCH] linux-2.4.13 - i8xx series chipsets patches
To: wim@iguana.be (Wim Van Sebroeck)
Date: Sun, 28 Oct 2001 13:54:45 +0000 (GMT)
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <20011028123941.A24412@medelec.uia.ac.be> from "Wim Van Sebroeck" at Oct 28, 2001 12:39:41 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15xqOj-0007s2-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  static struct pci_device_id i810tco_pci_tbl[] __initdata = {
> -	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AA_0,	PCI_ANY_ID, PCI_ANY_ID, },
> -	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AB_0,	PCI_ANY_ID, PCI_ANY_ID, },
> -	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_0,	PCI_ANY_ID, PCI_ANY_ID, },
> -	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_10,	PCI_ANY_ID, PCI_ANY_ID, },
> +	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AA_0, PCI_ANY_ID, PCI_ANY_ID, },
> +	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AB_0, PCI_ANY_ID, PCI_ANY_ID, },
> +	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_0, PCI_ANY_ID, PCI_ANY_ID, },

Why all this renaming and reformatting - what does your patch really do
other than generate a lot of pointless noise

> -	1a21  82840 840 (Carmel) Chipset Host Bridge (Hub A)
> +	1a21  82840 840 [Carmel] Chipset Host Bridge (Hub A)

And why break all the bracketing so that it isnt like other table
entries ?
