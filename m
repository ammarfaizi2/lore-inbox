Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261514AbVBNSaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261514AbVBNSaU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 13:30:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261516AbVBNSaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 13:30:20 -0500
Received: from s-utl01-nypop.stsn.com ([199.106.90.52]:40439 "HELO
	s-utl01-nypop.stsn.com") by vger.kernel.org with SMTP
	id S261514AbVBNSaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 13:30:11 -0500
Date: Mon, 14 Feb 2005 19:30:04 +0100
From: Kurt Garloff <garloff@suse.de>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: Kurt Garloff <garloff@suse.de>,
       Linux kernel list <linux-kernel@vger.kernel.org>,
       James Morris <jmorris@redhat.com>, Chris Wright <chrisw@osdl.org>
Subject: Re: [PATCH] 2/5: LSM hooks rework
Message-ID: <20050214183004.GB9866@tpkurt.garloff.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Andreas Gruenbacher <agruen@suse.de>,
	Linux kernel list <linux-kernel@vger.kernel.org>,
	James Morris <jmorris@redhat.com>, Chris Wright <chrisw@osdl.org>
References: <20050213210515.GH27893@tpkurt.garloff.de> <20050213211034.GI27893@tpkurt.garloff.de> <20050213211109.GJ27893@tpkurt.garloff.de> <1108391432.2974.6.camel@winden.suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p4qYPpj5QlsIQJ0K"
Content-Disposition: inline
In-Reply-To: <1108391432.2974.6.camel@winden.suse.de>
X-Operating-System: Linux 2.6.8-10-KG i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: SUSE/Novell
User-Agent: Mutt/1.5.6i
X-OriginalArrivalTime: 14 Feb 2005 18:30:10.0524 (UTC) FILETIME=[3746D9C0:01C512C3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

On Mon, Feb 14, 2005 at 03:30:33PM +0100, Andreas Gruenbacher wrote:
> On Sun, 2005-02-13 at 22:11, Kurt Garloff wrote:
> > Rather than having every LSM hook twice, once for the case with
> > CONFIG_SECURITY enabled and once for the disabled case, put
> > everything in one inline function.
>=20
> The attached patch fixes compilation if CONFIG_SECURITY_NETWORK is
> turned off.
>=20
> > This reduces the chance of the two to go out of sync immensely.
>=20
> ... as it already happened with security_sk_free(). Also fixed in the
> attached patch.

Indeed. Though harmless fortunately ...

Thanks for fixing this up, I had overlooked the CONFIG_SECURITY_NETWORK
disabled case :(

Regards,
--=20
Kurt Garloff, Director SUSE Labs, Novell Inc.

--p4qYPpj5QlsIQJ0K
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCEO4rxmLh6hyYd04RAhFdAJ4vZoWB6/RZtNRB1rPqXpwQ7Lk9ewCgzVyr
CTHxApd/FR5FdOnds/t08+s=
=wLKI
-----END PGP SIGNATURE-----

--p4qYPpj5QlsIQJ0K--
