Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261165AbVFZL51@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261165AbVFZL51 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 07:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261172AbVFZL51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 07:57:27 -0400
Received: from mxout01.versatel.de ([212.7.152.115]:57475 "EHLO
	mxout01.versatel.de") by vger.kernel.org with ESMTP id S261165AbVFZL5U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 07:57:20 -0400
Message-ID: <42BE98C5.1070102@web.de>
Date: Sun, 26 Jun 2005 14:00:05 +0200
From: Christian Trefzer <ctrefzer@web.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050617)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: "Darryl L. Miles" <darryl@netbauds.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12 initrd module loading seems parallel on bootup
References: <42BDFEC2.3030004@netbauds.net> <20050625234611.118b391d.akpm@osdl.org> <42BE7E38.9070703@netbauds.net>
In-Reply-To: <42BE7E38.9070703@netbauds.net>
X-Enigmail-Version: 0.92.0.0
OpenPGP: id=6B99E3A5
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigCBFE0D91D2FF3BC60A4B13E2"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCBFE0D91D2FF3BC60A4B13E2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Darryl L. Miles schrieb:
> Andrew Morton wrote:

[snip]

> Found the thread:   
> http://www.ussg.iu.edu/hypermail/linux/kernel/0506.0/1556.html
> 
> 
> This works for me:
> 

[snip]

Thanks, but still no go, as I am using Gentoo and a totally bloated 
self-grown glibc initramfs environment. Whenever I boot 2.6.11.12, there 
is no problem whatsoever about modprobe returning before device nodes 
are created. Any ideas? I changed udev versions back and forth between 
058 and 056, did not make any difference either...

I can send any information of interest later tonight, but have to run 
for now. Thanks in advance!

--------------enigCBFE0D91D2FF3BC60A4B13E2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQr6YxV2m8MprmeOlAQLUlw//cnpTh/uVTJ+EvWmJfvSzM9y8Pa3W7PW6
p83Zu5weveKsQHXGTQhnMWxUvem9q8PCQH3OtDNkUtcYKwxB73U3QTBcTpUBO5Tl
LPuaTiv2xCmCzdFcp/CLpiK/vg+ub2t8rs2Gj1g/J9mEdpxQxgNTXP6A1+d4VEFW
mRGLMCgez8zOraRTJBv1X3NmrtA3AToCJa2cJrGNSZIbyCqvkxboZBuutkPn33R6
i0JuvEqKdsybV/8FLAnuoms0OLh8unGiJGWa4DCCLPHbo67mmF4XM/Yphd9Ni2jB
tBLOUSoMLBHZkFYHh/hYuNyV37yDN+QzHawYphFYmEUMDNyZ5xUzZWDqMYe3Blb5
3uSbbeLk8uNI74Nrh+RW7lME0gLba3Vt1v9vitQYWEIc6JwNhUDkGvxm5ivT4Tij
hfs/KuxpGpkiEv20+8clHwVH+9VGC4I6Lu8fvm2d4AluNWZY8+oFx/wEhZULr6WN
U0rGJjKfFtpTRrEsh8gUdYV0UY/DvfGWmuVP0uVgVT3pjGwrH4UdMB/Y89QZZGSp
ScVGnCAyXY5MgtbFcwTXPklwWgRiHyScprHEsBlLIco1gu8K1dxGWuS0xGh2tT9l
NwQrODD3Lbw9nPoYU7qw1mzfI97Kyl01jHqUygBhFBkaP2a5O9i7m6X2aBs+N8nB
fdiXkE8PHfM=
=VEet
-----END PGP SIGNATURE-----

--------------enigCBFE0D91D2FF3BC60A4B13E2--
