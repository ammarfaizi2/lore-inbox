Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313508AbSHGU7C>; Wed, 7 Aug 2002 16:59:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313743AbSHGU7C>; Wed, 7 Aug 2002 16:59:02 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:23912 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S313508AbSHGU7B>; Wed, 7 Aug 2002 16:59:01 -0400
Date: Wed, 7 Aug 2002 23:02:25 +0200
From: Kurt Garloff <kurt@garloff.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] conditionally re-enable per-disk stats, convert to seq_file
Message-ID: <20020807210225.GD31622@nbkurt.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <kurt@garloff.de>,
	Christoph Hellwig <hch@lst.de>,
	Linux kernel list <linux-kernel@vger.kernel.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>
References: <20020806160848.A2413@lst.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sgneBHv3152wZ8jf"
Content-Disposition: inline
In-Reply-To: <20020806160848.A2413@lst.de>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.18 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--sgneBHv3152wZ8jf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

On Tue, Aug 06, 2002 at 04:08:48PM +0200, Christoph Hellwig wrote:
> This patch against 2.4.20-pre1 converts /proc/partitions to the seq_file
> interface as in 2.5, makes it report the sard-style extended disk
> statistics condititional on CONFIG_BLK_STATS and disables the gathering
> of those totally otherwise to not waste memory and processing power.
>=20
> This patch is based on the concept of Kurt's statistics patch, although
> it is implemented very differently to avoid #ifdef hell.

Actually, I was expecting criticism due to the ifdef stuff I did and was
prepared to come up with something better. But I also learned never to put
effort into something before being asked to ...

Your patch looks fine to me. Thanks for preparing it!

Regards,
--=20
Kurt Garloff                   <kurt@garloff.de>         [Eindhoven, NL]
Physics: Plasma simulations    <K.Garloff@TUE.NL>     [TU Eindhoven, NL]
Linux: SCSI, Security          <garloff@suse.de>    [SuSE Nuernberg, DE]
 (See mail header or public key servers for PGP2 and GPG public keys.)

--sgneBHv3152wZ8jf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9UYrhxmLh6hyYd04RAvrLAKDPcmQm9MiPcOJWXMZvNuOM+ITtmACcDwUM
Gy1CaT/XQTfnfGGVtDicGEU=
=Wn25
-----END PGP SIGNATURE-----

--sgneBHv3152wZ8jf--
