Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130217AbRAKL76>; Thu, 11 Jan 2001 06:59:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129933AbRAKL7s>; Thu, 11 Jan 2001 06:59:48 -0500
Received: from mail.sun.ac.za ([146.232.128.1]:24584 "EHLO mail.sun.ac.za")
	by vger.kernel.org with ESMTP id <S131427AbRAKL7j>;
	Thu, 11 Jan 2001 06:59:39 -0500
Date: Thu, 11 Jan 2001 13:59:31 +0200 (SAST)
From: Hans Grobler <grobh@sun.ac.za>
To: "Karsten Hopp (Red Hat)" <Karsten.Hopp@sap.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.0-ac6: drivers/net/rcpci45.c typo
In-Reply-To: <3A5D9F29.4274AD6B@sap.com>
Message-ID: <Pine.LNX.4.30.0101111358140.30013-100000@prime.sun.ac.za>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Jan 2001, Karsten Hopp (Red Hat) wrote:
> --- ./drivers/net/rcpci45.c.orig        Thu Jan 11 12:49:19 2001
> +++ ./drivers/net/rcpci45.c     Thu Jan 11 12:47:04 2001
> @@ -120,7 +120,7 @@
>         { RC_PCI45_VENDOR_ID, RC_PCI45_DEVICE_ID, PCI_ANY_ID,
> PCI_ANY_ID, },
>         { }
>  };
> -MODULE_DEVICE_TABLE(pci, rcpci_pci_table);
> +MODULE_DEVICE_TABLE(pci, rcpci45_pci_table);
>
>  static void __exit rcpci45_remove_one(struct pci_dev *pdev)
>  {

Yes we know about this one. This is a bug that was killed, and then came
back to life. We're still trying to figure out how... :)

-- Hans

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
