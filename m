Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263338AbUCZDGI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 22:06:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263638AbUCZDGI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 22:06:08 -0500
Received: from 66-194-152-191.gen.twtelecom.net ([66.194.152.191]:5762 "EHLO
	pico.surpasshosting.com") by vger.kernel.org with ESMTP
	id S263338AbUCZDFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 22:05:55 -0500
Date: Thu, 25 Mar 2004 21:04:58 -0600
From: Chris Cheney <ccheney@cheney.cx>
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, acpi-devel-request@lists.sourceforge.net,
       patches@x86-64.org, ak@suse.de, len.brown@intel.com, pavel@ucw.cz
Subject: Re: [PATCH] x86_64 VIA chipset IOAPIC fix
Message-ID: <20040326030458.GZ9248@cheney.cx>
References: <20040325033434.GB8139@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="w5er4h4/Yf2qR8D9"
Content-Disposition: inline
In-Reply-To: <20040325033434.GB8139@atomide.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pico.surpasshosting.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - cheney.cx
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--w5er4h4/Yf2qR8D9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 24, 2004 at 07:34:34PM -0800, Tony Lindgren wrote:
> Hi Andi & Len,
>=20
> Sorry for cross posting all over the place, I tried to CC some people who=
 have
> been bugged by this bug.
>=20
> I finally got the IOAPIC working on my eMachines m6805 amd64 laptop with =
the
> following patch. I have not tried it on any other machines, so can you gu=
ys
> please check the sanity and make the necessary changes if needed?
>=20
> This fixes at least ACPI bug 2090:
>=20
> http://bugme.osdl.org/show_bug.cgi?id=3D2090
>=20
> Might fix some other x86 VIA bugs too?

Is this actually a "VIA" fix or a just workaround for the broken Arima
bios? I noticed that the Arima bios seems to be pretty buggy in some
other aspects as well.

BTW - Does this also solve the problem with needing USB to be compiled
directly into the kernel in 64bit mode?

Chris

--w5er4h4/Yf2qR8D9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAY53a0QZas444SvIRAtFmAKCcK1BnKUdaziTXB4hmJ0v8QBKsAgCgkGjF
IwuRrnnPwNTbEzS7gi/bFnE=
=OCna
-----END PGP SIGNATURE-----

--w5er4h4/Yf2qR8D9--
