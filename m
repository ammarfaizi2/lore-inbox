Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291372AbSCMAgi>; Tue, 12 Mar 2002 19:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291377AbSCMAg2>; Tue, 12 Mar 2002 19:36:28 -0500
Received: from [217.79.102.244] ([217.79.102.244]:51453 "EHLO
	monkey.beezly.org.uk") by vger.kernel.org with ESMTP
	id <S291372AbSCMAgL>; Tue, 12 Mar 2002 19:36:11 -0500
Subject: Re: Dropped packets on SUN GEM
From: Beezly <beezly@beezly.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020312.161057.18308390.davem@redhat.com>
In-Reply-To: <1015976181.2652.30.camel@monkey>
	<20020312.155238.21594857.davem@redhat.com>
	<1015978127.2653.49.camel@monkey> 
	<20020312.161057.18308390.davem@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-JMwj9PVZm2T8VcFaF0e8"
X-Mailer: Evolution/1.0.2 
Date: 13 Mar 2002 00:36:07 +0000
Message-Id: <1015979767.2652.77.camel@monkey>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-JMwj9PVZm2T8VcFaF0e8
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi David,

I *did* see the Pause is enabled message the other day, but I have only
seen it once. It hasn't been seen at all during tests today.

On Wed, 2002-03-13 at 00:10, David S. Miller wrote:
> You told me ealier that "sometimes pause is on, sometimes
> not".  Today you told me "pause is not going on".  Please,
> which is it? :)
>=20
> Do you have any manuals on the switch so we can check this
> out?

I've just checked the manual;

"Flow control is supported only on Gigabit Ethernet ports. It is enabled
or disabled as part of autonegotiation. If autonegotiation is set to
off, flow control is disabled. When autonegotiation is turned on, flow
control is enabled".

According to the switch, it's set up for autonegotiation and flow
control is set to "SYM";

Port Configuration Monitor                           Tue Mar 12 22:14:18
2002
Port        Port    Link   Auto    Speed       Duplex    Flow  Ld Share=20
            State   Status Neg   Cfg Actual  Cfg Actual  Ctrl   Master
Pri  Red
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  50     =
 ENABLED   ACTIVE  ON  1000   1000  AUTO  FULL   SYM          =20

Sorry to be vague,

Cheers,

Beezly


--=-JMwj9PVZm2T8VcFaF0e8
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8jp73Xu4ZFsMQjPgRAua+AKDLsHgjHvnLH0DFuVRVMF5Osz3yXACfeOgl
uYouawFh/oBz/YkzIKy1XWE=
=z9Sk
-----END PGP SIGNATURE-----

--=-JMwj9PVZm2T8VcFaF0e8--
