Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932348AbWDBOgA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbWDBOgA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 10:36:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932349AbWDBOgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 10:36:00 -0400
Received: from 169.248.adsl.brightview.com ([80.189.248.169]:41480 "EHLO
	getafix.willow.local") by vger.kernel.org with ESMTP
	id S932348AbWDBOf7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 10:35:59 -0400
Date: Sun, 2 Apr 2006 15:35:57 +0100
From: John Mylchreest <johnm@gentoo.org>
To: Olaf Hering <olh@suse.de>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       stable@kernel.org, paulus@samba.org
Subject: Re: [PATCH 1/1] POWERPC: Fix ppc32 compile with gcc+SSP in 2.6.16
Message-ID: <20060402143557.GC3443@getafix.willow.local>
References: <20060401224849.GH16917@getafix.willow.local> <20060402085850.GA28857@suse.de> <20060402102259.GM16917@getafix.willow.local> <20060402102815.GA29717@suse.de> <20060402105859.GN16917@getafix.willow.local> <20060402111002.GA30017@suse.de> <20060402112002.GA3443@getafix.willow.local> <1143983738.2994.18.camel@laptopd505.fenrus.org> <20060402135605.GB3443@getafix.willow.local> <20060402140129.GA31403@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="c3bfwLpm8qysLVxt"
Content-Disposition: inline
In-Reply-To: <20060402140129.GA31403@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--c3bfwLpm8qysLVxt
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 02, 2006 at 04:01:29PM +0200, Olaf Hering <olh@suse.de> wrote:
>  On Sun, Apr 02, John Mylchreest wrote:
>=20
> > It gets turned on elsewhere (gcc spec), but principle for me is that if=
 its
> > enabled it still leaks and breaks this code. At the moment (following
> > from existing patches you put to this list) this mix will break until we
> > get stack-protector ported.
>=20
> There are so many ebuild files which turn off random gcc options without
> fixing the real bug in the compiler. Just add one more to the
> kernel.ebuild or whatever its called.

That's just showing the ignorance to how kernel-sources are hendled from
within gentoo (but this isnt gentoo specific anyways. Its relative to
the gcc spec file were using). Once I get a little time this afternoon I
will look at a cleaner fix.

--=20
Role:            Gentoo Linux Kernel Lead
Gentoo Linux:    http://www.gentoo.org
Public Key:      gpg --recv-keys 9C745515
Key fingerprint: A0AF F3C8 D699 A05A EC5C  24F7 95AA 241D 9C74 5515


--c3bfwLpm8qysLVxt
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEL+FNNzVYcyGvtWURAge2AJ4o15sV043YvE3OZmyk9BpV6rkK8gCfc+S0
72FHgVUXHBDGnU/yiwBCFhs=
=J15M
-----END PGP SIGNATURE-----

--c3bfwLpm8qysLVxt--
