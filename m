Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932203AbWG2SZ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203AbWG2SZ2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 14:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbWG2SZ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 14:25:28 -0400
Received: from 63-162-81-179.lisco.net ([63.162.81.179]:47069 "EHLO
	grunt.slaphack.com") by vger.kernel.org with ESMTP id S932203AbWG2SZ1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 14:25:27 -0400
Message-ID: <44CBA814.7000906@slaphack.com>
Date: Sat, 29 Jul 2006 13:25:24 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060708)
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
CC: Linus Torvalds <torvalds@osdl.org>,
       "Horst H. von Brand" <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
       Theodore Tso <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: metadata plugins (was Re: the " 'official' point of view" expressed
 by kernelnewbies.org regarding reiser4 inclusion)
References: <200607281402.k6SE245v004715@laptop13.inf.utfsm.cl> <44CA31D2.70203@slaphack.com> <Pine.LNX.4.64.0607280859380.4168@g5.osdl.org> <44C9FB93.9040201@namesys.com> <44CA6905.4050002@slaphack.com> <44CA126C.7050403@namesys.com> <44CA8771.1040708@slaphack.com> <44CABB87.3050509@namesys.com>
In-Reply-To: <44CABB87.3050509@namesys.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="------------enig87CFB6CF2548B78C9CC21640"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig87CFB6CF2548B78C9CC21640
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hans Reiser wrote:
> David Masover wrote:
>=20
>> If indeed it can be changed easily at all.  I think the burden is on
>> you to prove that you can change it to be more generic, rather than
>> saying "Well, we could do it later, if people want us to..."
>=20
> None of the filesystems other than reiser4 have any interest in using
> plugins, and this whole argument over how it should be in VFS is
> nonsensical because nobody but us has any interest in using the
> functionality.  The burden is on the generic code authors to prove that=

> they will ever ever do anything at all besides complain.  Frankly, I
> don't think they will.  I think they will never produce one line of cod=
e.

I think it's fair to say that 5-10 years from now, with different ext3
maintainers, when the Reiser4 concept has proven itself, people will
want plugins for ext3, and the ext3 developers will like the idea.

ext* is one of those things that just refuses to die.  I use ext3 for my
/boot fs, so that I don't have to patch Grub for Reiser4, and so that at
least I can mess with the bootloader from any rescue CD if something
goes wrong.  It's for kind of the same reason that Gentoo builds a
32-bit Grub, even though I'm booting a 64-bit OS -- just in case.

I also use ext2 for my initrd.

There are other monstrosities that will likely never die, also.
ISO9660, UDF, and VFAT probably all have worse storage characteristics
than Reiser4, in that as I understand it, they won't pack multiple files
into a block.  So Reiser4 might even make a good boot cd FS, storing
things more efficiently -- but even if I'm right, those three
filesystems will last forever, because they are currently well supported
on every major OS, and I think one of ISO/UDF is required for DVDs.

So for whatever reason someone's using another filesystem, even if all
they need is the on-disk format (my reason for ext3 /boot and vfat on
USB thumbdrives), I think it's reasonable to expect that they may one
day want plugin functionality.  People who like Reiser filesystems will
do just fine running Reiser4 with a (udf|iso|vfat) storage driver, but
people who don't will just want the higher level stuff.

You're probably right and this is years of work for something that may
not be worth anything, but I think this is what is going through
people's heads as they look at this plugin system.

So see my comments about distro inclusion.


--------------enig87CFB6CF2548B78C9CC21640
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRMuoFHgHNmZLgCUhAQpqZA//RXqhw8qAmmIr5vZNt3jVXjHMf/gz+ryp
EQCSOgAMiNRCrrXucu/B/0+2ymJ/3zyyHgFEsEZ6SuWupkTeIKEpFnV62B7aGuvA
mZMN7owThyRIfpYI06y3gc0DQfaFWiKaQAOUjxUiju05wrecAaSmx1nfOHiguWtJ
/rf+w9DaM9MdtsOjBWKqC5uxZZZY6A2csLsx781MSsqgIrvu/r5+M2BnuYMFnhgG
cnKQm19kELfwEXVjOs1QbjF8eiYtHhYyqnMxYEBHCP9z0jH0Nlp+v7RBjetQ0Lxj
5Ijnt+vuXgMh6fLdhJrEONAxfQf8l3/SbI5azpxufxFymQBcOcVw4eLDbKYJx2Vr
PiTsBA8LuDb0+jCHEVH5qH8hrRn/xO+7ZTz91/SAJht42Y6I/ObwXRXlzqJdn/Mu
Zs2JiMVfTtBR5irJ5tOgs8TQQwWfxYNVsY9dGDzNKxvf8qV+f/3cYBVJG2L9wXj9
quRwkY95El0vDV5lKg2e867mW33ZTq3frWsycdljFtycNsRYxA/TjOBp6fivJVqn
4Yr2X/CON1o6MsKmgccGSCLi0xPLSW45GfjtIBPQfC5otMxLkrVjBSsMKBPGOvTV
PNRsNQYTOUgIUhGzA8/TXWJavrSRf4qukkExuTXlfpLzaAbAfakhGPOOx0DhsZ4Y
woFH+EDDTaU=
=+8SP
-----END PGP SIGNATURE-----

--------------enig87CFB6CF2548B78C9CC21640--
