Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262098AbTKPT2b (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 14:28:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbTKPT2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 14:28:31 -0500
Received: from dd1234.kasserver.com ([81.209.148.157]:13006 "EHLO
	dd1234.kasserver.com") by vger.kernel.org with ESMTP
	id S262098AbTKPT23 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 14:28:29 -0500
Date: Sun, 16 Nov 2003 19:28:27 +0000
From: Jochen Voss <voss@seehuhn.de>
To: Kai Henningsen <kaih@khms.westfalen.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: invalid SMP mptable on Toshiba Satellite 2430-301
Message-ID: <20031116192827.GA1155@seehuhn.de>
References: <20031113184506.GA602@seehuhn.de> <8xzs6cPHw-B@khms.westfalen.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
In-Reply-To: <8xzs6cPHw-B@khms.westfalen.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Kai,

On Sun, Nov 16, 2003 at 06:31:00PM +0200, Kai Henningsen wrote:
> voss@seehuhn.de (Jochen Voss)  wrote on 13.11.03 in <20031113184506.GA602=
@seehuhn.de>:
>=20
> > With SMP and ACPI enabled I get the following kernel
> > boot messages
>=20
> > but later-on the following messages appear:
> >
> >     No local APIC present or hardware disabled
>=20
> >     Local APIC not detected. Using dummy APIC emulation.
>=20
> Hmmm ... are you sure you didn't confuse ACPI with APIC?
Yes, I am sure.  I had ACPI enabled (on request by Linus)
and the messages are about the APIC.

As far as I understand this, the situation is as follows:
The original problem was related to the APIC and the
multiprocessor (here: hyper-threading) configuration.  The
system tries to use ACPI to acquire information about the
multiprocessor configuration.  If ACPI succeeded in doing
so, then my kernel would not try to read the mptable, and
the crash would not occur.

I hope this helps,
Jochen
--=20
http://seehuhn.de/

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/t8/bf+iD8yEbECURAoPvAJ46jlLO36g0ZXt3hn2rC0zpctxiSQCfR0bN
mEMx5TE6TC/i1RYhIpmSVCE=
=EpED
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
