Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265348AbUFUHN6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265348AbUFUHN6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 03:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266137AbUFUHN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 03:13:58 -0400
Received: from honk1.physik.uni-konstanz.de ([134.34.140.224]:16259 "EHLO
	honk1.physik.uni-konstanz.de") by vger.kernel.org with ESMTP
	id S265348AbUFUHN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 03:13:56 -0400
Date: Mon, 21 Jun 2004 09:11:59 +0200
From: Guido Guenther <agx@sigxcpu.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [Patch]: Fix rivafb's NV_ARCH_
Message-ID: <20040621071159.GA7017@bogon.ms20.nix>
References: <20040601041604.GA2344@bogon.ms20.nix> <1086064086.1978.0.camel@gaston> <20040601135335.GA5406@bogon.ms20.nix> <20040616070326.GE28487@bogon.ms20.nix> <20040620192549.GA4307@bogon.ms20.nix> <1087791100.24157.9.camel@gaston>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
In-Reply-To: <1087791100.24157.9.camel@gaston>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 20, 2004 at 11:11:41PM -0500, Benjamin Herrenschmidt wrote:
> On Sun, 2004-06-20 at 14:25, Guido Guenther wrote:
> > Hi,
> > On Wed, Jun 16, 2004 at 09:03:27AM +0200, Guido Guenther wrote:
> > > here's another piece of rivafb fixing that helps the driver on ppc
> > > pbooks again a bit further. It corrects several wrong NV_ARCH_20
> > > settings which are actually NV_ARCH_10 as determined by the PCIId.
> > Any comments on this patch?
>=20
> I don't, but did you ask on the linux-fbdev list ?
I've sent a patch to James several weeks ago that removes the complete
table with NV_ARCH_ mappings and uses PCI-IDs instead. He applied it to
the fbdev tree, but it didn't end up in Linus tree yet.
This patch just fixes what's obviously wrong. More cleanup to come once
rivafb is in a usable shape for me again.
Cheers,
 -- Guido

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA1oo/n88szT8+ZCYRAldQAJ9mnThibPr2ILHPuhCt1FhaZ3kdDgCfU80N
QvnQxlwU2E6x2Adt0ftEqqg=
=2xVZ
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
