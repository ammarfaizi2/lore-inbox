Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269093AbUI2Wcd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269093AbUI2Wcd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 18:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269080AbUI2WaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 18:30:06 -0400
Received: from pauli.thundrix.ch ([213.239.201.101]:41088 "EHLO
	pauli.thundrix.ch") by vger.kernel.org with ESMTP id S269150AbUI2W2C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 18:28:02 -0400
Date: Thu, 30 Sep 2004 00:23:53 +0200
From: Tonnerre <tonnerre@thundrix.ch>
To: Christoph Hellwig <hch@infradead.org>, Hanna Linder <hannal@us.ibm.com>,
       linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org,
       greg@kroah.com, kraxel@bytesex.org
Subject: Re: [PATCH 2.6.9-rc2-mm4 bttv-driver.c][4/8] convert pci_find_device to pci_dev_present
Message-ID: <20040929222353.GF21770@thundrix.ch>
References: <15470000.1096491322@w-hlinder.beaverton.ibm.com> <20040929220344.A17872@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1Ow488MNN9B9o/ov"
Content-Disposition: inline
In-Reply-To: <20040929220344.A17872@infradead.org>
X-GPG-KeyID: 0x8BE1C38D
X-GPG-Fingerprint: 1AB0 9AD6 D0C8 B9D5 C5C9  9C2A FF86 CBEE 8BE1 C38D
X-GPG-KeyURL: http://users.thundrix.ch/~tonnerre/tonnerre.asc
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1Ow488MNN9B9o/ov
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Salut,

On Wed, Sep 29, 2004 at 10:03:44PM +0100, Christoph Hellwig wrote:
> I think this check should just go away completely. =20
>=20
> We don't have such silly warnings in any other driver.

Kraxel introduced this  check because of the confusion  with the "old"
and "new" WinTV cards. The older one had a bt848 chip, the newer one a
connexant 878, and only the older one was supported by Linux.

Now that we support both, this printk is rather counterproductive.

			    Tonnerre


--1Ow488MNN9B9o/ov
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.2 (GNU/Linux)

iD8DBQFBWzX4/4bL7ovhw40RAo00AJ9NVg8hMY88u9kAggyCQEx9um0kTQCaAp2a
SQmVtsH4jYfFpBGDzPQvyVI=
=Y0BQ
-----END PGP SIGNATURE-----

--1Ow488MNN9B9o/ov--
