Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269469AbUIZBbg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269469AbUIZBbg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 21:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269470AbUIZBbc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 21:31:32 -0400
Received: from pauli.thundrix.ch ([213.239.201.101]:25575 "EHLO
	pauli.thundrix.ch") by vger.kernel.org with ESMTP id S269469AbUIZBba
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 21:31:30 -0400
Date: Sun, 26 Sep 2004 03:29:25 +0200
From: Tonnerre <tonnerre@thundrix.ch>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Albert Cahalan <albert@users.sf.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       rth@twiddle.net
Subject: Re: __attribute__((always_inline)) fiasco
Message-ID: <20040926012925.GA14305@thundrix.ch>
References: <1095956778.4966.940.camel@cube> <20040923165026.GF9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
In-Reply-To: <20040923165026.GF9106@holomorphy.com>
X-GPG-KeyID: 0x8BE1C38D
X-GPG-Fingerprint: 1AB0 9AD6 D0C8 B9D5 C5C9  9C2A FF86 CBEE 8BE1 C38D
X-GPG-KeyURL: http://users.thundrix.ch/~tonnerre/tonnerre.asc
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Salut,

On Thu, Sep 23, 2004 at 09:50:26AM -0700, William Lee Irwin III wrote:
> On Thu, Sep 23, 2004 at 12:26:18PM -0400, Albert Cahalan wrote:
> > #define INLINE static inline  // an oxymoron
> > #define INLINE extern inline  // an oxymoron
>=20
> The // apart from being a C++ ism (screw C99; it's still non-idiomatic)
> will cause spurious ignorance of the remainder of the line, which is
> often very important. e.g.
>=20
> static INLINE int lock_need_resched(spinlock_t *lock)
> {
> 	...

Mmm, shouldn't the comments be filtered *before* the definition is set
in place? Just wondering...

			    Tonnerre

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.2 (GNU/Linux)

iD8DBQFBVht0/4bL7ovhw40RAqVWAKC6fIsDZdpuaQcW1k1s9OxMIXemIgCbBoEa
8IqDgpUjQZDOku/5SIdpR7g=
=K/2i
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
