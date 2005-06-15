Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261390AbVFOK4D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261390AbVFOK4D (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 06:56:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261392AbVFOK4C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 06:56:02 -0400
Received: from [213.69.232.60] ([213.69.232.60]:27150 "HELO ei.schottelius.org")
	by vger.kernel.org with SMTP id S261390AbVFOKzv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 06:55:51 -0400
Date: Wed, 15 Jun 2005 12:55:37 +0200
From: Nico Schottelius <nico-kernel@schottelius.org>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Subject: Re: Why is one sync() not enough?
Message-ID: <20050615105537.GO1467@schottelius.org>
Mail-Followup-To: Nico Schottelius <nico-kernel@schottelius.org>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mvuFargmsA+C2jC8"
Content-Disposition: inline
In-Reply-To: <20050614215032.35d44e93.akpm@osdl.org>
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.11.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mvuFargmsA+C2jC8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Andrew,

you wrote:
> What filesystem?

jfs

> What kernel version?

2.6.11.11

> Any unusual bind mounts, loopback
> mounts, etc?  There must be something there...>

Yes, dm-crypt-mounted-jfs.

So if I understood everything correctly, a simple umount() without
a sync() before should be enough?

If so, I'll try that, I am happy about every less function call
I need to do.

Nico

P.S.: Helge, nice hint for debugging, cat'ing /proc/mounts before
      reboot/power-off/etc.!

--=20
Keep it simple & stupid, use what's available.
Please use pgp encryption: 8D0E 27A4 is my id.
http://nico.schotteli.us | http://linux.schottelius.org

--mvuFargmsA+C2jC8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iQIVAwUBQrAJKLOTBMvCUbrlAQJ3rQ/9EI7BVUOjx4mmhh4iT5r6ldxbAsfoMds8
9Bw74fyxEDzgjDLa+/ZBZv4zUjiz4swDJaWqd/BptRef389NtGN3M0f4CPaqirNX
grAgnllXanid9I/Js4Xq3plR3opgcfQ6DfT79cUoC8lApd8acEPK1ETKLobMIdAh
aZhq8gRSpOV8ZBlm7Z1YB+aiXSHxF06OlgOMLUwh66MeqXgugjB+t//smuMcV/Xt
jjpX/NKbpV43frwReGFInkjWW5511lKUz8KaRsTxe7xZpl993YZfc7Y0MIcUrEaJ
Q0fethnKXUL8m8OEvJzICebbuNKBoVa04dY5x97iiknwEQhu0WCGJEDQdQAWDuh+
qOYfejE6ja4NEEHvP5uaTMup6RKA5ttHyDVuKOBWZme1USZ4VL6vCYEvQdApA4Pc
BjxPrC4C5FRuAOGsRmXJtqtnjhSJO2GuePPbejmE6g45a3fRBzKp9svAAY6I54Lo
jh+BnqDBEUlib0s+PcuW39QSRbTHuYFM1xwHLNvCATsp1cp80J6EH1wkR6L5+N0q
pqkq7i5h94UG0BZhlSaSietGfXkKFEGX/MGcgsbnR0rJEwu4CmoLOUDIcQbLlAme
dnaxaet2Rl45nE2JnEfar7W52n0OBN5ugMN4mMaILNO8YkMdv0NeUFfp87w94lU2
mZ/v4W8DYgs=
=1VR0
-----END PGP SIGNATURE-----

--mvuFargmsA+C2jC8--
