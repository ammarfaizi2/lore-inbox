Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267291AbUI0T5n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267291AbUI0T5n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 15:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267298AbUI0T5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 15:57:42 -0400
Received: from pauli.thundrix.ch ([213.239.201.101]:24554 "EHLO
	pauli.thundrix.ch") by vger.kernel.org with ESMTP id S267291AbUI0T5Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 15:57:25 -0400
Date: Mon, 27 Sep 2004 21:55:10 +0200
From: Tonnerre <tonnerre@thundrix.ch>
To: Christoph Hellwig <hch@infradead.org>,
       Antony Suter <suterant@users.sourceforge.net>,
       List LKML <linux-kernel@vger.kernel.org>, torvalds@osdl.org
Subject: Re: [PATCH] __VMALLOC_RESERVE export
Message-ID: <20040927195510.GD17487@thundrix.ch>
References: <1096304623.9430.8.camel@hikaru.lan> <20040927181229.A25704@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jCrbxBqMcLqd4mOl"
Content-Disposition: inline
In-Reply-To: <20040927181229.A25704@infradead.org>
X-GPG-KeyID: 0x8BE1C38D
X-GPG-Fingerprint: 1AB0 9AD6 D0C8 B9D5 C5C9  9C2A FF86 CBEE 8BE1 C38D
X-GPG-KeyURL: http://users.thundrix.ch/~tonnerre/tonnerre.asc
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jCrbxBqMcLqd4mOl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Salut,

On Mon, Sep 27, 2004 at 06:12:29PM +0100, Christoph Hellwig wrote:
> On Tue, Sep 28, 2004 at 03:03:43AM +1000, Antony Suter wrote:
> > __VMALLOC_RESERVE itself is not exported but is used by something that
> > is. This patch is against 2.6.9-rc2-bk11
> >=20
> > This is required by the nvidia binary driver 1.0.6111
>=20
> And the driver does absolutely nasty things it shouldn't do.  This is an
> implementation detail that absolutely should not be exported.

NVidia isn't the only user...

Every  kernel  module  that  uses  just anything  that  uses  the  old
__VMALLOC_RESERVE define was broken without this patch.

			    Tonnerre

--jCrbxBqMcLqd4mOl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.2 (GNU/Linux)

iD8DBQFBWHAd/4bL7ovhw40RAgjkAJ9CSjV5JHWdSJlBchkgkUVEEeFB/wCgqNhW
uB1LJOxGK74XsftfyuJrxcw=
=XUlI
-----END PGP SIGNATURE-----

--jCrbxBqMcLqd4mOl--
