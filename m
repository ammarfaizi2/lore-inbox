Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317691AbSGZMIE>; Fri, 26 Jul 2002 08:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317693AbSGZMIE>; Fri, 26 Jul 2002 08:08:04 -0400
Received: from fysh.org ([212.47.68.126]:31123 "EHLO bowl.fysh.org")
	by vger.kernel.org with ESMTP id <S317691AbSGZMID>;
	Fri, 26 Jul 2002 08:08:03 -0400
Date: Fri, 26 Jul 2002 13:11:09 +0100
From: Athanasius <link@gurus.tf>
To: Rudmer van Dijk <rvandijk@science.uva.nl>
Cc: Bruce Cran <bruce@cran.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: wrong mtu value in /proc/net/route
Message-ID: <20020726121109.GA8043@miggy.org.uk>
Mail-Followup-To: Athanasius <link@gurus.tf>,
	Rudmer van Dijk <rvandijk@science.uva.nl>,
	Bruce Cran <bruce@cran.org.uk>, linux-kernel@vger.kernel.org
References: <20020725223410.A18965@steely.transient> <20020725220557Z316579-685+18235@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
In-Reply-To: <20020725220557Z316579-685+18235@vger.kernel.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2002 at 12:14:30AM +0200, Rudmer van Dijk wrote:
> On Thursday 25 July 2002 23:34, Bruce Cran wrote:
> > I've found something strange going on in 2.4 kernels - when I run
> > 'netstat -r' I get the routing table from /proc/net/route.   The MSS
> > value reported is only 40 bytes, and when I run 'cat
> > /proc/net/route I'm told that the _MTU_ is 40 bytes.   I thought the MSS
[snip]
>=20
> I see the same values on 2.4.19-rc3-ac3 with two Winbond Electronics Corp=
=20
> W89C940 NIC's. no idea what is causing it.

  Same here with:

Kernel 2.4.18-pre8
eth0: NE2000 found at 0x240, using IRQ 10.
eth1: 3c5x9 at 0x320, 10baseT port, address  00 60 97 ad 3f 84, IRQ 5.
eth2: RealTek RTL8139 Fast Ethernet at 0xd8855000, 00:50:bf:ea:0f:41, IRQ 9

Kernel 2.4.18
Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink]

Kernel 2.4.19-rc1
eth0: RealTek RTL8139 Fast Ethernet at 0xe0863f00, 00:20:ed:1d:fe:2a, IRQ 5

  Again, ifconfig on both machines shows the correct values.

  I've not gotten around to trying 2.4.19-rc3 yet.

-Ath
--=20
- Athanasius =3D Athanasius(at)miggy.org.uk / http://www.clan-lovely.org/~a=
than/
                  Finger athan(at)fysh.org for PGP key
	   "And it's me who is my enemy. Me who beats me up.
Me who makes the monsters. Me who strips my confidence." Paula Cole - ME

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAj1BPF0ACgkQzbc+I5XfxKfzDwCeK8WnI6GCAaCYL/qJ7+YWjWyl
eBIAoI0+lrOFhlMHemxKdB0O2G5c4C9k
=IUja
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
