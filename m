Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129675AbRALD1j>; Thu, 11 Jan 2001 22:27:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129742AbRALD13>; Thu, 11 Jan 2001 22:27:29 -0500
Received: from vitelus.com ([64.81.36.147]:61960 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id <S129675AbRALD1T>;
	Thu, 11 Jan 2001 22:27:19 -0500
Date: Thu, 11 Jan 2001 19:27:08 -0800
From: Aaron Lehmann <aaronl@vitelus.com>
To: junio@siamese.dhis.twinsun.com
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Floating point broken between 2.4.0-ac4 and -ac5?
Message-ID: <20010111192708.G32480@vitelus.com>
In-Reply-To: <7vvgrmwuqv.fsf@siamese.dhis.twinsun.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qz2CZ664xQdCRdPu"
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <7vvgrmwuqv.fsf@siamese.dhis.twinsun.com>; from junio@siamese.dhis.twinsun.com on Wed, Jan 10, 2001 at 08:58:00PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Qz2CZ664xQdCRdPu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 10, 2001 at 08:58:00PM -0800, junio@siamese.dhis.twinsun.com wrote:
> A Duron box running 2.4.0-ac5 (and -ac6) shows NaN in many
> places (such as df output showing usage "nan%").  Right now I
> reverted back to 2.4.0-ac4 which does not show the problem.
> The kernel was compiled with CONFIG_MK7 and without
> MATH_EMULATION, if that makes any difference.

I just had exactly the same problem with ac6 and an Athlon. Many
floating point numbers were replaced with nan. XFree86 broke.

--Qz2CZ664xQdCRdPu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6XnmMdtqQf66JWJkRApOGAKDK9KAc/ZD/IEozpkgPztC/8H23SgCg7pWL
h6kfJ8BF3zdcVTM3iOiWsM8=
=8mjv
-----END PGP SIGNATURE-----

--Qz2CZ664xQdCRdPu--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
