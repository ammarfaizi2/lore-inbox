Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261355AbVAAO6e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261355AbVAAO6e (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jan 2005 09:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbVAAO6e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jan 2005 09:58:34 -0500
Received: from mailer2-5.key-systems.net ([81.3.43.243]:47513 "HELO
	mailer2-1.key-systems.net") by vger.kernel.org with SMTP
	id S261355AbVAAO6b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jan 2005 09:58:31 -0500
Message-ID: <41D692E9.4060805@mathematica.scientia.net>
Date: Sat, 01 Jan 2005 13:09:13 +0100
From: Christoph Anton Mitterer <cam@mathematica.scientia.net>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: problem with kernel bootparameters when using UDF fs support together
 with XFS quotas
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC6B654261295BDD2C2710F59"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC6B654261295BDD2C2710F59
Content-Type: multipart/mixed;
 boundary="------------010404080900050002090902"

This is a multi-part message in MIME format.
--------------010404080900050002090902
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi.

I'm using UDF filesystem support (CONFIG_UDF_FS) and quota support for
XFS (CONFIG_XFS_QUOTA) in my kernel.
Because I have to enable quota-controll on the root partition I append
"rootflags=usrquota" to my kernel boot parameters.
The XFS quota works fine now but it seems that the UDF driver has also
an option called "rootflags":
"udf: bad mount option "usrquota" or missing value"

Is there any way to avoid this?

Thanks in advance.

Greetings,
cam.


--------------010404080900050002090902
Content-Type: text/x-vcard; charset=utf-8;
 name="cam.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="cam.vcf"

YmVnaW46dmNhcmQNCmZuOk1pdHRlcmVyLCBDaHJpc3RvcGggQW50b24NCm46TWl0dGVyZXI7
Q2hyaXN0b3BoIEFudG9uDQpvcmc6TXVuaWNoIFVuaXZlcnNpdHkgb2YgQXBwbGllZCBTY2ll
bmNlcztEZXBhcnRtZW50IG9mIE1hdGhlbWF0aWNzIGFuZCBDb21wdXRlciBTY2llbmNlDQph
ZHI7cXVvdGVkLXByaW50YWJsZTtxdW90ZWQtcHJpbnRhYmxlOjs7TG90aHN0cmE9QzM9OUZl
IDM0O009QzM9QkNuY2hlbjtGcmVpc3RhYXQgQmF5ZXJuOzgwMzM1O0ZlZGVyYWwgUmVwdWJs
aWMgb2YgR2VybWFueQ0KZW1haWw7aW50ZXJuZXQ6Y2FtQG1hdGhlbWF0aWNhLnNjaWVudGlh
Lm5ldA0KdGVsO2hvbWU6KzQ5IDg5IDI0NDA5MzkwDQp0ZWw7Y2VsbDorNDkgMTcyIDg2MTcz
NDENCngtbW96aWxsYS1odG1sOlRSVUUNCnVybDpodHRwOi8vZmhtLmVkdS8NCnZlcnNpb246
Mi4xDQplbmQ6dmNhcmQNCg0K
--------------010404080900050002090902--

--------------enigC6B654261295BDD2C2710F59
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB1pLsmstaume4L0MRAuDXAJsHM+lwa9rhWecy2hs23rbbCKajDQCfSJe+
otpXQauZ1jnnaAM1IKS8B0s=
=ZQ8B
-----END PGP SIGNATURE-----

--------------enigC6B654261295BDD2C2710F59--

