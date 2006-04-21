Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932300AbWDUNf3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932300AbWDUNf3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 09:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932305AbWDUNf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 09:35:29 -0400
Received: from [80.48.65.8] ([80.48.65.8]:60031 "EHLO smtp.poczta.interia.pl")
	by vger.kernel.org with ESMTP id S932304AbWDUNf2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 09:35:28 -0400
Message-ID: <4448DF94.5030500@poczta.fm>
Date: Fri, 21 Apr 2006 15:35:16 +0200
From: Lukasz Stelmach <stlman@poczta.fm>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: unix socket connection tracking
References: <44480BD9.5080100@poczta.fm> <Pine.LNX.4.61.0604211452490.23180@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0604211452490.23180@yvahk01.tjqt.qr>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig26AB05DB3919DAEA38DD672D"
X-EMID: 884e6138
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig26AB05DB3919DAEA38DD672D
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Jan Engelhardt wrote:
>> I feel dumb as never so please enlight me. Is ther a way to find out w=
hich
>> process is on the other end of a unix socket pointed by a specified fd=
 in a process.
>=20
> getpeer*()

getpeername(2) (that is the only man page I've got)

That's not exactly what I want. Or even exactly not what I want. I want t=
o learn
about sockets from a third person perspective. I've got a process which I=
 can
strace(1), but nothing more, and I want to know who is it talking to.

--=20
By=C5=82o mi bardzo mi=C5=82o.                    Czwarta pospolita kl=C4=
=99ska, [...]
>=C5=81ukasz<                      Ju=C5=BC nie katolicka lecz z=C5=82odz=
iejska.  (c)PP


--------------enig26AB05DB3919DAEA38DD672D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFESN+ZNdzY8sm9K9wRAslUAJ9hiPtr6EFjslg7vDmQeKGbpsI1wQCeKqgD
86cIOg/zRaZptxa6KIgYi00=
=hewy
-----END PGP SIGNATURE-----

--------------enig26AB05DB3919DAEA38DD672D--
