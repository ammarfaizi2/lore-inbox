Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932197AbWFUPuZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbWFUPuZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 11:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbWFUPuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 11:50:24 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:34205 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751053AbWFUPuX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 11:50:23 -0400
Date: Wed, 21 Jun 2006 10:50:14 -0500
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: "Timothy R. Chavez" <tinytim@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, Mike Halcrow <mike@halcrow.us>
Subject: Re: [PATCH 2/12] Support for larger maximum key size
Message-ID: <20060621155014.GB2682@us.ibm.com>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
References: <E1FsngZ-00078k-Jc@localhost.localdomain> <1150901397.24002.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="A6N2fC+uXW/VQSAv"
Content-Disposition: inline
In-Reply-To: <1150901397.24002.11.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 21, 2006 at 09:49:57AM -0500, Timothy R. Chavez wrote:
> > -		    ECRYPTFS_MAX_ENCRYPTED_KEY_BYTES;
> > -	for (i =3D 0; i < auth_tok->session_key.encrypted_key_size; i++)
> > +	for (i =3D 0; i < (crypt_stat->key_size_bits / 8); i++)
>=20
> Why don't you just do this particular calculation once?  Just looking
> down, you do this same calculation at least 4 other potential times.

Patch #10 in this set changes the keysize to bytes, so this is a
resolved issue.

Thanks,
Mike

--A6N2fC+uXW/VQSAv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iQEVAwUBRJlqtdtAhTFtyodpAQI6fgf9FtwZQXB/yZGDf/B1pC//rxbsV7d3+PI3
/q4mkXlUrL79v4yyd+e00hSReBbK/oGz3qQgxXnTIEFrcx44tI/ahR/BgWMXl3sb
293och5Qe5TvO0UA+6rVET4gzui56XK3UAPigPl+6azWoqLmKvUG2x8aRYpuN4am
29yDE/ffme8XWCHlPDFMssnvbZjZIddqhs4S62M2Z53fhLUyheOyTUxcPQSXtBcq
7fS98cTrzs8d8sbG/pkvVFi8OMcjx37pj7jm145gV9DsaKLbBUKIaWxggxsYdR8j
Q+flyCRNZgHunFwis4wLNQwcKQsd7DhiiKTM7Ruvu0cvn4przC57Vg==
=OnOq
-----END PGP SIGNATURE-----

--A6N2fC+uXW/VQSAv--
