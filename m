Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262078AbTKOUnY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Nov 2003 15:43:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262081AbTKOUnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Nov 2003 15:43:24 -0500
Received: from cable98.usuarios.retecal.es ([212.22.32.98]:27096 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S262078AbTKOUnR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Nov 2003 15:43:17 -0500
Subject: [2.6.0-test9-BK20] [ALSA] Unable to handle kernel paging request
	at virtual address d08a7000
From: =?ISO-8859-1?Q?Ram=F3n?= Rey Vicente <rrey@ranty.pantax.net>
Reply-To: ramon.rey@hispalinux.es
To: perex@suse.cz
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <1068683977.3437.1.camel@debian>
References: <1068683977.3437.1.camel@debian>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-I440GVpIsCGzOV2nmGg2"
Message-Id: <1068928939.1127.2.camel@debian>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 15 Nov 2003 21:42:20 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-I440GVpIsCGzOV2nmGg2
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi.

Running mplayer, I get this:

Unable to handle kernel paging request at virtual address d08a7000
 printing eip:
d0947964
*pde =3D 013f0067
*pte =3D 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<d0947964>]    Not tainted
EFLAGS: 00210202
EIP is at resample_expand+0x2e4/0x320 [snd_pcm_oss]
eax: d0947964   ebx: 00000002   ecx: d0937ff2   edx: 00000000
esi: c94547d0   edi: c94547b0   ebp: d08a6ffe   esp: c2eb1e1c
ds: 007b   es: 007b   ss: 0068
Process gmplayer (pid: 1113, threadinfo=3Dc2eb0000 task=3Dc2eb52c0)
Stack: 00000000 ffffffff 0000ec24 c2eb0000 d09478d9 d0947964 00000000
00000004=20
       00000004 00000001 00000000 000002a9 00000bff 00000400 c9454740
c96caa20=20
       d0947dff c9454740 cb224820 c96caa20 00000400 00000bff c9454740
00000400=20
Call Trace:
 [<d09478d9>] resample_expand+0x259/0x320 [snd_pcm_oss]
 [<d0947964>] resample_expand+0x2e4/0x320 [snd_pcm_oss]
 [<d0947dff>] rate_transfer+0x3f/0x60 [snd_pcm_oss]
 [<d09454ae>] snd_pcm_plug_write_transfer+0x6e/0xc0 [snd_pcm_oss]
 [<d0941291>] snd_pcm_oss_write2+0xb1/0x120 [snd_pcm_oss]
 [<d0941855>] snd_pcm_oss_sync1+0x55/0x120 [snd_pcm_oss]
 [<c0117680>] default_wake_function+0x0/0x20
 [<d09229d4>] snd_pcm_format_set_silence+0x74/0x180 [snd_pcm]
 [<d09419c0>] snd_pcm_oss_sync+0xa0/0x1c0 [snd_pcm_oss]
 [<d0942dbe>] snd_pcm_oss_release+0x1e/0xc0 [snd_pcm_oss]
 [<c014bfae>] __fput+0xee/0x120
 [<c014a7e3>] filp_close+0x43/0x80
 [<c014a873>] sys_close+0x53/0x80
 [<c0109047>] syscall_call+0x7/0xb

Code: 8b 45 00 e9 80 fe ff ff 8a 45 00 83 f0 80 89 c2 c1 e2 08 eb
--=20
Ram=F3n Rey Vicente       <ramon dot rey at hispalinux dot es>
        jabber ID       <rreylinux at jabber dot org>
GPG public key ID 	0xBEBD71D5 -> http://pgp.escomposlinux.org/

--=-I440GVpIsCGzOV2nmGg2
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
	digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/to+qRGk68b69cdURAgwqAJ4xN2jJsq6UKuYcIsaNjLZv+B3zlwCeLnEu
cjrXn/Hthq+O2so8TQvzr18=
=r+gM
-----END PGP SIGNATURE-----

--=-I440GVpIsCGzOV2nmGg2--

