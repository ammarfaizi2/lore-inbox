Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750857AbVJMKoj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857AbVJMKoj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 06:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750861AbVJMKoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 06:44:39 -0400
Received: from alsikeapila.uta.fi ([153.1.1.44]:19334 "EHLO alsikeapila.uta.fi")
	by vger.kernel.org with ESMTP id S1750841AbVJMKoj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 06:44:39 -0400
Message-ID: <434E3A86.4030509@uta.fi>
Date: Thu, 13 Oct 2005 13:44:22 +0300
From: Pauli Borodulin <pauli.borodulin@uta.fi>
Organization: University of Tampere
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christiaan den Besten <chris@scorpion.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: Machine dies under heavy I/O or network-access ..?
References: <049f01c5b215$91e7c4b0$3d64880a@speedy>
In-Reply-To: <049f01c5b215$91e7c4b0$3d64880a@speedy>
X-Enigmail-Version: 0.92.0.0
OpenPGP: url=http://www.uta.fi/~pauli.borodulin/boro.public.asc
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig03A40CFA4802D5627E3D9798"
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-2.0.1 (apila.uta.fi [153.1.1.41]); Thu, 13 Oct 2005 13:44:31 +0300 (EEST)
X-Spam-Report: ALL_TRUSTED,BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig03A40CFA4802D5627E3D9798
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Christiaan den Besten wrote:
> [...]
> Today I noticed the following assertion in dmesg:
> ---
> e1000: eth0: e1000_watchdog_task: NIC Link is Up 1000 Mbps Full Duplex
> KERNEL: assertion (!sk->sk_forward_alloc) failed at net/core/stream.c (279)
> KERNEL: assertion (!sk->sk_forward_alloc) failed at net/ipv4/af_inet.c
> (148)
> ---
> [...]

I upgraded ten of our servers to 2.6.13.3 on tuesday and noticed today
that the following assertations were in one server's dmesg:

KERNEL: assertion (!sk->sk_forward_alloc) failed at net/core/stream.c (279)
KERNEL: assertion (!sk->sk_forward_alloc) failed at net/ipv4/af_inet.c (151)

This server has e1000 NIC just like most of the servers I upgraded. The
difference in our situation is that the server which logged the
assertions is still running fine. Previous kernel version on the servers
was 2.6.12.2 and it was used over 90 days without any problems.


Br,
-- 
Pauli Borodulin <pauli.borodulin@uta.fi>
Systems Analyst, tel. +358 3 3551 7892
Computer Centre / Room B4179
University of Tampere, Finland

--------------enig03A40CFA4802D5627E3D9798
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDTjqJ7oDm4BakJTURAtoFAJ0eC43buBcN5lO1fEfdUKa4x/uY+wCfRgYy
pnP6Z18Ye5CVPOHYAHQNpa0=
=xEI8
-----END PGP SIGNATURE-----

--------------enig03A40CFA4802D5627E3D9798--
