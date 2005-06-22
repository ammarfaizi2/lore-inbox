Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261589AbVFVQzo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261589AbVFVQzo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 12:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261699AbVFVQzn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 12:55:43 -0400
Received: from nysv.org ([213.157.66.145]:55428 "EHLO nysv.org")
	by vger.kernel.org with ESMTP id S261589AbVFVQyh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 12:54:37 -0400
Date: Wed, 22 Jun 2005 19:54:28 +0300
To: "M." <vo.sinh@gmail.com>
Cc: "Artem B. Bityuckiy" <dedekind@yandex.ru>,
       Christophe Saout <christophe@saout.de>, Andrew Morton <akpm@osdl.org>,
       Hans Reiser <reiser@namesys.com>, hch@infradead.org, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: reiser4 plugins
Message-ID: <20050622165428.GA11013@nysv.org>
References: <42B831B4.9020603@pobox.com> <42B87318.80607@namesys.com> <20050621202448.GB30182@infradead.org> <42B8B9EE.7020002@namesys.com> <20050621181802.11a792cc.akpm@osdl.org> <1119452212.15527.33.camel@server.cs.pocnet.net> <42B97F82.6040404@yandex.ru> <20050622155505.GZ11013@nysv.org> <42B98FD5.6050201@yandex.ru> <f0cc385605062209464d5619a2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bNvn4bxlrUVLu6cT"
Content-Disposition: inline
In-Reply-To: <f0cc385605062209464d5619a2@mail.gmail.com>
User-Agent: Mutt/1.5.9i
From: mjt@nysv.org (Markus  =?ISO-8859-1?Q?=20T=F6rnqvist?=)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bNvn4bxlrUVLu6cT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 22, 2005 at 06:46:50PM +0200, M. wrote:
>
>Is it not simpler to ask the reiserfs guys for a detailed explanation
>of why and where this plugins' layer differs from using VFS for
>plugins and let others comment on that ?

I hope this is not FUD or something like that, but it seems to me
the VFS guys are not too willing to implement Reiser4-HiFi stuff anywhere
else, like the VFS, and don't want Reiser4 in, because it duplicates.

Think of the chicken and the egg.

I may be wrong, though.

>If something cant be done using VFS this layer is needed by reiser4
>and has to be merged.

But it's still possible to let Reiser4 in and take them, say, a feature
at a time to the VFS.

Unless it's going to be a political wankfest/pissing contest about
if things like this should even be implemented, anywhere, ever :P

--=20
mjt



--bNvn4bxlrUVLu6cT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCuZfEIqNMpVm8OhwRAtOUAKC+ubZYVypKK/+MvMZ/2q3S8ZJz8wCdGElM
FDNafKVlMSay7Xlo5PTaE6U=
=DY1c
-----END PGP SIGNATURE-----

--bNvn4bxlrUVLu6cT--
