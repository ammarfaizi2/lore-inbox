Return-Path: <linux-kernel-owner+w=401wt.eu-S1030253AbXAKKYb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030253AbXAKKYb (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 05:24:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030255AbXAKKYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 05:24:31 -0500
Received: from mail.phnxsoft.com ([195.227.45.4]:4548 "EHLO
	posthamster.phnxsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030253AbXAKKYa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 05:24:30 -0500
Message-ID: <45A6104F.4090207@imap.cc>
Date: Thu, 11 Jan 2007 11:24:15 +0100
From: Tilman Schmidt <tilman@imap.cc>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de-AT; rv:1.8.0.9) Gecko/20061211 SeaMonkey/1.0.7 Mnenhy/0.7.4.666
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: Linux Kernel mailing List <linux-kernel@vger.kernel.org>
Subject: Re: installing only the newly (re)built modules
References: <7c737f300701082029i1ce9f7d8oc67cb3339c9c2856@mail.gmail.com> <45A5609C.1000308@tmr.com>
In-Reply-To: <45A5609C.1000308@tmr.com>
X-Enigmail-Version: 0.94.1.2
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA3A27E90DB2C91899D196A5A"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA3A27E90DB2C91899D196A5A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Bill Davidsen schrieb:
> Alexy Khrabrov wrote:
>> The 2.6 build system compiles only those modules whose config
>> changed.  However, the install still installs all modules.
>>=20
>> Is there a way to entice make modules_install to install only those
>> new modules we've actually just changed/built?
>=20
> Out of curiosity, why? I've noticed this, but the copy runs so fast I=20
> never really thought about it as an issue.

Not here. On the 933 MHz P3 machine I use for driver development,
"make modules_install" takes so much time that I always copy my
modules by hand instead after recompiling them.

--=20
Tilman Schmidt                    E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Unge=F6ffnet mindestens haltbar bis: (siehe R=FCckseite)


--------------enigA3A27E90DB2C91899D196A5A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFphBXMdB4Whm86/kRAi4xAJwLOxHPKQT7WfpT1jjZp17SP8WDlACfRLmA
u5Qd0bixZHu56qCn2nFnOBA=
=S/Ug
-----END PGP SIGNATURE-----

--------------enigA3A27E90DB2C91899D196A5A--
