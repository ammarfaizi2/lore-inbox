Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261377AbTC3AIp>; Sat, 29 Mar 2003 19:08:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262197AbTC3AIp>; Sat, 29 Mar 2003 19:08:45 -0500
Received: from c-1b0072d5.012-136-6c756e2.cust.bredbandsbolaget.se ([213.114.0.27]:43644
	"EHLO pomac.netswarm.net") by vger.kernel.org with ESMTP
	id <S261377AbTC3AIo>; Sat, 29 Mar 2003 19:08:44 -0500
Subject: [2.5.66-mm1][SCSI-Query] aic7\x\x\x parity errors.
From: Ian Kumlien <pomac@vapor.com>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Dj0jyjgK6fTJpcaVWPVj"
Organization: 
Message-Id: <1048983600.9450.14.camel@big.pomac.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 30 Mar 2003 01:20:00 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Dj0jyjgK6fTJpcaVWPVj
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi all,=20

I wanted to test 2.5 kernels, but i have to say that i have no clue
about the current status of the drivers that use.

I checked dmesg to see what info it gave me and it just pushes loads of
error messages as seen below.... The only thing i have on that scsi
interface is two cdroms (one of which is a cd writer).

Is this known? Any information you guys want/need?

lspci:
00:0b.0 SCSI storage controller: Adaptec AHA-7850 (rev 03)

driver:
CONFIG_SCSI_AIC7XXX=3Dy

driver options:
CONFIG_AIC7XXX_CMDS_PER_DEVICE=3D8
CONFIG_AIC7XXX_RESET_DELAY_MS=3D15000
CONFIG_AIC7XXX_DEBUG_ENABLE=3Dy (shouldn't print all this data if it
				wasn't important imho.)
CONFIG_AIC7XXX_DEBUG_MASK=3D0
CONFIG_AIC7XXX_REG_PRETTY_PRINT=3Dy

dmesg is filled with:
scsi0: PCI error Interrupt at seqaddr =3D 0x7
scsi0: Data Parity Error Detected during address or write data phase
scsi0: PCI error Interrupt at seqaddr =3D 0x9
scsi0: Data Parity Error Detected during address or write data phase

CC since i don't think i could handle subscribing to this ml =3D)

--=20
Ian Kumlien <pomac@vapor.com>

--=-Dj0jyjgK6fTJpcaVWPVj
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA+hjgw7F3Euyc51N8RAiuVAJ4zXvorZCsm4XDcT3fxWeWpfyWdbgCfeajS
IZkAx9drUXYlHpTtJYhYTEE=
=uBV2
-----END PGP SIGNATURE-----

--=-Dj0jyjgK6fTJpcaVWPVj--

