Return-Path: <linux-kernel-owner+w=401wt.eu-S1751545AbXAHPUG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751545AbXAHPUG (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 10:20:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751573AbXAHPUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 10:20:06 -0500
Received: from posthamster.phnxsoft.com ([195.227.45.4]:2931 "EHLO
	posthamster.phnxsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751584AbXAHPUF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 10:20:05 -0500
Message-ID: <45A2611A.7040900@imap.cc>
Date: Mon, 08 Jan 2007 16:19:54 +0100
From: Tilman Schmidt <tilman@imap.cc>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de-AT; rv:1.8.0.7) Gecko/20060910 SeaMonkey/1.0.5 Mnenhy/0.7.4.666
MIME-Version: 1.0
To: Jonas Svensson <jonass@lysator.liu.se>
CC: linux-kernel@vger.kernel.org
Subject: Re: trouble loading self compiled vanilla kernel
References: <Pine.GSO.4.51L2.0701081054010.27141@nema.lysator.liu.se> <45A228CC.5020004@imap.cc> <Pine.GSO.4.51L2.0701081301520.27141@nema.lysator.liu.se>
In-Reply-To: <Pine.GSO.4.51L2.0701081301520.27141@nema.lysator.liu.se>
X-Enigmail-Version: 0.94.1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB99B914809058613EFBE5BD6"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB99B914809058613EFBE5BD6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jonas Svensson schrieb:
> On Mon, 8 Jan 2007, Tilman Schmidt wrote:
>=20
>> Jonas Svensson schrieb:
>> [...]
>> > All results in the same problem: the booting stops about when grub i=
s
>> > finished and the kernel should continue. I get the
>> > message about loading initrd but not the line of "Uncompressing
>> > Linux... Ok, booting the kernel". Instead I get a blank screen with =
a
>> > flashing cursor at top left. Thats all, nothing more happens. Any
>> > suggestions on what could be wrong or what I should do?
>>
>> Did you build a new initrd to go with your new kernel?
>=20
> I beleive make install does that in CentOS. There were a new initrd
> installed and it was not identical to the one supplied by CentOS.

That's surprising. On SuSE I always have to build it separately
with mkinitrd, and the kernel makefiles are the same, after all.
Anyway, your symptoms definitely look like a bad initrd, so you
may want to have a closer look in that area. Perhaps build a
kernel you can boot without initrd for testing, ie. with the
drivers for the root disk and filesystem built in.

HTH
Tilman

--=20
Tilman Schmidt                    E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Unge=F6ffnet mindestens haltbar bis: (siehe R=FCckseite)


--------------enigB99B914809058613EFBE5BD6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFomEhMdB4Whm86/kRAtjNAJ9IDZoeMitkVs9COK/9h0pUo0n9xgCfU7oE
OfRYHLXVGlE4LvAM4QJUDyM=
=BT1r
-----END PGP SIGNATURE-----

--------------enigB99B914809058613EFBE5BD6--
