Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316739AbSEWOZp>; Thu, 23 May 2002 10:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316740AbSEWOZo>; Thu, 23 May 2002 10:25:44 -0400
Received: from collaboration.manfred-dahlhoff.de ([194.245.124.6]:58591 "HELO
	ip-194-245-124-6.manfred-dahlhoff.de") by vger.kernel.org with SMTP
	id <S316739AbSEWOZo>; Thu, 23 May 2002 10:25:44 -0400
Date: Thu, 23 May 2002 16:25:41 +0200
From: Wiktor Wodecki <w.wodecki@manfred-dahlhoff.de>
To: linux-kernel@vger.kernel.org
Cc: "Mohammad A. Haque" <mhaque@haque.net>
Subject: Re: ip alias and default outgoing interface
Message-ID: <20020523142541.GB23684@equilibrium.manfred-dahlhoff.de>
In-Reply-To: <Pine.LNX.4.44.0205220003060.3979-100000@viper.haque.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oLBj+sq0vYjzfsbl"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-message-flag: Linux - choice of the GNU generation
X-Operating-System: Linux 2.4.19-pre6 i686
X-PGP-KeyID: A1559FE7
X-Info: I preffer encrypted e-mail over plaintext - please use my public key as mentioned in X-PGP-KeyID or retrieve my public key by sending an email with the subject 'public key request' to wodecki@gmx.de.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--oLBj+sq0vYjzfsbl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2002 at 12:05:24AM -0400, Mohammad A. Haque wrote:
> I've got a setup where I have one ethernet card and multiple ips=20
> assigned using ip alias.
> Is this supposed to happen? How do I make it so that the default gw=20
> interface is used?

I've seen similar behaviour with current 2.4 kernels with several nics
with different ip's in one subnet. The solution was to create an own
routing table for each ip (networkcard therefore) and to hammer static
ip-nic arp entries at the router before. Look at the advanced routing
howto for more information or write me a private email.

--=20

Regards,

Wiktor Wodecki <w.wodecki@manfred-dahlhoff.de>

--oLBj+sq0vYjzfsbl
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Weitere Infos: siehe http://www.gnupg.org

iD8DBQE87PvlquOEd6FVn+cRAg/nAJ4g1c+nALgwh84D1Z2IJrkrIcnBMACeJvEm
4wkKLIc69ubM/4oNrBJyeuM=
=4VR2
-----END PGP SIGNATURE-----

--oLBj+sq0vYjzfsbl--
