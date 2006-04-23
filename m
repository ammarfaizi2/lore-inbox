Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751048AbWDWJl1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751048AbWDWJl1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 05:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbWDWJl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 05:41:27 -0400
Received: from [80.48.65.9] ([80.48.65.9]:39804 "EHLO smtp.poczta.interia.pl")
	by vger.kernel.org with ESMTP id S1751048AbWDWJl1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 05:41:27 -0400
Message-ID: <444B4BBE.4090009@poczta.fm>
Date: Sun, 23 Apr 2006 11:41:18 +0200
From: Lukasz Stelmach <stlman@poczta.fm>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: quantum capabilities
References: <444650E1.5020403@poczta.fm> <20060420211822.GC2360@ucw.cz>
In-Reply-To: <20060420211822.GC2360@ucw.cz>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig7535FF35341A3F52C29CF321"
X-EMID: 7c91b138
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7535FF35341A3F52C29CF321
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Pavel Machek wrote:
> On Wed 19-04-06 17:01:53, Lukasz Stelmach wrote:
>> Greetings All.
>>
>> I've found a strange phenomenon associated with capabilities. It seems=
 to be a
>> quantum like.
>>
>> when I run (as root)
>>
>> delfin:~# /usr/sbin/execcap '=3D cap_net_raw=3Dep' /bin/sh -c 'getpcap=
s $$'
>> Capabilities for `2438': =3Dep cap_setpcap-ep
>>
>> I don't know what really happens to those capablities I zero. And I ca=
n't really
>> figure out for when I try the wavefunction collapses
>>
>> delfin:~# strace -o /dev/null /usr/sbin/execcap '=3D cap_net_raw=3Dep'=
 /bin/sh -c \
>> 'getpcaps $$'
>> Capabilities for `2461': =3D cap_net_raw+ep
>>
>> Strange isn't it? Does it mean that processes can't really drop their =
privileges?
>=20
> Is execcap setuid? strace does not work over setuid...

No it's not. And even if it was it sholudn't make any difference when I r=
un
execcap logged in as root.

--=20
By=C5=82o mi bardzo mi=C5=82o.                    Czwarta pospolita kl=C4=
=99ska, [...]
>=C5=81ukasz<                      Ju=C5=BC nie katolicka lecz z=C5=82odz=
iejska.  (c)PP


--------------enig7535FF35341A3F52C29CF321
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFES0u+NdzY8sm9K9wRAuwTAKCadlnSHigMPWl/OGiwxZGgBHjq7ACeJKGB
jdlt1fCpjIKvf39RmbUvygc=
=peIy
-----END PGP SIGNATURE-----

--------------enig7535FF35341A3F52C29CF321--
