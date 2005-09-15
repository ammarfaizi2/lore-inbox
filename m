Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030320AbVIOMhL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030320AbVIOMhL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 08:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030325AbVIOMhL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 08:37:11 -0400
Received: from mx1.redhat.com ([66.187.233.31]:17855 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030320AbVIOMhK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 08:37:10 -0400
Subject: Re: Help porting wireless InProComm IPN 2220 driver to 2.6
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: daniel.blueman@gmail.com
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Runar Ingebrigtsen <runar@mopo.no>, Andreas Steinmetz <ast@domdv.de>
In-Reply-To: <6278d22205091504232ac3d8c3@mail.gmail.com>
References: <6278d22205091503442c3973d4@mail.gmail.com>
	 <43295825.90205@domdv.de>  <6278d22205091504232ac3d8c3@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-bGiUL/vZ1HabAgREkdAG"
Organization: Red Hat, Inc.
Date: Thu, 15 Sep 2005 08:36:52 -0400
Message-Id: <1126787812.3014.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-bGiUL/vZ1HabAgREkdAG
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> This depends if the module uses any symbols exported from the kernel
> with EXPORT_SYMBOL_GPL(), and clearly the module license - 'strings'
> should be enough do check this is you don't have a MIPS platform to
> hand.

actually it doesn't.

For one, there is section 2 of the GPL which clearly forbids this
For another, EXPORT_SYMBOL_GPL presence does NOT mean that it's ok to
use EXPORT_SYMBOL symbols without any license/copyright considerations
at all. The kernel is GPL licensed, without any exceptions.


--=-bGiUL/vZ1HabAgREkdAG
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDKWrkpv2rCoFn+CIRAt0/AJ0e1F3DUn/0rqt7USUIeT7p5vPnHACfb4LY
WoHjG4pMe05jvuqv0Z6XZOI=
=2IK1
-----END PGP SIGNATURE-----

--=-bGiUL/vZ1HabAgREkdAG--

