Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317487AbSFDMrI>; Tue, 4 Jun 2002 08:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317488AbSFDMqw>; Tue, 4 Jun 2002 08:46:52 -0400
Received: from pop.gmx.de ([213.165.64.20]:6489 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S317487AbSFDMqe>;
	Tue, 4 Jun 2002 08:46:34 -0400
Date: Tue, 4 Jun 2002 14:46:19 +0200
From: Sebastian Droege <sebastian.droege@gmx.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: torvalds@transmeta.com, kees.bakker@xs4all.nl, mochel@osdl.org,
        aia21@cantab.net, anton@samba.org, linux-kernel@vger.kernel.org,
        slomosnail666@gmx.net
Subject: Re: [patch] PCI device matching fix
Message-Id: <20020604144619.1353b46c.sebastian.droege@gmx.de>
In-Reply-To: <3CFC0CC2.D69F2C57@zip.com.au>
X-Mailer: Sylpheed version 0.7.6 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=.:y?kYG+B8CyJSt"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.:y?kYG+B8CyJSt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 03 Jun 2002 17:41:40 -0700
Andrew Morton <akpm@zip.com.au> wrote:

> The new pci_device_probe() is always passing the zeroeth
> entry in the id_table to the device's probe method.  It
> needs to scan that table for the correct ID first.
> 
> This fixes the recent 3c59x strangenesses.

This fixes the yamaha ymfpci misdetection, too... Thanks :)

Bye
--=.:y?kYG+B8CyJSt
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE8/Laee9FFpVVDScsRAkkqAKC9PcF35U2r4Smbf2B91R/j50Jx1ACfYYkS
fHeoDczuhhybx/ETO6df3cA=
=jfmU
-----END PGP SIGNATURE-----

--=.:y?kYG+B8CyJSt--

