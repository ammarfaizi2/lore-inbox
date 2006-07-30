Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932305AbWG3M5j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932305AbWG3M5j (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 08:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932306AbWG3M5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 08:57:39 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:40391 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id S932305AbWG3M5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 08:57:39 -0400
Message-ID: <44CCACB3.8050403@t-online.de>
Date: Sun, 30 Jul 2006 14:57:23 +0200
From: Harald Dunkel <harald.dunkel@t-online.de>
User-Agent: Thunderbird 1.5.0.4 (X11/20060714)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18-rc2, problem to wake up spinned down drive?
References: <44CC9F7E.8040807@t-online.de> <20060730122203.GA13169@leiferikson.dystopia.lan>
In-Reply-To: <20060730122203.GA13169@leiferikson.dystopia.lan>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA3563ADC3E4CED5884B41F2F"
X-ID: X7-tAyZQ8eJAao93+tsYunQTzd6PxVEbkN9fkzBzY4XdrdFq3qJc6E
X-TOI-MSGID: f0655fed-3dbb-4fce-838c-1e52c6d2d499
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA3563ADC3E4CED5884B41F2F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Hannes,

Johannes Weiner wrote:
> Hi,
>=20
> On Sun, Jul 30, 2006 at 02:01:02PM +0200, Harald Dunkel wrote:
>> Hi folks,
>>
>> I tried to spin down my harddisk using hdparm, but when it is
>> supposed to spin up again, [...]
>=20
> When is the point reached to spin up again?
>=20

When some process tries to access a file that is not
cached in RAM, AFAICT. All partitions are mounted with
noatime.

>> On another machine (with a SAMSUNG SP2504C inside) there is no
>> such problem: The disk is back after just a few seconds.
>=20
> Same kernel?
>=20

Yes. But both machines are very different. The working
machine is an amd64 with nforce2. The machine that gets
stuck is a 2 GHz Pentium M with some Intel chipset:

00:1f.2 IDE interface: Intel Corporation 82801FB/FW (ICH6/ICH6W) SATA Con=
troller (rev 04)
00:1f.2 0101: 8086:2651 (rev 04)

Sorry, surely I should have mentioned this before. The
problem isn't _that_ reproducible.


Regards

Harri



--------------enigA3563ADC3E4CED5884B41F2F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEzKyzUTlbRTxpHjcRAso+AJ9mK1Vmu+YGm/NQ1+syWWirRQ0v6gCgkFCV
OeCnMTL/lhgGjOyWwxguZ5U=
=wX1F
-----END PGP SIGNATURE-----

--------------enigA3563ADC3E4CED5884B41F2F--
