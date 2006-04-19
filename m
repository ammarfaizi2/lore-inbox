Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750836AbWDSPCJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750836AbWDSPCJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 11:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750838AbWDSPCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 11:02:09 -0400
Received: from mx.poczta.fm ([80.48.65.10]:17544 "EHLO smtp.poczta.interia.pl")
	by vger.kernel.org with ESMTP id S1750836AbWDSPCI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 11:02:08 -0400
Message-ID: <444650E1.5020403@poczta.fm>
Date: Wed, 19 Apr 2006 17:01:53 +0200
From: Lukasz Stelmach <stlman@poczta.fm>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: =?UTF-8?B?xYF1a2FzeiBTdGVsbWFjaA==?= <stlman@poczta.fm>
Subject: quantum capabilities
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig088D6D6AF1CBD80F8F27D41B"
X-EMID: ce7f1138
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig088D6D6AF1CBD80F8F27D41B
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Greetings All.

I've found a strange phenomenon associated with capabilities. It seems to=
 be a
quantum like.

when I run (as root)

delfin:~# /usr/sbin/execcap '=3D cap_net_raw=3Dep' /bin/sh -c 'getpcaps $=
$'
Capabilities for `2438': =3Dep cap_setpcap-ep

I don't know what really happens to those capablities I zero. And I can't=
 really
figure out for when I try the wavefunction collapses

delfin:~# strace -o /dev/null /usr/sbin/execcap '=3D cap_net_raw=3Dep' /b=
in/sh -c \
'getpcaps $$'
Capabilities for `2461': =3D cap_net_raw+ep

Strange isn't it? Does it mean that processes can't really drop their pri=
vileges?

please CC.
--=20
By=C5=82o mi bardzo mi=C5=82o.                    Czwarta pospolita kl=C4=
=99ska, [...]
>=C5=81ukasz<                      Ju=C5=BC nie katolicka lecz z=C5=82odz=
iejska.  (c)PP


--------------enig088D6D6AF1CBD80F8F27D41B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFERlDmNdzY8sm9K9wRAsJcAJ4jdKJJeoMl6Kp3aKum+5chvceG3QCggDj9
/z9TJF1ADcUaKUh+0FFIvvI=
=732D
-----END PGP SIGNATURE-----

--------------enig088D6D6AF1CBD80F8F27D41B--
