Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262673AbVAKKKr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262673AbVAKKKr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 05:10:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262680AbVAKKKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 05:10:47 -0500
Received: from wavehammer.waldi.eu.org ([82.139.196.55]:64948 "EHLO
	wavehammer.waldi.eu.org") by vger.kernel.org with ESMTP
	id S262673AbVAKKKk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 05:10:40 -0500
Date: Tue, 11 Jan 2005 11:10:38 +0100
From: Bastian Blank <bastian@waldi.eu.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Richard Henderson <rth@twiddle.net>
Subject: Re: removing bcopy... because it's half broken
Message-ID: <20050111101010.GB27768@wavehammer.waldi.eu.org>
Mail-Followup-To: Bastian Blank <bastian@waldi.eu.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Christoph Hellwig <hch@infradead.org>,
	Arjan van de Ven <arjan@infradead.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Richard Henderson <rth@twiddle.net>
References: <20050109192305.GA7476@infradead.org> <Pine.LNX.4.58.0501091213000.2339@ppc970.osdl.org> <20050109203459.GA28788@infradead.org> <Pine.LNX.4.58.0501091240550.2339@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7qSK/uQB79J36Y4o"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0501091240550.2339@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7qSK/uQB79J36Y4o
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 09, 2005 at 12:42:42PM -0800, Linus Torvalds wrote:
> On Sun, 9 Jan 2005, Christoph Hellwig wrote:
> > We're building with -ffreestanding now, so gcc isn't allowed to emit
> > any calls to standard library functions.
> Bzzt. It still emits calls to libgcc.=20

Yes. This means IMHO that the image and every module needs to link
against libgcc to include the required symbols. It is rather annoying to
see modules asking for libgcc symbols.

Bastian

--=20
It would be illogical to assume that all conditions remain stable.
		-- Spock, "The Enterprise Incident", stardate 5027.3

--7qSK/uQB79J36Y4o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iEYEARECAAYFAkHjph4ACgkQnw66O/MvCNEz7gCfYeIPFZpuYuoi7ZFY48KEHpPX
hl8An2akr0IBNzh/PHrRKrVYSThtFynV
=xPLo
-----END PGP SIGNATURE-----

--7qSK/uQB79J36Y4o--
