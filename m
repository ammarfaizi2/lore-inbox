Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964813AbVL1Nwz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964813AbVL1Nwz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 08:52:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964815AbVL1Nwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 08:52:55 -0500
Received: from mail.gmx.de ([213.165.64.21]:35462 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964813AbVL1Nwy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 08:52:54 -0500
X-Authenticated: #5339386
Date: Wed, 28 Dec 2005 14:50:22 +0100
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: oops in kernel 2.6.15-rc6
Message-ID: <20051228135021.GA9777@sidney>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
User-Agent: Mutt/1.5.11
From: Mathias Klein <ma_klein@gmx.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello all,

[please CC me on replies, I'm not subscribed to this list]

I had this following kernel oops while compiling a new kernel.=20

Dec 27 19:02:00 sidney kernel: [14896.995613] Unable to handle kernel pagin=
g request at virtual address 76f7104d
Dec 27 19:02:00 sidney kernel: [14896.995665]  printing eip:
Dec 27 19:02:00 sidney kernel: [14896.995682] c013a392
Dec 27 19:02:00 sidney kernel: [14896.995692] *pde =3D 00000000
Dec 27 19:02:00 sidney kernel: [14896.995711] Oops: 0002 [#1]
Dec 27 19:02:00 sidney kernel: [14896.995726] PREEMPT=20
Dec 27 19:02:00 sidney kernel: [14896.995744] Modules linked in: md5 ipv6 l=
p capi capifs kernelcapi nls_iso8859_15 nls_cp437 vfat fat parport_pc parpo=
rt joydev evdev tuner tvaudio msp3400 bttv video_buf firmware_class v4l2_co=
mmon btcx_risc tveeprom videodev snd_bt87x snd_ens1370 gameport nvidiafb sn=
d_rawmidi snd_seq_device snd_pcm snd_timer snd_page_alloc snd_ak4531_codec =
rivafb uhci_hcd ide_cd snd 8139too mii i2c_viapro usbcore cdrom soundcore c=
rc32
Dec 27 19:02:00 sidney kernel: [14896.996038] CPU:    0
Dec 27 19:02:00 sidney kernel: [14896.996044] EIP:    0060:[shrink_slab+95/=
315]    Not tainted VLI
Dec 27 19:02:00 sidney kernel: [14896.996053] EFLAGS: 00010246   (2.6.15-rc=
6.sidney.10)=20
Dec 27 19:02:00 sidney kernel: [14896.996117] EIP is at shrink_slab+0x5f/0x=
13b
Dec 27 19:02:00 sidney kernel: [14896.996141] eax: c1154900   ebx: 00000000=
   ecx: 00006830   edx: 00000000
Dec 27 19:02:00 sidney kernel: [14896.996172] esi: 700f0b05   edi: 0000002b=
   ebp: c125df3f   esp: c125df1c
Dec 27 19:02:00 sidney kernel: [14896.996200] ds: 007b   es: 007b   ss: 0068
Dec 27 19:02:00 sidney kernel: [14896.996224] Process kswapd0 (pid: 51, thr=
eadinfo=3Dc125c000 task=3Dc1256580)
Dec 27 19:02:00 sidney kernel: [14896.996248] Stack: 000000d0 0002a300 0000=
0000 0002a300 00000080 00000000 c029f100 c029f100=20
Dec 27 19:02:00 sidney kernel: [14896.996339]        0000000c c125dfac c013=
b53d 00000000 000000d0 0000682f c029f100 c125df78=20
Dec 27 19:02:00 sidney kernel: [14896.996426]        00000001 00000000 0000=
0000 c125dfd4 00000002 0000682f 00000000 00000020=20
Dec 27 19:02:00 sidney kernel: [14896.996512] Call Trace:
Dec 27 19:02:00 sidney kernel: [14896.996550]  [show_stack+120/131] show_st=
ack+0x78/0x83
Dec 27 19:02:00 sidney kernel: [14896.996600]  [show_registers+306/415] sho=
w_registers+0x132/0x19f
Dec 27 19:02:00 sidney kernel: [14896.996646]  [die+202/332] die+0xca/0x14c
Dec 27 19:02:00 sidney kernel: [14896.996687]  [do_page_fault+910/1211] do_=
page_fault+0x38e/0x4bb
Dec 27 19:02:00 sidney kernel: [14896.996748]  [error_code+79/96] error_cod=
e+0x4f/0x60
Dec 27 19:02:00 sidney kernel: [14896.996791]  [phys_startup_32+329596353/-=
1073741824] 0x13b53dc1
Dec 27 19:02:00 sidney kernel: [14896.996834] Code: 00 00 00 8b 35 f4 f8 29=
 c0 c1 e1 02 89 4d ec 83 ee 04 c7 45 f0 00 00 00 00 e9 ba 00 00 00 ff 75 0c=
 6a 00 ff 16 89 c7 8b 45 ec 31 <d2> 8b 4d 10 f7 76 0c 41 f7 e7 89 45 e0 89 =
55 e4 89 d3 89 45 e8=20

please let me know if you need more informations/how I can help you solve
this problem.

Mathias Klein

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDspgdPtJqRGqEpd8RAqeRAJ905+2z73YM+wwiO4kyqsX3FGg5nQCfRYQX
0IzTtGuwGjG+uBPNfKHdE4o=
=4nbf
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
