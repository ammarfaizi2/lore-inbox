Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269133AbUINC0N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269133AbUINC0N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 22:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269130AbUINCXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 22:23:47 -0400
Received: from pauli.thundrix.ch ([213.239.201.101]:14287 "EHLO
	pauli.thundrix.ch") by vger.kernel.org with ESMTP id S269127AbUINCW5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 22:22:57 -0400
Date: Tue, 14 Sep 2004 04:21:25 +0200
From: Tonnerre <tonnerre@thundrix.ch>
To: Hanna Linder <hannal@us.ibm.com>, ink@jurassic.park.msu.ru,
       linux-kernel@vger.kernel.org, greg@kroah.com, wli@holomorphy.com
Subject: Re: [RFT 2.6.9-rc1 alpha sys_sio.c] [2/2] convert pci_find_device to pci_get_device
Message-ID: <20040914022125.GA20950@thundrix.ch>
References: <806430000.1095118643@w-hlinder.beaverton.ibm.com> <20040914002933.GA20390@thundrix.ch> <20040914020222.GB23058@twiddle.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
In-Reply-To: <20040914020222.GB23058@twiddle.net>
X-GPG-KeyID: 0x8BE1C38D
X-GPG-Fingerprint: 1AB0 9AD6 D0C8 B9D5 C5C9  9C2A FF86 CBEE 8BE1 C38D
X-GPG-KeyURL: http://users.thundrix.ch/~tonnerre/tonnerre.asc
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Salut,

On Mon, Sep 13, 2004 at 07:02:22PM -0700, Richard Henderson wrote:
> On Tue, Sep 14, 2004 at 02:29:33AM +0200, Tonnerre wrote:
> > > -	while ((dev =3D pci_find_device(PCI_VENDOR_ID_NCR, PCI_ANY_ID, dev)=
)) {
> > > +	while ((dev =3D pci_get_device(PCI_VENDOR_ID_NCR, PCI_ANY_ID, dev))=
) {
> > >                  if (dev->device =3D=3D PCI_DEVICE_ID_NCR_53C810
> > >  		    || dev->device =3D=3D PCI_DEVICE_ID_NCR_53C815
> > >  		    || dev->device =3D=3D PCI_DEVICE_ID_NCR_53C820
> >=20
> > Don't we need to put these devices in some place?
>=20
> pci_get_device does that for non-null "from" argument.

I was talking about pci_put_device(dev)..

				Tonnerre

--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.2 (GNU/Linux)

iD8DBQFBRlWk/4bL7ovhw40RAqZAAKCI8EW0tj72EPp9ZxgAneLM4LB7pgCguUuM
0+B4LQu2moSEE2sJIhvDkJ4=
=6iOy
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
