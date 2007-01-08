Return-Path: <linux-kernel-owner+w=401wt.eu-S932674AbXAHVEs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932674AbXAHVEs (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 16:04:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932680AbXAHVEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 16:04:47 -0500
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:34835 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932677AbXAHVEq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 16:04:46 -0500
X-Sasl-enc: NRvF+6uslb1xVb898WWuE4DsFr2FthfA8992AGohUECd 1168290077
Message-ID: <45A2B2E8.5040505@imap.cc>
Date: Mon, 08 Jan 2007 22:08:56 +0100
From: Tilman Schmidt <tilman@imap.cc>
Organization: me - organized??
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.8.0.9) Gecko/20061211 SeaMonkey/1.0.7 Mnenhy/0.7.4.666
MIME-Version: 1.0
To: Vadim Lobanov <vlobanov@speakeasy.net>
CC: Jonas Svensson <jonass@lysator.liu.se>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: trouble loading self compiled vanilla kernel
References: <Pine.GSO.4.51L2.0701081054010.27141@nema.lysator.liu.se>	 <45A228CC.5020004@imap.cc>	 <Pine.GSO.4.51L2.0701081301520.27141@nema.lysator.liu.se>	 <45A2611A.7040900@imap.cc>	 <Pine.GSO.4.51L2.0701081644110.27141@nema.lysator.liu.se> <1168278054.3330.4.camel@impinj-lt-0046>
In-Reply-To: <1168278054.3330.4.camel@impinj-lt-0046>
X-Enigmail-Version: 0.94.1.2
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig4CD9DCC468D82556A7767526"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4CD9DCC468D82556A7767526
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Am 08.01.2007 18:40 schrieb Vadim Lobanov:
> In my experience on openSUSE, the following sequence of commands
> installs both the kernel and the initrd:
> 	make *config*
> 	make
> 	make modules_install
> 	make install
> However, if the order of the last two make invocations is switched, the=
n
> the initrd does not get generated (correctly or at all).

Cool! So that explains why it never worked for me. I always ran
"make install" before "make modules_install". It just appeared
more logical.

Thanks a lot for that hint - I'll try it on the next occasion.

--=20
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Unge=F6ffnet mindestens haltbar bis: (siehe R=FCckseite)


--------------enig4CD9DCC468D82556A7767526
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3rc1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFForLvMdB4Whm86/kRAsAdAKCCf1d4P34gPvRl9RZQdXFq0paaeQCePIac
ZKtMOFFQOJoPBZseYMxdbt4=
=SxM4
-----END PGP SIGNATURE-----

--------------enig4CD9DCC468D82556A7767526--
