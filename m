Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263732AbTLEHc6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 02:32:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263893AbTLEHc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 02:32:58 -0500
Received: from relais.videotron.ca ([24.201.245.36]:9902 "EHLO
	VL-MO-MR005.ip.videotron.ca") by vger.kernel.org with ESMTP
	id S263732AbTLEHc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 02:32:56 -0500
Date: Fri, 05 Dec 2003 02:32:55 -0500
From: Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>
Subject: Re: High-pitch noise with 2.6.0-test11
In-reply-to: <1070605910.4867.9.camel@idefix.homelinux.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Message-id: <1070609574.4328.3.camel@idefix.homelinux.org>
Organization: =?ISO-8859-1?Q?Universit=C3=A9_de?= Sherbrooke
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7)
Content-type: multipart/signed; boundary="=-iMQhBbR/3lMhT2I6JV9o";
 protocol="application/pgp-signature"; micalg=pgp-sha1
References: <1070605910.4867.9.camel@idefix.homelinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-iMQhBbR/3lMhT2I6JV9o
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

> I just installed 2.6.0-test11 on my Dell Latitude D600 (Pentium-M)
> laptop and I noticed a strange high-pitch noise comming from the laptop
> itself (that wasn't there with 2.4). The noise happens only when the CPU
> is idle. Also, I have noticed that removing thermal.o makes the noise
> stop, which is very odd. Is there anything that can be done about that?

Actually, speaking of thermal.o, this is what I got when I tried to
remove it:

Unable to handle kernel paging request at virtual address f882e28f
 printing eip:
f882e28f
*pde =3D 37f86067
*pte =3D 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<f882e28f>]    Not tainted
EFLAGS: 00010296
EIP is at 0xf882e28f
eax: 00000000   ebx: 00091662   ecx: 00000008   edx: 00000000
esi: f79d12f8   edi: 000909e9   ebp: f79d1200   esp: c037bfc0
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=3Dc037a000 task=3Dc030d440)
Stack: 0009f600 00000000 c037a000 0009f600 c0105000 0008e000 c01090e4
00000816
       c037c74a c030d440 00000000 c03b2ec8 00000003 c037c470 c03b8100
c010017e
Call Trace:
 [<c0105000>] rest_init+0x0/0x60
 [<c01090e4>] cpu_idle+0x34/0x40
 [<c037c74a>] start_kernel+0x18a/0x1c0
 [<c037c470>] unknown_bootoption+0x0/0x120
                                                                           =
    =20
Code:  Bad EIP value.
 <0>Kernel panic: Attempted to kill the idle task!
In idle task - not syncing

Hope this helps.

	Jean-Marc

P.S. I'm not subscribed to the list

--=20
Jean-Marc Valin, M.Sc.A., ing. jr.
LABORIUS (http://www.gel.usherb.ca/laborius)
Universit=E9 de Sherbrooke, Qu=E9bec, Canada

--=-iMQhBbR/3lMhT2I6JV9o
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e=2E?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/0DSldXwABdFiRMQRAjuGAJ9sLnm4DBWXQDTh1VkGL3VBjHImtwCfc7qb
Nc3Fi2NXBdpCc5GLrEBWaLM=
=TJlu
-----END PGP SIGNATURE-----

--=-iMQhBbR/3lMhT2I6JV9o--

