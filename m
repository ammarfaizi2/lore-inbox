Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268379AbTBSMW4>; Wed, 19 Feb 2003 07:22:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268391AbTBSMW4>; Wed, 19 Feb 2003 07:22:56 -0500
Received: from dvmwest.gt.owl.de ([62.52.24.140]:13578 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id <S268379AbTBSMWy>;
	Wed, 19 Feb 2003 07:22:54 -0500
Date: Wed, 19 Feb 2003 13:32:56 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: axp-kernel-list@redhat.com
Cc: "=?iso-8859-1?Q?'M=E5ns_Rullg=E5rd'?=" <mru@users.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Module problems (WAS: RE: 2.5.62 on Alpha SUCCESS (2.6 release soon!?))
Message-ID: <20030219123256.GL351@lug-owl.de>
Mail-Followup-To: axp-kernel-list@redhat.com,
	=?iso-8859-1?Q?'M=E5ns_Rullg=E5rd'?= <mru@users.sourceforge.net>,
	linux-kernel@vger.kernel.org
References: <yw1xof59202j.fsf@bamse.e.kth.se> <008001c2d7ff$aa12b420$020b10ac@pitzeier.priv.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="odk+9xeySFhXpSS8"
Content-Disposition: inline
In-Reply-To: <008001c2d7ff$aa12b420$020b10ac@pitzeier.priv.at>
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--odk+9xeySFhXpSS8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-02-19 11:14:13 +0100, Oliver Pitzeier <o.pitzeier@uptime.at>
wrote in message <008001c2d7ff$aa12b420$020b10ac@pitzeier.priv.at>:
> M=E5ns Rullg=E5rd wrote:
> > "Oliver Pitzeier" <o.pitzeier@uptime.at> writes:
> [ ... ]
> > > OK... Make modules_install still has problems:
> [ ... ]
> > Which versions of binutils and gcc do you have?  I get=20
> > similar problems with binutils 2.13 and 2.4 kernels.
>=20
> This is my current env.:
> [root@track /root]# rpm -q modutils binutils gcc
> modutils-2.4.22-8
> binutils-2.12.90.0.7-3
> gcc-3.1-6

I don't know how good/bad this combination of gcc and binutils is for
2.5.x, but modutils 2.4.22 will _not_ work with current 2.5.x. Therefor,
you need the new module-init-tools, available at
ftp://ftp.kernel.org/pub/linux/kernel/people/rusty/modules IIRC.

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet!
   Shell Script APT-Proxy: http://lug-owl.de/~jbglaw/software/ap2/

--odk+9xeySFhXpSS8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+U3l4Hb1edYOZ4bsRAhlsAJ9dWGSCW9poVQrMVYYj4Rw4OTJeAwCeOwV+
EkY82Nr5F+cF54WgGhSOFs8=
=2FwW
-----END PGP SIGNATURE-----

--odk+9xeySFhXpSS8--
