Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268693AbUIMSiX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268693AbUIMSiX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 14:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268834AbUIMSiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 14:38:23 -0400
Received: from pauli.thundrix.ch ([213.239.201.101]:9934 "EHLO
	pauli.thundrix.ch") by vger.kernel.org with ESMTP id S268693AbUIMSiV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 14:38:21 -0400
Date: Mon, 13 Sep 2004 20:31:26 +0200
From: Tonnerre <tonnerre@thundrix.ch>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Add sparse "__iomem" infrastructure to check PCI address usage
Message-ID: <20040913183126.GA19399@thundrix.ch>
References: <200409110726.i8B7QTGn009468@hera.kernel.org> <4144E93E.5030404@pobox.com> <Pine.LNX.4.58.0409121922450.13491@ppc970.osdl.org> <414508F6.7020301@pobox.com> <Pine.LNX.4.58.0409121945500.13491@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0409121945500.13491@ppc970.osdl.org>
X-GPG-KeyID: 0x8BE1C38D
X-GPG-Fingerprint: 1AB0 9AD6 D0C8 B9D5 C5C9  9C2A FF86 CBEE 8BE1 C38D
X-GPG-KeyURL: http://users.thundrix.ch/~tonnerre/tonnerre.asc
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Salut,

On Sun, Sep 12, 2004 at 08:00:48PM -0700, Linus Torvalds wrote:
> Generally, you shouldn't ever use __force in a driver or anything like=20
> that.

Why don't we send the __force attribute into some #ifdef that is never
defined unless  you're in  arch specific code?  This way  we'd prevent
stupid people from doing stupid things.

				Tonnerre

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.2 (GNU/Linux)

iD8DBQFBRed9/4bL7ovhw40RAnC1AKCrQkwNCDtAkG34ObWY0dU8cHndJQCfejna
3vxucUY6dQGPC1WVR2SE5aU=
=afAT
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
