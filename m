Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751480AbWHETdI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751480AbWHETdI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 15:33:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751481AbWHETdI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 15:33:08 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:34513 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1751480AbWHETdF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 15:33:05 -0400
Message-ID: <44D4F25F.50902@t-online.de>
Date: Sat, 05 Aug 2006 21:32:47 +0200
From: Harald Dunkel <harald.dunkel@t-online.de>
User-Agent: Thunderbird 1.5.0.4 (X11/20060714)
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18-rc2, problem to wake up spinned down drive?
References: <44CC9F7E.8040807@t-online.de> <44CF7E5A.2010903@gmail.com> <44CF9A23.9090409@t-online.de> <44CF9C0A.8090405@gmail.com>
In-Reply-To: <44CF9C0A.8090405@gmail.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig7AE1FF9AA89F8C3B229C69A0"
X-ID: SxWWxGZXreG+Cs74kctISXoJ-3aia8UYxQkDIn7fgnZ-QX0m8sO2gD
X-TOI-MSGID: 5b763eca-52ef-4775-ae34-872e6eab430d
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7AE1FF9AA89F8C3B229C69A0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Tejun Heo wrote:
> Harald Dunkel wrote:
>>
>> Sorry to say, but this did not work:
>>
>> # echo 1 > /sys/bus/scsi/devices/0:0:0:0/power/state
>> bash: echo: write error: Invalid argument
>=20
> You probably should do 'echo -n 1', the parsing function is pretty pick=
y.
>=20

# echo -n 1 > /sys/bus/scsi/devices/0:0:0:0/power/state
bash: echo: write error: Invalid argument

???


Regards

Harri



--------------enig7AE1FF9AA89F8C3B229C69A0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE1PJkUTlbRTxpHjcRAgLxAJkB3lB7QoK0HWLkKKLF9FAKBpQDJACeIGVU
0VLmq06ihJq8Etk9QeJwAew=
=PZ9t
-----END PGP SIGNATURE-----

--------------enig7AE1FF9AA89F8C3B229C69A0--
