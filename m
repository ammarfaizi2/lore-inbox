Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275603AbTHMVTF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 17:19:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275605AbTHMVTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 17:19:05 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:25817 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S275603AbTHMVSP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 17:18:15 -0400
Date: Wed, 13 Aug 2003 18:17:05 -0300
From: Eduardo Pereira Habkost <ehabkost@conectiva.com.br>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Russell King <rmk@arm.linux.org.uk>, Greg KH <greg@kroah.com>,
       "David S. Miller" <davem@redhat.com>, rddunlap@osdl.org,
       davej@redhat.com, willy@debian.org, linux-kernel@vger.kernel.org,
       kernel-janitor-discuss@lists.sourceforge.net, flavio@conectiva.com.br
Subject: Re: C99 Initialisers
Message-ID: <20030813211705.GL1685@duckman.distro.conectiva>
References: <20030813004941.GD2184@redhat.com> <32835.4.4.25.4.1060743746.squirrel@www.osdl.org> <3F39AFDF.1020905@pobox.com> <20030813031432.22b6a0d6.davem@redhat.com> <20030813173150.GA3317@kroah.com> <3F3A79CA.6010102@pobox.com> <20030813180245.GC3317@kroah.com> <3F3A82C3.5060006@pobox.com> <20030813193855.E20676@flint.arm.linux.org.uk> <3F3A952C.4050708@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YZVh52eu0Ophig4D"
Content-Disposition: inline
In-Reply-To: <3F3A952C.4050708@pobox.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--YZVh52eu0Ophig4D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2003 at 03:44:44PM -0400, Jeff Garzik wrote:
<snip>
>=20
> That ignores the people who also need to get at the data, which must=20
> first be compiled from C into object code, then extracted via modutils,=
=20
> then turned into a computer readable form again, then used.

Agreed. Someone could want to look at the data about the pci devices
_before_ the module is compiled, without needing to compile the module
or parsing C code.

I'm not sure if it will be worth, but it would be possible, for example,
to have a tool that says what modules you'll need to compile, just
looking at your hardware, at config time.

Just my 2 cents,

--=20
Eduardo

--YZVh52eu0Ophig4D
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/OqrRcaRJ66w1lWgRAuUaAJ0SjODZ8pPk3v2j/3CV3O1kZjaEwQCfQ0r0
7gzarpnfXdAeUvuTlKgUIWY=
=wK2g
-----END PGP SIGNATURE-----

--YZVh52eu0Ophig4D--
