Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265840AbUF2RG4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265840AbUF2RG4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 13:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265841AbUF2RGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 13:06:55 -0400
Received: from cantor.suse.de ([195.135.220.2]:4840 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265840AbUF2RGv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 13:06:51 -0400
Date: Tue, 29 Jun 2004 19:02:16 +0200
From: Kurt Garloff <kurt@garloff.de>
To: "David S. Miller" <davem@redhat.com>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: drivers/block/ub.c
Message-ID: <20040629170216.GJ4732@tpkurt.garloff.de>
Mail-Followup-To: Kurt Garloff <kurt@garloff.de>,
	"David S. Miller" <davem@redhat.com>,
	Linux kernel list <linux-kernel@vger.kernel.org>
References: <20040626130645.55be13ce@lembas.zaitcev.lan> <200406270631.41102.oliver@neukum.org> <20040626233423.7d4c1189.davem@redhat.com> <200406271242.22490.oliver@neukum.org> <20040627142628.34b60c82.davem@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f9lFb+Z4UT82L8vr"
Content-Disposition: inline
In-Reply-To: <20040627142628.34b60c82.davem@redhat.com>
X-Operating-System: Linux 2.6.5-17-KG i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: SUSE/Novell
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--f9lFb+Z4UT82L8vr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jun 27, 2004 at 02:26:28PM -0700, David S. Miller wrote:
> On Sun, 27 Jun 2004 12:42:21 +0200
> Oliver Neukum <oliver@neukum.org> wrote:
>=20
> > OK, then it shouldn't be used in this case. However, shouldn't we have
> > an attribute like __nopadding__ which does exactly that?
>=20
> It would have the same effect.  CPU structure layout rules don't pack
> (or using other words, add padding) exactly in cases where it is
> needed to obtain the necessary alignment.

This is a compiler shortcoming then.
The compiler does know the requirements and should be able to determine
whether or not it would have addedd padding or not.

Regards,
--=20
Kurt Garloff                   <kurt@garloff.de>             [Koeln, DE]
Physics:Plasma modeling <garloff@plasimo.phys.tue.nl> [TU Eindhoven, NL]
Linux: SUSE Labs (Head)        <garloff@suse.de>    [SUSE Nuernberg, DE]

--f9lFb+Z4UT82L8vr
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA4aCYxmLh6hyYd04RAlF/AJ9bZkjKp6aSG5Ln2crgDXNHPY6S3gCgt6wp
ZvaYwLCbQ8Te2ytFyhuaF1g=
=dlTk
-----END PGP SIGNATURE-----

--f9lFb+Z4UT82L8vr--
