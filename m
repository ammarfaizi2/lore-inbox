Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263093AbUEFVqj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263093AbUEFVqj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 17:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263100AbUEFVqj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 17:46:39 -0400
Received: from zak.futurequest.net ([69.5.6.152]:40396 "HELO
	zak.futurequest.net") by vger.kernel.org with SMTP id S263093AbUEFVqh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 17:46:37 -0400
Date: Thu, 6 May 2004 15:46:35 -0600
From: Bruce Guenter <bruceg@em.ca>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc3-mm2
Message-ID: <20040506214635.GA29187@em.ca>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040505013135.7689e38d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
In-Reply-To: <20040505013135.7689e38d.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 05, 2004 at 01:31:35AM -0700, Andrew Morton wrote:
> Move-saved_command_line-to-init-mainc.patch
>   Move saved_command_line to init/main.c

This patch appears to be breaking serial console for me.  Reverting this
patch with patch -R makes it work again.  I can't tell from the contents
of the patch why it causes problems, but it does.  I'd be happy to
provide any further details if required.
--=20
Bruce Guenter <bruceg@em.ca> http://em.ca/~bruceg/ http://untroubled.org/
OpenPGP key: 699980E8 / D0B7 C8DD 365D A395 29DA  2E2A E96F B2DC 6999 80E8

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAmrI76W+y3GmZgOgRAh/wAKCYioqngpsCjiBS0DWRqhKJUXDvRgCfdsif
F/eQNHnqxuHTW+GY4FoC3aI=
=HOQw
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
