Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263400AbTJKWOu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 18:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263401AbTJKWOu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 18:14:50 -0400
Received: from viriato1.servicios.retecal.es ([212.89.0.44]:23217 "EHLO
	viriato1.servicios.retecal.es") by vger.kernel.org with ESMTP
	id S263400AbTJKWOs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 18:14:48 -0400
Subject: [2.6.0-test7-bk][OOPS] Unable to handle kernel paging request at
	virtual address d0924000
From: =?ISO-8859-1?Q?Ram=F3n?= Rey Vicente <ramon.rey@hispalinux.es>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-gOwu+Ak7PCRXE1Y3WQLp"
Organization: Hispalinux - http://www.hispalinux.es
Message-Id: <1065908373.1227.4.camel@debian>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 11 Oct 2003 23:39:34 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-gOwu+Ak7PCRXE1Y3WQLp
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

I obtain this with ALSA:

Unable to handle kernel paging request at virtual address d0924000
 printing eip:
d0934964
*pde =3D 013ea067
*pte =3D 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<d0934964>]    Not tainted
EFLAGS: 00210202=20
EIP is at resample_expand+0x2e4/0x320 [snd_pcm_oss]
eax: d0934964   ebx: 00000001   ecx: d0940ff0   edx: 00000000
esi: c98ff2ec   edi: c98ff2d0   ebp: d0923ffe   esp: c568de1c
ds: 007b   es: 007b   ss: 0068
Process simutrans (pid: 1453, threadinfo=3Dc568c000 task=3Dc5caa660)
Stack: 00000000 ffffffff 0000ec24 c568c000 d09348d9 d0934964 00000000
00000002
       00000002 00000000 00000000 000002a6 00002ffa 00001000 c98ff260
c1c15720
       d0934dff c98ff260 c1c15580 c1c15720 00001000 00002ffa c98ff260
00001000
Call Trace:
 [<d09348d9>] resample_expand+0x259/0x320 [snd_pcm_oss]
 [<d0934964>] resample_expand+0x2e4/0x320 [snd_pcm_oss]
 [<d0934dff>] rate_transfer+0x3f/0x60 [snd_pcm_oss]
 [<d09324ae>] snd_pcm_plug_write_transfer+0x6e/0xc0 [snd_pcm_oss]
 [<d092e291>] snd_pcm_oss_write2+0xb1/0x120 [snd_pcm_oss]
 [<d092e855>] snd_pcm_oss_sync1+0x55/0x120 [snd_pcm_oss]
 [<c0117680>] default_wake_function+0x0/0x20
 [<d090f9b4>] snd_pcm_format_set_silence+0x74/0x180 [snd_pcm]
 [<d092e9c0>] snd_pcm_oss_sync+0xa0/0x1c0 [snd_pcm_oss]
 [<d092fdbe>] snd_pcm_oss_release+0x1e/0xc0 [snd_pcm_oss]
 [<c014bbce>] __fput+0xee/0x120
 [<c014a403>] filp_close+0x43/0x80
 [<c014a493>] sys_close+0x53/0x80
 [<c0109027>] syscall_call+0x7/0xb

Code: 8b 45 00 e9 80 fe ff ff 8a 45 00 83 f0 80 89 c2 c1 e2 08 eb

--=20
Ram=F3n Rey Vicente       <ramon dot rey at hispalinux dot es>
        jabber ID       <rreylinux at jabber dot org>
GPG public key ID 	0xBEBD71D5 -> http://pgp.escomposlinux.org/

--=-gOwu+Ak7PCRXE1Y3WQLp
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
	digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/iHiURGk68b69cdURAlmnAJ44O/Hrxv41LSpkjCEMbIQSa2sdTwCeO/Ua
fZJL3d5NIrF1bCSvc4dQ8cI=
=AwFz
-----END PGP SIGNATURE-----

--=-gOwu+Ak7PCRXE1Y3WQLp--

