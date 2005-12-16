Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750755AbVLPSLZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbVLPSLZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 13:11:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbVLPSLZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 13:11:25 -0500
Received: from node1.usercenter.de ([62.112.158.193]:42655 "EHLO
	node1.UserCenter.de") by vger.kernel.org with ESMTP
	id S1750755AbVLPSLY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 13:11:24 -0500
From: Gunter Ohrner <G.Ohrner@post.rwth-aachen.de>
Organization: Gunter Ohrner Datensysteme
To: "Bonilla, Alejandro" <alejandro.bonilla@hp.com>
Subject: Re: gtkpod and Filesystem
Date: Fri, 16 Dec 2005 19:09:04 +0100
User-Agent: KMail/1.9.1
References: <F265D57E1F28274EA189ED0566D227DE7F2343@PGJEXC01.americas.cpqcorp.net>
In-Reply-To: <F265D57E1F28274EA189ED0566D227DE7F2343@PGJEXC01.americas.cpqcorp.net>
Cc: linux-kernel@vger.kernel.org, debian-devel@lists.debian.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1511752.2tZkOEQWCl";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200512161909.12075.G.Ohrner@post.rwth-aachen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1511752.2tZkOEQWCl
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Freitag, 16. Dezember 2005 18:19 schrieben Sie:
> |> 	Actually. Issue fixed. It is really odd that a dosfsck fixed it.

I'm glad it helped. :-)

> |i dont see how that is odd.. if the filesystem was somehow corrupted
> |dosfsck would have corrected it.
> Odd how it got "corrupted" and odd on why it would work on Windows and
> not in Linux.

Mh, that's just the same phenomenon one always sees with web sites. If=20
some data structure, be it a file system or an HTML-like tag soup,=20
doesn't conform to the specification, the processors (fs driber or web=20
browser) behavoiur will be implementation dependant... One specific error=20
will break one implementation but not the other, while another error will=20
just cause the opposite, there may be implementations which are more=20
sensitive to specification violation and so on...

So the behaviour you observed is not that surprising, after all. ;)

> Anyway, it works now. I was more worried on the FS Panic than anything
> else.

Well, as I understood it this message just stated that the fs driver was=20
confused and blocked write access for safety reasons, to avoid further=20
damage.

It had nothing to do with a "kernel panic" or similar.

Greetings and happy music listening,

  Gunter

--nextPart1511752.2tZkOEQWCl
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDowLI0ORHvREo8l8RAubcAJ9jf6R0eG1hZ1C/+L6hWjBoxjHqLQCeMdDQ
2Vl18hLwsGLv7om41YoAzV8=
=cdrX
-----END PGP SIGNATURE-----

--nextPart1511752.2tZkOEQWCl--
