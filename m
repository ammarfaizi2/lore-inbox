Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262069AbVAERTL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262069AbVAERTL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 12:19:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261943AbVAERTK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 12:19:10 -0500
Received: from pop.gmx.de ([213.165.64.20]:27056 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262069AbVAERQ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 12:16:59 -0500
X-Authenticated: #4512188
Message-ID: <41DC2113.8080604@gmx.de>
Date: Wed, 05 Jan 2005 18:17:07 +0100
From: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050103)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Martin Drab <drab@kepler.fjfi.cvut.cz>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: APIC/LAPIC hanging problems on nForce2 system.
References: <Pine.LNX.4.60.0501051604200.24191@kepler.fjfi.cvut.cz> <41DC1AD7.7000705@gmx.de> <Pine.LNX.4.60.0501051757300.25946@kepler.fjfi.cvut.cz>
In-Reply-To: <Pine.LNX.4.60.0501051757300.25946@kepler.fjfi.cvut.cz>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigEE7C44FD8C0F9DB0500E6983"
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEE7C44FD8C0F9DB0500E6983
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Martin Drab schrieb:
>
> On Wed, 5 Jan 2005, Prakash K. Cheemplavam wrote:
>
>
>>Martin Drab schrieb:
>>
>>>Hi,
>>>
>>>I'm witnessing a total freeze on my system when the APIC and LAPIC are
>>>enabled in kernel 2.6.10-bk7.
>>
>>Do you know whether your bios already contains the C1 halt disconnect
>>fix? I couldn't find this line in your dmesg:
>
>
> Aha! That might be the problem. Because there is still the factory BIOS,
> which is F11. I'll try the current F20 when I get home and I'll let you
> know.
>
>
>>PCI: nForce2 C1 Halt Disconnect fixup
>
>
> OK, I'll check it out.

Just to avoid confusion: If your bios does *not contain the fix, the
kernel should fix it and above line should appear. (It does here with
2.6.10) So if it doesn't in your case (and your bios does not contain
that fix), the detection code probably isn't enough. -> This should be
fixed in kernel.

When you use a fixed bios though, above line should not appear, and your
system should be stable.

Prakash

--------------enigEE7C44FD8C0F9DB0500E6983
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFB3CETxU2n/+9+t5gRAo2OAKCfH+SRYwkRGae/221qCAFe6wxDJgCg1Rxu
MzkYtCtEa2uXYNIpK5OejCo=
=zRGe
-----END PGP SIGNATURE-----

--------------enigEE7C44FD8C0F9DB0500E6983--
