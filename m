Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932190AbVKKIZw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbVKKIZw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 03:25:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbVKKIZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 03:25:52 -0500
Received: from smtprelay03.ispgateway.de ([80.67.18.15]:41096 "EHLO
	smtprelay03.ispgateway.de") by vger.kernel.org with ESMTP
	id S1751248AbVKKIZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 03:25:51 -0500
From: Ingo Oeser <ioe-lkml@rameria.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] sys_punchhole()
Date: Fri, 11 Nov 2005 09:25:41 +0100
User-Agent: KMail/1.7.2
Cc: Andrew Morton <akpm@osdl.org>, Badari Pulavarty <pbadari@us.ibm.com>,
       andrea@suse.de, hugh@veritas.com, linux-mm@kvack.org
References: <1131664994.25354.36.camel@localhost.localdomain> <20051110153254.5dde61c5.akpm@osdl.org>
In-Reply-To: <20051110153254.5dde61c5.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2834990.SANAYd45pA";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200511110925.48259.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2834990.SANAYd45pA
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Friday 11 November 2005 00:32, Andrew Morton wrote:
> Badari Pulavarty <pbadari@us.ibm.com> wrote:
> >
> > We discussed this in madvise(REMOVE) thread - to add support=20
> > for sys_punchhole(fd, offset, len) to complete the functionality
> > (in the future).
> >=20
> > http://marc.theaimsgroup.com/?l=3Dlinux-mm&m=3D113036713810002&w=3D2
> >=20
> > What I am wondering is, should I invest time now to do it ?
>=20
> I haven't even heard anyone mention a need for this in the past 1-2 years.

Because the people need it are usally at the application level.
It would be useful with hard disk editing.

But this would need a move_blocks within the filesystem, which
could attach a given list of blocks to another file.

E.g. mremap() for files :-)

Both together would make harddisk video editing with linux quite
performant and less error prone.


Regards

Ingo Oeser


--nextPart2834990.SANAYd45pA
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDdFWMU56oYWuOrkARAs5bAKCUWeuUxd7AWdVsC4jDANe0KvlQRwCdHnBz
shv9TBiCqFQ2+WQTas5FK6w=
=2JyA
-----END PGP SIGNATURE-----

--nextPart2834990.SANAYd45pA--
