Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130200AbRAHUoP>; Mon, 8 Jan 2001 15:44:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130633AbRAHUoF>; Mon, 8 Jan 2001 15:44:05 -0500
Received: from tellus.thn.htu.se ([193.10.192.40]:27917 "EHLO thn.htu.se")
	by vger.kernel.org with ESMTP id <S130022AbRAHUny>;
	Mon, 8 Jan 2001 15:43:54 -0500
Date: Mon, 8 Jan 2001 21:43:11 +0100 (CET)
From: Richard Torkar <ds98rito@thn.htu.se>
To: "Timothy A. DeWees" <whtdrgn@mail.cannet.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: real talk cards in 2.2.18.
In-Reply-To: <001201c079b0$a968da40$7930000a@hcd.net>
Message-ID: <Pine.LNX.4.30.0101082142050.11104-100000@studpc91.thndorm.htu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Timothy A. DeWees wrote:

> Hello,
>
>     I am trying to compile the rtl8139 driver for my SMC
> 10/100 NIC.  I have turned on all 10/100 devices (i.e. 3Com
> cards -n- such); however, I can not get the rtl driver to show
> up as an option in my menuconfig.  What to I need to do to
> compile this driver as a module.  Am I missing something
> else perhaps not in Network Devices.  I do see the rtl8139.c file in my drivers/net source tree.
>

Have you turned on:
[EISA, VLB, PCI and on board controllers] in
[Ethernet (10 or 100Mbit)  --->] which is in
[Network device support  --->] ???


/Richard
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6WiZkUSLExYo23RsRAqA6AJ9y4MXPORujp4vBO2zt2YWW2jWmKQCfR1/X
y6JuvkONI4D/h3UytXoToAU=
=qNK8
-----END PGP SIGNATURE-----


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
