Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261338AbVGXXUv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261338AbVGXXUv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 19:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261534AbVGXXUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 19:20:51 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:4019 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261338AbVGXXUt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 19:20:49 -0400
Subject: Re: Device supported by the OSS trident driver not supported by
	ALSA
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: perex@suse.cz, mulix@mulix.org, linux-kernel@vger.kernel.org,
       alsa-devel@alsa-project.org, Alan Cox <alan@redhat.com>
In-Reply-To: <20050723200417.GI3160@stusta.de>
References: <20050723200417.GI3160@stusta.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 25 Jul 2005 00:42:49 +0100
Message-Id: <1122248569.10835.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2005-07-23 at 22:04 +0200, Adrian Bunk wrote:
> The OSS trident driver has 5 different pci_device_id entries.
> 
> For 4 of them there seems to be similar ALSA support, but I can't find 
> any ALSA equivalent for the following entry:
>         {PCI_VENDOR_ID_INTERG, PCI_DEVICE_ID_INTERG_5050,
>          PCI_ANY_ID, PCI_ANY_ID, 0, 0, CYBER5050},
> 
> Can anyone tell my why this device is supported by the OSS trident 
> driver but not by ALSA?

The OSS driver supports the CyberPro T-squared core integrated into the
cyberpro chipset while the ALSA driver only supports the others. Should
be easy for someone to resolve. I don't have any 5000 hardware to test
it however.

Alan

