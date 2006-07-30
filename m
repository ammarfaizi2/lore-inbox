Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932345AbWG3QIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345AbWG3QIE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 12:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932343AbWG3QIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 12:08:04 -0400
Received: from nsm.pl ([195.34.211.229]:25876 "EHLO nsm.pl")
	by vger.kernel.org with ESMTP id S932335AbWG3QID (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 12:08:03 -0400
Date: Sun, 30 Jul 2006 18:07:38 +0200
From: Tomasz Torcz <zdzichu@irc.pl>
To: bert hubert <bert.hubert@netherlabs.nl>, linux-kernel@vger.kernel.org,
       zwane@arm.linux.org.uk
Subject: Re: 2.6.18 regression: cpufreq broken since 2.6.18-rc1 on pentium4
Message-ID: <20060730160738.GB13377@irc.pl>
Mail-Followup-To: bert hubert <bert.hubert@netherlabs.nl>,
	linux-kernel@vger.kernel.org, zwane@arm.linux.org.uk
References: <20060730120844.GA18293@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JYK4vJDZwFMowpUq"
Content-Disposition: inline
In-Reply-To: <20060730120844.GA18293@outpost.ds9a.nl>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--JYK4vJDZwFMowpUq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 30, 2006 at 02:08:44PM +0200, bert hubert wrote:
> Hi everybody,
>=20
> Since 2.6.18-rc1, up to and including -rc3, cpufreq has died on me. It
> worked fine in 2.6.16.9.
>=20
> # modprobe p4_clockmod
> FATAL: Error inserting p4_clockmod
> (/lib/modules/2.6.18-rc3/kernel/arch/i386/kernel/cpu/cpufreq/p4-clockmod.=
ko):
> Device or resource busy
>=20

  I have similar problem with cpufreq-nforce2 -- http://lkml.org/lkml/2006/=
7/7/234
  I haven't do a git-bisect yet.

--=20
Tomasz Torcz                 "God, root, what's the difference?"
zdzichu@irc.-nie.spam-.pl         "God is more forgiving."


--JYK4vJDZwFMowpUq
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: gpg --search-keys Tomasz Torcz

iD8DBQFEzNlKThhlKowQALQRAmncAKDPCotTXe+v5nlS8HYETk8GG5YgowCgmo2k
dYly5upTSMJagRUVFFIlQ0g=
=iWKZ
-----END PGP SIGNATURE-----

--JYK4vJDZwFMowpUq--
