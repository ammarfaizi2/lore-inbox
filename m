Return-Path: <linux-kernel-owner+w=401wt.eu-S1750871AbXAOPqv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750871AbXAOPqv (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 10:46:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750875AbXAOPqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 10:46:51 -0500
Received: from iucha.net ([209.98.146.184]:36444 "EHLO mail.iucha.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750847AbXAOPqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 10:46:50 -0500
Date: Mon, 15 Jan 2007 09:46:49 -0600
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jiri Kosina <jikos@jikos.cz>, linux-usb-devel@lists.sourceforge.net,
       Adrian Bunk <bunk@stusta.de>, Alan Stern <stern@rowland.harvard.edu>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: heavy nfs[4]] causes fs badness Was: 2.6.20-rc4: known unfixed regressions (v2)
Message-ID: <20070115154649.GE6053@iucha.net>
References: <20070114235816.GB6053@iucha.net> <200701150211.l0F2BDgI015824@laptop13.inf.utfsm.cl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0H629O+sVkh21xTi"
Content-Disposition: inline
In-Reply-To: <200701150211.l0F2BDgI015824@laptop13.inf.utfsm.cl>
X-GPG-Key: http://iucha.net/florin_iucha.gpg
X-GPG-Fingerprint: 5E59 C2E7 941E B592 3BA4  7DCF 343D 2B14 2376 6F5B
User-Agent: Mutt/1.5.13 (2006-08-11)
From: florin@iucha.net (Florin Iucha)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0H629O+sVkh21xTi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 14, 2007 at 11:11:13PM -0300, Horst H. von Brand wrote:
> Florin Iucha <florin@iucha.net> wrote:
>=20
> [...]
>=20
> > Based on this info, I think we can rule out any USB.  I will try
> > testing with NFS3 to see if the problem persists.  Unfortunately there
> > is no oops or anything in "dmesg".
>=20
> Take a look at bz #7796, a NFS bug + fix. But my feelin is that this is
> older.

The reported had and oops?  Luxury!  I get nothing ;)

I am testing again, this time on 2.6.20-rc5 compiled with extra debug
and I got a couple dozens of:

   "eth0: too many iterations (6) in nv_nic_irq."

in the kernel log.

florin

--=20
Bruce Schneier expects the Spanish Inquisition.
      http://geekz.co.uk/schneierfacts/fact/163

--0H629O+sVkh21xTi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFFq6HpND0rFCN2b1sRAtA3AJ9EtXGI/O5C3CSSY7xOEEeHm+/o3ACff0pb
JgkGfC4whc2R576yXAa/h9I=
=0/o7
-----END PGP SIGNATURE-----

--0H629O+sVkh21xTi--
