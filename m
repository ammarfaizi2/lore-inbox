Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291531AbSCMBHf>; Tue, 12 Mar 2002 20:07:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291547AbSCMBH2>; Tue, 12 Mar 2002 20:07:28 -0500
Received: from [217.79.102.244] ([217.79.102.244]:64253 "EHLO
	monkey.beezly.org.uk") by vger.kernel.org with ESMTP
	id <S291531AbSCMBHS>; Tue, 12 Mar 2002 20:07:18 -0500
Subject: Re: Dropped packets on SUN GEM
From: Beezly <beezly@beezly.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020312.165609.18574402.davem@redhat.com>
In-Reply-To: <1015978127.2653.49.camel@monkey>
	<20020312.161057.18308390.davem@redhat.com>
	<1015979767.2652.77.camel@monkey> 
	<20020312.165609.18574402.davem@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-GT5uIuF59S4cV6gyxVRa"
X-Mailer: Evolution/1.0.2 
Date: 13 Mar 2002 01:07:14 +0000
Message-Id: <1015981634.2652.82.camel@monkey>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-GT5uIuF59S4cV6gyxVRa
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi David,

On Wed, 2002-03-13 at 00:56, David S. Miller wrote:
> No problem.  If you add this patch below does it make Pause get
> negotiated on?  Please print everything the driver says from module
> load to the time the link comes up.

It doesn't appear to :(

sungem.c:v0.96 11/17/01 David S. Miller (davem@redhat.com)
PCI: Found IRQ 5 for device 00:0a.0
PCI: Sharing IRQ 5 with 00:0b.1
eth0: Sun GEM (PCI) 10/100/1000BaseT Ethernet 00:00:00:00:00:00=20
eth0: Link is up at 1000 Mbps, full-duplex.
eth0: Pause is disabled
eth0: PCS AutoNEG complete.
eth0: PCS link is now up.
eth0: Link is up at 1000 Mbps, full-duplex.
eth0: Pause is disabled
eth0: Link is up at 1000 Mbps, full-duplex.
eth0: Pause is disabled
eth0: Link is up at 1000 Mbps, full-duplex.
eth0: Pause is disabled

--=-GT5uIuF59S4cV6gyxVRa
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8jqZCXu4ZFsMQjPgRAoQYAJ9A3i9258BeJp5XwndWgQKs5DEJrACeIzUa
oZ2mmn7XJqOH71zN+p4zBO0=
=G4eJ
-----END PGP SIGNATURE-----

--=-GT5uIuF59S4cV6gyxVRa--
