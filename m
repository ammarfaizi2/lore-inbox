Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265146AbTL2Xm0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 18:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265452AbTL2Xm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 18:42:26 -0500
Received: from wblv-224-192.telkomadsl.co.za ([165.165.224.192]:59327 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S265146AbTL2XmY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 18:42:24 -0500
Subject: Re: 2.6.0 performance problems
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: azarah@nosferatu.za.org
To: Thomas Molina <tmolina@cablespeed.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0312291803420.5835@localhost.localdomain>
References: <Pine.LNX.4.58.0312291647410.5288@localhost.localdomain>
	 <Pine.LNX.4.58.0312291420370.1586@home.osdl.org>
	 <Pine.LNX.4.58.0312291803420.5835@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-q1MPg83rGygmb3ZGGn5S"
Message-Id: <1072741422.25741.67.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 30 Dec 2003 01:43:42 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-q1MPg83rGygmb3ZGGn5S
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-12-30 at 01:05, Thomas Molina wrote:

> Sorry.  One other bit of data from 2.6:
>=20
> [root@lap bitkeeper]# hdparm -i /dev/hda
>=20
> /dev/hda:
>=20
>  Model=3DIBM-DJSA-220, FwRev=3DJS4OAC3A, SerialNo=3D44V44FT3300
>  Config=3D{ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
>  RawCHS=3D16383/16/63, TrkSize=3D0, SectSize=3D0, ECCbytes=3D4
>  BuffType=3DDualPortCache, BuffSize=3D1874kB, MaxMultSect=3D16, MultSect=
=3D16
>  CurCHS=3D17475/15/63, CurSects=3D16513875, LBA=3Dyes, LBAsects=3D3907008=
0
>  IORDY=3Don/off, tPIO=3D{min:240,w/IORDY:120}, tDMA=3D{min:120,rec:120}
>  PIO modes:  pio0 pio1 pio2 pio3 pio4
>  DMA modes:  mdma0 mdma1 mdma2
>  UDMA modes: udma0 udma1 *udma2 udma3 udma4
>  AdvancedPM=3Dyes: mode=3D0x80 (128) WriteCache=3Denabled
>  Drive conforms to: ATA/ATAPI-5 T13 1321D revision 1:
>=20
>  * signifies the current active mode

Any reason it is currently set to udma2 where it support udma4 ?


--=20
Martin Schlemmer

--=-q1MPg83rGygmb3ZGGn5S
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQA/8LwuqburzKaJYLYRAr6MAJ9Lr6UjjCTCPdjM9OCx1MmZz6f5lwCgk3c2
yJVbIAlvRBRxhCYAYTrC83o=
=4f3e
-----END PGP SIGNATURE-----

--=-q1MPg83rGygmb3ZGGn5S--

