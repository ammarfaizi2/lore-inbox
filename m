Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266193AbUJLQTe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266193AbUJLQTe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 12:19:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266096AbUJLQTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 12:19:05 -0400
Received: from imap.gmx.net ([213.165.64.20]:26529 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266116AbUJLQPl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 12:15:41 -0400
X-Authenticated: #4512188
Message-ID: <416C0330.3060800@gmx.de>
Date: Tue, 12 Oct 2004 18:15:44 +0200
From: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040929)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: "mobil@wodkahexe.de" <mobil@wodkahexe.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc4 No local APIC present or hardware disabled
References: <20041012195448.2eaabcea.mobil@wodkahexe.de>
In-Reply-To: <20041012195448.2eaabcea.mobil@wodkahexe.de>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig870059606A322C5F8F1380FD"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig870059606A322C5F8F1380FD
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

mobil@wodkahexe.de schrieb:
> Hi,
> 
> after upgrading to 2.6.9-rc4 I'm getting the following message in dmesg:
> 
> No local APIC present or hardware disabled
> 
> 2.6.9-rc3 and older kernels did not show this message. They showed:
>  Local APIC disabled by BIOS -- reenabling.
>  Found and enabled local APIC!
> 
> Any hints ?

Use kernel parameter: lapic

It was decided the kernel should not automatically use local apic if 
bios hasn't activated it.

Prakash

--------------enig870059606A322C5F8F1380FD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.10 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBbAMwxU2n/+9+t5gRAmkrAKD782nGNNs8F4Kk1a2r0/+wmiHOeACeO8Bj
DBQSW0Lf9WEYtd0ojJvi6JE=
=fdkr
-----END PGP SIGNATURE-----

--------------enig870059606A322C5F8F1380FD--
