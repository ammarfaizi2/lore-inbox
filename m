Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262406AbTESLUy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 07:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262412AbTESLUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 07:20:54 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:25841 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S262406AbTESLUw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 07:20:52 -0400
Subject: Re: Recent changes to sysctl.h breaks glibc
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Martin Schlemmer <azarah@gentoo.org>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Christoph Hellwig <hch@infradead.org>,
       KML <linux-kernel@vger.kernel.org>
In-Reply-To: <1053342842.9152.90.camel@workshop.saharact.lan>
References: <1053289316.10127.41.camel@nosferatu.lan>
	 <20030518204956.GB8978@holomorphy.com>
	 <1053292339.10127.45.camel@nosferatu.lan>
	 <20030519063813.A30004@infradead.org>
	 <1053341023.9152.64.camel@workshop.saharact.lan>
	 <20030519105152.GD8978@holomorphy.com>
	 <1053342842.9152.90.camel@workshop.saharact.lan>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-oQDJUC91SGf5dbSGPJC/"
Organization: Red Hat, Inc.
Message-Id: <1053344020.1430.3.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 (1.2.4-2) 
Date: 19 May 2003 13:33:40 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-oQDJUC91SGf5dbSGPJC/
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-05-19 at 13:14, Martin Schlemmer wrote:
> On Mon, 2003-05-19 at 12:51, William Lee Irwin III wrote:
>=20
> > IIRC you're supposed to use some sort of sanitized copy, not the things
> > directly. IMHO the current state of affairs sucks as there is no
> > standard set of ABI headers, but grabbing them right out of the kernel
> > is definitely not the way to go.
> >=20
>=20
> Ok, anybody know of an effort to get this done ?

Red Hat Linux ships with a mostly sanitized header set for this.
>=20
> Also, what about odd things that are more kernel dependant
> like imon support in fam for example ?  The imon.h will not
> be in the 'sanitized copy' ....

apps that have such deep knowledge about internals are supposed to
provide their own copy of the headers in RHL at least. But there are few
of those.

--=-oQDJUC91SGf5dbSGPJC/
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA+yMEUxULwo51rQBIRAmihAKCaJzovAFe5vfoF3IbK2lm3f2fgSwCdFIKq
jPgtdHo3dAiQZIV+r8YB36Y=
=lK/c
-----END PGP SIGNATURE-----

--=-oQDJUC91SGf5dbSGPJC/--
