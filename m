Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261909AbUKUHPz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261909AbUKUHPz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 02:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261918AbUKUHPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 02:15:55 -0500
Received: from dreamcraft.com.au ([202.55.152.18]:63617 "EHLO
	dreamcraft.com.au") by vger.kernel.org with ESMTP id S261909AbUKUHPg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 02:15:36 -0500
Date: Sun, 21 Nov 2004 18:15:30 +1100
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 PATCH] visor: Always do generic_startup
Message-ID: <20041121071530.GA5586@himi.org>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org
References: <20041116154943.GA13874@k3.hellgate.ch> <20041119174405.GE20162@kroah.com> <20041121012353.GA4008@himi.org> <20041121040856.GB1569@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XOIedfhf+7KOe/yw"
Content-Disposition: inline
In-Reply-To: <20041121040856.GB1569@kroah.com>
User-Agent: Mutt/1.5.6+20040722i
From: simon@himi.org (Simon Fowler)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--XOIedfhf+7KOe/yw
Content-Type: multipart/mixed; boundary="huq684BweRXVnRxX"
Content-Disposition: inline


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 20, 2004 at 08:08:56PM -0800, Greg KH wrote:
> On Sun, Nov 21, 2004 at 12:23:53PM +1100, Simon Fowler wrote:
> > On Fri, Nov 19, 2004 at 09:44:05AM -0800, Greg KH wrote:
> > > On Tue, Nov 16, 2004 at 04:49:43PM +0100, Roger Luethi wrote:
> > > > generic_startup in visor.c was not called for some hardware, result=
ing
> > > > in attempts to access memory that had never been allocated, which in
> > > > turn caused the problem several people reported with recent (2.6.10=
ish)
> > > > kernels.
> > > >=20
> > > > Signed-off-by: Roger Luethi <rl@hellgate.ch>
> > >=20
> > > Thanks for finding this.
> > >=20
> > > Applied.
> > >=20
> > This patch fixes the oops, but after applying it I can no longer
> > sync my palm 5 - it starts, but part way through the connection is
> > lost.
>=20
> Can you enable debugging in the visor driver (either through the
> modprobe paramater, or through the /sys/module/paramater/debug file, and
> send it to us?
>=20
I've attached the gzipped log file, from the point it the new USB
device is registered to the point the device nodes are deleted by
udev.

Simon

--=20
PGP public key Id 0x144A991C, or http://himi.org/stuff/himi.asc
(crappy) Homepage: http://himi.org
doe #237 (see http://www.lemuria.org/DeCSS)=20
My DeCSS mirror: ftp://himi.org/pub/mirrors/css/=20

--huq684BweRXVnRxX
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="visor-debug.gz"
Content-Transfer-Encoding: base64

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

--huq684BweRXVnRxX--

--XOIedfhf+7KOe/yw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBoECSQPlfmRRKmRwRArjAAJ0byOn3yCT49mT2ARMPVWUbNMgFMwCgxxyX
LX08Mv8pJESBlMC5QEXhL8A=
=30Y/
-----END PGP SIGNATURE-----

--XOIedfhf+7KOe/yw--
