Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266919AbUG1OEP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266919AbUG1OEP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 10:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266921AbUG1OEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 10:04:15 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:35269 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S266919AbUG1OEN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 10:04:13 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Alan Cox <alan@redhat.com>
Subject: Re: PATCH: Add support for Innovision DM-8401H
Date: Wed, 28 Jul 2004 16:10:54 +0200
User-Agent: KMail/1.5.3
References: <20040728134910.GA8514@devserv.devel.redhat.com>
In-Reply-To: <20040728134910.GA8514@devserv.devel.redhat.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200407281610.54961.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ cc: linux-ide, please! ]

On Wednesday 28 of July 2004 15:49, Alan Cox wrote:
> This is an SII 680 with strange PCI identifiers it appears

No, this is a different chipset (produced by ITE).

> Original patch: Alex Hewson
> Verified by: Alan Cox <alan@redhat.com>

I asked you to compare Sil and ITE datasheets
(as I don't have one for Sil0680).

Have you done this?

> @@ -1634,6 +1634,7 @@
>  #define PCI_VENDOR_ID_ITE		0x1283
>  #define PCI_DEVICE_ID_ITE_IT8172G	0x8172
>  #define PCI_DEVICE_ID_ITE_IT8172G_AUDIO 0x0801
> +#define PCI_DEVICE_ID_ITE_DM8401	0x8212

This chipset is used by other cards as well.
 
> @@ -1108,7 +1111,8 @@
>  static ide_pci_device_t siimage_chipsets[] __devinitdata = {
>  	/* 0 */ DECLARE_SII_DEV("SiI680"),
>  	/* 1 */ DECLARE_SII_DEV("SiI3112 Serial ATA"),
> -	/* 2 */ DECLARE_SII_DEV("Adaptec AAR-1210SA")
> +	/* 2 */ DECLARE_SII_DEV("Adaptec AAR-1210SA"),
> +	/* 3 */ DECLARE_SII_DEV("InnoVISION DM8401H")
>  };

ditto

