Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965113AbWHQPDh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965113AbWHQPDh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 11:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965111AbWHQPDh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 11:03:37 -0400
Received: from natgw.netstream.ch ([62.65.128.28]:17117 "HELO
	hydrogenium.schottelius.org") by vger.kernel.org with SMTP
	id S965116AbWHQPDg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 11:03:36 -0400
Date: Thu, 17 Aug 2006 17:01:45 +0200
From: Nico Schottelius <nico-kernel20060817@schottelius.org>
To: Bart Hartgers <bart@etpmod.phys.tue.nl>
Cc: Nico Schottelius <nico-kernel20060817@schottelius.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Memory bank detection available?
Message-ID: <20060817150145.GG4559@schottelius.org>
Mail-Followup-To: Nico Schottelius <nico-kernel20060817@schottelius.org>,
	Bart Hartgers <bart@etpmod.phys.tue.nl>,
	LKML <linux-kernel@vger.kernel.org>
References: <20060817144039.GD19497@schottelius.org> <44E48224.7050300@etpmod.phys.tue.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bFsKbPszpzYNtEU6"
Content-Disposition: inline
In-Reply-To: <44E48224.7050300@etpmod.phys.tue.nl>
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.17.6-hydrogenium
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bFsKbPszpzYNtEU6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Bart Hartgers [Thu, Aug 17, 2006 at 04:50:12PM +0200]:
> Nico Schottelius wrote:
> > Hello!
> >=20
> > Is it possible to detect, which memory banks on the mainboard are in us=
e under
> > Linux/x86?
> >=20
>=20
> dmidecode might do the trick, depending on your BIOS.

Thanks a lot, dmidecode -t memory did the trick!

Nico

--=20
``...if there's one thing about Linux users, they're do-ers, not whiners.''
(A quotation of Andy Patrizio I completely agree with)

--bFsKbPszpzYNtEU6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iQIVAwUBROSE17OTBMvCUbrlAQKhJA//e4bBwH7rtRGI66WVxNtzsaL/McuXOKwz
/YNLIxNJqfd3M29BGVEIjLLZWbYCsDAOEDVh4af4lLlpnEYyQ5olRXfLiojiHTzl
h3VIcvsXoA95BINdELnTMIJOw9FdSqxMbAu3pGfW7jmoAkd7/AR4NEC10f/d8Qgv
WWp9XokCR/BTV/xvF2bWOGgx5WyoLY5bX6RPdHKDcJTlIIMtfbYKmLHl92Xz0nfK
zk2gJ1m/1gLd9HlktJGoWkkJtIFZapLs5Rj+KXcVDZd5Ss7T6y1d4sx/F+BhjHX8
tAYZVJy1YzoDg2/PxAqsSY1aE18KYv7flpyc8ysr5OuRFKIzmEObDDsaWan3v33S
ix3ageyNLNjZv2jZV5YiOg8Hirmp2+3cy18P4SpmkyzRjd2w6Ou9hEynuBwlbqu7
a+d+rPVBH5djEhuzt0xvyJJLgWnnKjo56b+qHdJGDrJIwwr7VGc1JoP0tZ/zfqR+
EovrbkEuhg8o0kNz8SCefmS4HWPdpyVAM8cdr+owpvt8xQ2tePbPE6QfMz7Ut5QN
/JeXqOEL7MWjU1lFtMJ1rENiiM4lsfevqUH1/FVJR47VLLFePMtgBvEr8JBmF/aw
JMwNOuVQApuOE1hv01hvhYFvcJz0U7BjLaanTGkFul7qTZan8HCx4qVA6ZTPCrYB
AWRs3T+IueQ=
=SM9+
-----END PGP SIGNATURE-----

--bFsKbPszpzYNtEU6--
