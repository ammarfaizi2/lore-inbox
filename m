Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262489AbVAEQu0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262489AbVAEQu0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 11:50:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262493AbVAEQu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 11:50:26 -0500
Received: from pop.gmx.de ([213.165.64.20]:34755 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262489AbVAEQuP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 11:50:15 -0500
X-Authenticated: #4512188
Message-ID: <41DC1AD7.7000705@gmx.de>
Date: Wed, 05 Jan 2005 17:50:31 +0100
From: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050103)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Martin Drab <drab@kepler.fjfi.cvut.cz>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: APIC/LAPIC hanging problems on nForce2 system.
References: <Pine.LNX.4.60.0501051604200.24191@kepler.fjfi.cvut.cz>
In-Reply-To: <Pine.LNX.4.60.0501051604200.24191@kepler.fjfi.cvut.cz>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig1E8E68FE78320462700FBB62"
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1E8E68FE78320462700FBB62
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Martin Drab schrieb:
> Hi,
>
> I'm witnessing a total freeze on my system when the APIC and LAPIC are
> enabled in kernel 2.6.10-bk7.

Do you know whether your bios already contains the C1 halt disconnect
fix? I couldn't find this line in your dmesg:


PCI: nForce2 C1 Halt Disconnect fixup

Did it occur with earlier kernels? If yes, this is a regression.

Try as workaround if

athcool off

makes your system stable. If yes, you need above fix activated.

Cheers,

Prakash

--------------enig1E8E68FE78320462700FBB62
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFB3BrXxU2n/+9+t5gRAoJLAJ93sSkpQG4sEpdsg3z+25eKEH3CrQCfUpQt
V77IsSpKD4rhdLhm9MYBQaA=
=zdQL
-----END PGP SIGNATURE-----

--------------enig1E8E68FE78320462700FBB62--
