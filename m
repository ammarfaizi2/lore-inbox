Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbUCaLun (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 06:50:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261918AbUCaLum
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 06:50:42 -0500
Received: from relay.inway.cz ([212.24.128.3]:62188 "EHLO relay.inway.cz")
	by vger.kernel.org with ESMTP id S261914AbUCaLuk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 06:50:40 -0500
Message-ID: <406AB08C.1040907@scssoft.com>
Date: Wed, 31 Mar 2004 13:50:36 +0200
From: Petr Sebor <petr@scssoft.com>
Organization: SCS Software
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, jpaana@s2.org
Subject: Re: [PATCH] Re: [sata] libata update
References: <4064E691.2070009@pobox.com> <4069FBC3.2080104@scssoft.com> <406A8035.2080108@pobox.com>
In-Reply-To: <406A8035.2080108@pobox.com>
X-Enigmail-Version: 0.83.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigAAB711732AE2CFB62AC6B976"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAAB711732AE2CFB62AC6B976
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jeff Garzik wrote:

> Here's a potentially better patch, if you guys (or anyone else) would 
> be willing to give it a quick test...?
>
>     Jeff

Not good at all ...

(eye-copied from the console @ boot time)

2.6.5-rc3 + this patch:

sata_via (0000:00:0f.0): PATA sharing not supported (0x2)
via_sata: probe of (0000:00:0f.0) failed with error -5

with following panic

unable to mount root...

wrt sata_via, no more messages are written...

Regards,
Petr


--------------enigAAB711732AE2CFB62AC6B976
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAarCMir6eWjmOQ6cRAg8UAJwKHRGQB31xajYnUcuHLNxpl9mVdQCfW9DH
YUlulIEQRv9EFbGsHLVDsKw=
=x/kb
-----END PGP SIGNATURE-----

--------------enigAAB711732AE2CFB62AC6B976--
