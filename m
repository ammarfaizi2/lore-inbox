Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293640AbSCKIUF>; Mon, 11 Mar 2002 03:20:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293638AbSCKIT4>; Mon, 11 Mar 2002 03:19:56 -0500
Received: from [217.79.102.244] ([217.79.102.244]:45562 "EHLO
	monkey.beezly.org.uk") by vger.kernel.org with ESMTP
	id <S293641AbSCKITk>; Mon, 11 Mar 2002 03:19:40 -0500
Subject: Re: Sun GEM card looses TX on x86 32bit PCI
From: Beezly <beezly@beezly.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020310.164350.107967417.davem@redhat.com>
In-Reply-To: <1015792619.1801.4.camel@monkey> 
	<20020310.164350.107967417.davem@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-IroTY/MLIlKfmK4vbCOF"
X-Mailer: Evolution/1.0.2 
Date: 11 Mar 2002 08:19:37 +0000
Message-Id: <1015834777.1802.8.camel@monkey>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-IroTY/MLIlKfmK4vbCOF
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi David,

On Mon, 2002-03-11 at 00:43, David S. Miller wrote:
>=20
> What do the kernel logs say when the link is established?

I haven't had chance to apply your most recent patch yet (I have to go
to work!), but without the patch...

Mar 10 20:26:48 monkey kernel: sungem.c:v0.96 11/17/01 David S. Miller
(davem@redhat.com)
Mar 10 20:26:48 monkey kernel: PCI: Enabling device 00:0a.0 (0014 ->
0016)
Mar 10 20:26:48 monkey kernel: PCI: Found IRQ 5 for device 00:0a.0
Mar 10 20:26:48 monkey kernel: PCI: Sharing IRQ 5 with 00:0b.1
Mar 10 20:26:48 monkey kernel: eth0: Sun GEM (PCI) 10/100/1000BaseT
Ethernet 00:00:00:00:00:00=20
Mar 10 20:26:48 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 10 20:26:48 monkey kernel: eth0: Pause is disabled
Mar 10 20:26:48 monkey kernel: eth0: PCS AutoNEG complete.
Mar 10 20:26:48 monkey kernel: eth0: PCS link is now up.
Mar 10 20:26:48 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 10 20:26:48 monkey kernel: eth0: Pause is disabled
Mar 10 20:26:48 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 10 20:26:48 monkey kernel: eth0: Pause is disabled
Mar 10 20:26:48 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 10 20:26:48 monkey kernel: eth0: Pause is disabled
Mar 10 20:26:48 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.

<snip - it does this until the card decides to hang RX>

Mar 10 20:28:53 monkey kernel: eth0: Pause is disabled
Mar 10 20:28:54 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 10 20:28:54 monkey kernel: eth0: Pause is disabled
Mar 10 20:28:56 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 10 20:28:56 monkey kernel: eth0: Pause is disabled
Mar 10 20:28:57 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 10 20:28:57 monkey kernel: eth0: Pause is disabled
Mar 10 20:28:57 monkey kernel: eth0: RX MAC fifo overflow
smac[03910440].
Mar 10 20:28:58 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.
Mar 10 20:28:58 monkey kernel: eth0: Pause is disabled
Mar 10 20:28:59 monkey kernel: eth0: Link is up at 1000 Mbps,
full-duplex.

I'll apply the patch today and send you the logs back.

Cheers,

Beezly

--=-IroTY/MLIlKfmK4vbCOF
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8jGiZXu4ZFsMQjPgRAo3qAJ9QWAhadESOrLC4F4UGskod53eeuQCgr7dm
x0WBKLXBf0hrY0i40OB0S2c=
=8GiX
-----END PGP SIGNATURE-----

--=-IroTY/MLIlKfmK4vbCOF--
