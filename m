Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266217AbUAIEtl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 23:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266232AbUAIEtl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 23:49:41 -0500
Received: from smtp1.clear.net.nz ([203.97.33.27]:18902 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP id S266217AbUAIEtj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 23:49:39 -0500
Date: Fri, 09 Jan 2004 17:50:14 +1300
From: Nigel Cunningham <ncunningham@users.sourceforge.net>
Subject: Re: Is this too ugly to merge?
In-reply-to: <3FFE31B6.1030205@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Reply-to: ncunningham@users.sourceforge.net
Message-id: <1073623814.10388.6.camel@laptop-linux>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk
Content-type: multipart/signed; boundary="=-hK9I3Lpym0qrWRvOniZR";
 protocol="application/pgp-signature"; micalg=pgp-sha1
References: <1073609923.2003.10.camel@laptop-linux> <3FFE31B6.1030205@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-hK9I3Lpym0qrWRvOniZR
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Well, they manipulate a variable local to the procedure, so I believe
so. I have to record which routine the activity flag was set it,
possibly pass through other routines that could set it and not clear it
until we get back to the routine where it was first set. I'm sure
there'd be another way, but I can only think of more complicated ones,
not simpler and prettier :>

Nigel

On Fri, 2004-01-09 at 17:44, Stephen Hemminger wrote:
> Nigel Cunningham wrote:
>=20
> > Hi all.
> >=20
> > I'm wanting to the opinion, if I may, of more experienced people
> > regarding changes I have implemented in my version of Software Suspend,
> > which I want to merge with Patrick and Pavel. Since I'm don't expect
> > that you're all familiar with how my version works, I'll give a fair bi=
t
> > of background before I come to the question.
>=20
> Do they all have to be big ugly macros?
>=20
--=20
My work on Software Suspend is graciously brought to you by
LinuxFund.org.

--=-hK9I3Lpym0qrWRvOniZR
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA//jMGVfpQGcyBBWkRAiFoAJ9reo8TbtXBdRTxHWbCOah9Dz5LHACeLUoa
iu6b3C+sW9zXpmOjasqPQr8=
=Jq0h
-----END PGP SIGNATURE-----

--=-hK9I3Lpym0qrWRvOniZR--

