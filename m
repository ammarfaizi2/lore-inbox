Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751116AbVKATAc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbVKATAc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 14:00:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbVKATAc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 14:00:32 -0500
Received: from mout1.freenet.de ([194.97.50.132]:48831 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S1751116AbVKATAb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 14:00:31 -0500
From: Michael Buesch <mbuesch@freenet.de>
To: alex@alexfisher.me.uk
Subject: Re: Would I be violating the GPL?
Date: Tue, 1 Nov 2005 20:00:20 +0100
User-Agent: KMail/1.8
References: <5449aac20511010949x5d96c7e0meee4d76a67a06c01@mail.gmail.com>
In-Reply-To: <5449aac20511010949x5d96c7e0meee4d76a67a06c01@mail.gmail.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <200511012000.21176.mbuesch@freenet.de>
Content-Type: multipart/signed;
  boundary="nextPart4257631.sOg7Cy3drt";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4257631.sOg7Cy3drt
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 01 November 2005 18:49, Alexander Fisher wrote:
> Hello.
>=20
> A supplier of a PCI mezzanine digital IO card has provided a linux 2.4
> driver as source code.  They have provided this code source with a
> license stating I won't redistribute it in anyway.
> My concern is that if I build this code into a module, I won't be able
> to distribute it to customers without violating either the GPL (by not
> distributing the source code), or the proprietary source code license
> as currently imposed by the supplier.
> From what I have read, this concern is only valid if the binary module
> is considered to be a 'derived work' of the kernel.  The module source
> directly includes the following kernel headers :

Take the code and write a specification for the device.
Should be fairly easy.
Someone else will pick up the spec and write a clean GPLed driver.

Like these, without the reverse engineering part:
http://en.wikipedia.org/wiki/Clean_room_design
http://en.wikipedia.org/wiki/Chinese_wall#Computer_science

=2D-=20
Greetings Michael.

--nextPart4257631.sOg7Cy3drt
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBDZ7tFlb09HEdWDKgRAtkJAKCXh80JAnc74fZkkI4exdUgbMLtqACdFk7N
fjwVBsmNB2iNk/o7EW7krK8=
=WHXq
-----END PGP SIGNATURE-----

--nextPart4257631.sOg7Cy3drt--
