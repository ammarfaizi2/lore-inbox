Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262602AbSKZXZW>; Tue, 26 Nov 2002 18:25:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263204AbSKZXZW>; Tue, 26 Nov 2002 18:25:22 -0500
Received: from parmenides.zen.co.uk ([212.23.8.69]:776 "HELO
	parmenides.zen.co.uk") by vger.kernel.org with SMTP
	id <S262602AbSKZXZU>; Tue, 26 Nov 2002 18:25:20 -0500
X-Zen-Trace: 217.155.72.205
Date: Tue, 26 Nov 2002 23:21:22 +0000
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: A Kernel Configuration Tale of Woe
Message-ID: <20021126232121.A12861@computer-surgery.co.uk>
References: <3de3cc8d.54dd.0@wincom.net> <1038341131.2534.73.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1038341131.2534.73.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Tue, Nov 26, 2002 at 08:05:31PM +0000
From: Roger Gammans <roger@computer-surgery.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2002 at 08:05:31PM +0000, Alan Cox wrote:
> On Tue, 2002-11-26 at 19:28, Dennis Grant wrote:
> > Agreed - so then the association between "board" and "chipset" must be =
capable
> > of being multi-valued, and when there is a mult-valued match there must=
 be some
> > means of further interrogating the user (or user agent) for more inform=
ation.
>=20
> Much simpler to just include "modular everything" and let user space
> sort it out. Guess why every vendor takes this path

Is there a tool though to map bus (PCI,USB etc) id's back=20
onto modules which are likely[1] contain driver for them.

Given that many driver contain the Ids of the devices they will handle
within their source, if this tool doesn't exist it could be built
by ask modules to define a test_id function used both by themselves
in the normal (ie , called in place of the code it moves into a
seperate fucntion) way and compiled into a user space utility from the
same kernel source.

TTFN

[1]	Only likely, having met the nasty case of different
	hardware with the same PCMCIA id, and PCI hardware which has
	a range of Ids associated with it.
--=20
Roger.
Master of Peng Shui.  (Ancient oriental art of Penguin Arranging)
GPG Key FPR: CFF1 F383 F854 4E6A 918D  5CFF A90D E73B 88DE 0B3E

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE95AHxqQ3nO4jeCz4RApYvAJ46usntVv3THho1o0ACzxE520LrAwCggKit
1gVcj5fKOUtM5Ab4PtMyENc=
=zI+I
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
