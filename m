Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263518AbUA3LS3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 06:18:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263513AbUA3LS3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 06:18:29 -0500
Received: from c-24-99-36-145.atl.client2.attbi.com ([24.99.36.145]:43525 "EHLO
	babylon.d2dc.net") by vger.kernel.org with ESMTP id S263518AbUA3LSG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 06:18:06 -0500
Date: Fri, 30 Jan 2004 06:18:05 -0500
From: "Zephaniah E. Hull" <warp@babylon.d2dc.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.2-rc2-mm1
Message-ID: <20040130111805.GC2505@babylon.d2dc.net>
Mail-Followup-To: Vojtech Pavlik <vojtech@suse.cz>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@osdl.org>
References: <20040127233402.6f5d3497.akpm@osdl.org> <20040130104829.GA2505@babylon.d2dc.net> <20040130110205.GA1583@ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XWOWbaMNXpFDWE00"
Content-Disposition: inline
In-Reply-To: <20040130110205.GA1583@ucw.cz>
X-Notice-1: Unsolicited Commercial Email (Aka SPAM) to ANY systems under
X-Notice-2: our control constitutes a $US500 Administrative Fee, payable
X-Notice-3: immediately.  By sending us mail, you hereby acknowledge that
X-Notice-4: policy and agree to the fee.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--XWOWbaMNXpFDWE00
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2004 at 12:02:05PM +0100, Vojtech Pavlik wrote:
> On Fri, Jan 30, 2004 at 05:48:29AM -0500, Zephaniah E. Hull wrote:
> > On Tue, Jan 27, 2004 at 11:34:02PM -0800, Andrew Morton wrote:
> > >=20
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.2-r=
c2/2.6.2-rc2-mm1/
> > >=20
> > > - From now on, -mm kernels will contain the latest contents of:
> > >=20
> > > 	Vojtech's tree:		input.patch
> >=20
> > This one seems to have a rather problematic patch, which I can't find
> > any explanation for.
>=20
> There is another revision of the same mouse from A4Tech (owned by
> Jaroslav Kysela), that reports itself as Cypress and has the buttons a
> bit differently.
>=20
> If it indeed collides with your mouse, then we need somehow to specify
> which button carries the wheel information in the quirk list.

Ugh, that is not fun, it does indeed conflict.
How about HID_QUIRK_2WHEEL_MOUSE_HACK_EXTRA and
HID_QUIRK_2WHEEL_MOUSE_HACK_BACK as quirk names?

--=20
	1024D/E65A7801 Zephaniah E. Hull <warp@babylon.d2dc.net>
	   92ED 94E4 B1E6 3624 226D  5727 4453 008B E65A 7801
	    CCs of replies from mailing lists are requested.

I could imagine that there might be some GPL project out there that
_deserves_ getting sued(*) and it has nothing to do with Linux.

                Linus

(*) "GNU Emacs, the defendent, did inefariously conspire to play
towers-of-hanoy, while under the guise of a harmless editor".

--XWOWbaMNXpFDWE00
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAGj1tRFMAi+ZaeAERAiadAJ9p0mXNYHkggc5SmtyzGUZa2X/voQCdFCrs
YzpyQRiopiM1w3YsYZgTZCA=
=apJI
-----END PGP SIGNATURE-----

--XWOWbaMNXpFDWE00--
