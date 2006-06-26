Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750816AbWFZREp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbWFZREp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 13:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750995AbWFZREp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 13:04:45 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:64198 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1750816AbWFZREn (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 13:04:43 -0400
Message-Id: <200606261704.k5QH4V4P008055@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: PATCH: SC1200 debug printk
In-Reply-To: Your message of "Mon, 26 Jun 2006 14:51:45 BST."
             <1151329905.27147.29.camel@localhost.localdomain>
From: Valdis.Kletnieks@vt.edu
References: <1151329905.27147.29.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1151341470_3150P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 26 Jun 2006 13:04:31 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1151341470_3150P
Content-Type: text/plain; charset=us-ascii

On Mon, 26 Jun 2006 14:51:45 BST, Alan Cox said:
> Kill a pair of long escaped debug printk calls
> 
> Signed-off-by: Alan Cox <alan@redhat.com>
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.17/drivers/ide/pci/sc1200.c linux-2.6.17/drivers/ide/pci/sc1200.c
> --- linux.vanilla-2.6.17/drivers/ide/pci/sc1200.c	2006-06-19 17:17:24.000000000 +0100
> +++ linux-2.6.17/drivers/ide/pci/sc1200.c	2006-06-26 13:27:45.671877280 +0100

Hmm... 

> @@ -493,7 +491,7 @@
>  }
>  
>  static struct pci_device_id sc1200_pci_tbl[] = {
> -	{ PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_SCx200_IDE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
> +	{ PCI_DEVICE(PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_SCx200_IDE), 0},
>  	{ 0, },
>  };
>  MODULE_DEVICE_TABLE(pci, sc1200_pci_tbl);

Escape of an unrelated change to the same file?

--==_Exmh_1151341470_3150P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEoBOecC3lWbTT17ARAqz9AKDJf4zk7scTcwFMAbEb/aj1y2NeMACgnwQa
AZWsgD4JfCVvIKslPTChu1A=
=dIcm
-----END PGP SIGNATURE-----

--==_Exmh_1151341470_3150P--
