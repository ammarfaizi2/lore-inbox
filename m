Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129091AbQKWOkl>; Thu, 23 Nov 2000 09:40:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129581AbQKWOkb>; Thu, 23 Nov 2000 09:40:31 -0500
Received: from tellus.thn.htu.se ([193.10.192.40]:12 "EHLO thn.htu.se")
        by vger.kernel.org with ESMTP id <S129091AbQKWOkR>;
        Thu, 23 Nov 2000 09:40:17 -0500
Date: Thu, 23 Nov 2000 15:10:08 +0100 (CET)
From: Richard Torkar <ds98rito@thn.htu.se>
To: ARND BERGMANN <std7652@et.FH-Osnabrueck.DE>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: test11: lockup when reading /proc/ide/hde/identify
In-Reply-To: <Pine.GSO.4.21.0011231433290.2260-100000@gamma10>
Message-ID: <Pine.LNX.4.30.0011231509170.19206-100000@toor.thn.htu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

ARND BERGMANN wrote:

> Hi!
>
> I think I found a bug in the IDE subsystem. When I do 'cat
> /proc/ide/hde/identify', the system locks up completely, not
> even Alt+RysRq+B helps. Everything else under /proc/ide works.
> hdparm can cause the same symptoms, but I have not checked
> when exactly it does so.
>
> I have an Asus A7V mainboard with VIA 82C686A as first IDE
> controller and an onboard Promise PDC20265 as second IDE
> controller.
> Both have a Fujitsu MPF3204AT as their primary master drive,
> but the problem occurs only on the Promise adapter.
>
> I have tried kernel 2.4.0-test11-pre6, test11-ac2 and
> ide.2.4.0-t11.1120, all with the same result, but I did not
> try any older kernels, because I installed the machine
> just two days ago.
>
> Arnd <><


I have an IBM HD on hde which is a HPT366.
It is not reproducable here.

Probably som VIA thingy?


/Richard
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6HSVDUSLExYo23RsRAuZWAJ9+3bGOcdiqIK6tzfhApHFSUWtB2ACaAzPp
wZLDcVJpZAyt5ecnET3MLMQ=
=Y8tG
-----END PGP SIGNATURE-----


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
