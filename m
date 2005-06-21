Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262415AbVFUWfN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262415AbVFUWfN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 18:35:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262409AbVFUWdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 18:33:54 -0400
Received: from mx1.redhat.com ([66.187.233.31]:41866 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262495AbVFUVpG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 17:45:06 -0400
Subject: Re: -mm -> 2.6.13 merge status
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com,
       Gerrit Huizenga <gh@us.ibm.com>
In-Reply-To: <20050621140441.53513a7a.akpm@osdl.org>
References: <20050621132204.1b57b6ba.akpm@osdl.org>
	 <E1Dkpn1-0006va-00@w-gerrit.beaverton.ibm.com>
	 <20050621140441.53513a7a.akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-CnmM3x3ygs98qRMu8doP"
Organization: Red Hat, Inc.
Date: Tue, 21 Jun 2005 17:38:17 -0400
Message-Id: <1119389897.6465.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-CnmM3x3ygs98qRMu8doP
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-06-21 at 14:04 -0700, Andrew Morton wrote:
> Gerrit Huizenga <gh@us.ibm.com> wrote:
> >
> > Kexec/kdump has a chance of working reliably.
>=20
> IOW: Kexec/kdump has a chance of not working reliably.
>=20
> Worried.

it's about rates... you can hose your system so bad that nothing can fix
it.

the "distro" stuff probably succeeds 10% of the time in non-artificial
cases, the kexec one has the potential at least to go 90% (so yes I
admit that I pull these numbers out of my backside but I'm with Gerrit
on this one). The stuff the distros ship is also not so nice in that you
can't dump to LVM or SAN or ... etc; kexec gets all that right. It's
also far more an all-or-nothing thing; if you make the transition you
know you're going to get a good dump; most of the other dumps die
halfway in the process at some point.


--=-CnmM3x3ygs98qRMu8doP
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCuIjJpv2rCoFn+CIRAjsKAJ9W/zOsiqzGc09x8P8GmNrM4mPzZQCfeFLp
hjfDWmbbW1PVhDhYXlp4UTo=
=Bi5A
-----END PGP SIGNATURE-----

--=-CnmM3x3ygs98qRMu8doP--

