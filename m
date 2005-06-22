Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261529AbVFVP7h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261529AbVFVP7h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 11:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261557AbVFVP5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 11:57:12 -0400
Received: from nysv.org ([213.157.66.145]:10403 "EHLO nysv.org")
	by vger.kernel.org with ESMTP id S261561AbVFVPzH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 11:55:07 -0400
Date: Wed, 22 Jun 2005 18:55:05 +0300
To: "Artem B. Bityuckiy" <dedekind@yandex.ru>
Cc: Christophe Saout <christophe@saout.de>, Andrew Morton <akpm@osdl.org>,
       Hans Reiser <reiser@namesys.com>, hch@infradead.org, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: reiser4 plugins
Message-ID: <20050622155505.GZ11013@nysv.org>
References: <20050620235458.5b437274.akpm@osdl.org> <42B831B4.9020603@pobox.com> <42B87318.80607@namesys.com> <20050621202448.GB30182@infradead.org> <42B8B9EE.7020002@namesys.com> <20050621181802.11a792cc.akpm@osdl.org> <1119452212.15527.33.camel@server.cs.pocnet.net> <42B97F82.6040404@yandex.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wwU9tsYnHnYeRAKj"
Content-Disposition: inline
In-Reply-To: <42B97F82.6040404@yandex.ru>
User-Agent: Mutt/1.5.9i
From: mjt@nysv.org (Markus  =?ISO-8859-1?Q?=20T=F6rnqvist?=)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wwU9tsYnHnYeRAKj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 22, 2005 at 07:10:58PM +0400, Artem B. Bityuckiy wrote:
>
>More filesystems in future may want to use these semantics. There are=20
>cases when one can't use Reiser4 to implement them, but instead, need to=
=20
>implement another file system with the same semantics.

So merge it as it is and move the stuff to the VFS as needed or
deemed necessary. And enable the pseudo interface, or at least
set it in menuconfig and enable by default, it needs testing too.

Then someone says "we can't implement this in the fs" and someone
else says "we can't implement this in the vfs" and someone else
says "this is a good thing which we want but you won't let us"
and we stagnate again...

Isn't this bickering getting a bit old?
After all, it seems the code is merged in -mm, the big issues are fixed
and all should be ready for more real-life testing and such?

--=20
mjt


--wwU9tsYnHnYeRAKj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCuYnZIqNMpVm8OhwRAlNhAKCzjcojE8bVWZjWJt+vbWg1XMX2CgCgzRMq
fYY23GL0oeKp4ICxqZxTJpk=
=4wWu
-----END PGP SIGNATURE-----

--wwU9tsYnHnYeRAKj--
