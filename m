Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266949AbRGOURu>; Sun, 15 Jul 2001 16:17:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266951AbRGOURk>; Sun, 15 Jul 2001 16:17:40 -0400
Received: from ulima.unil.ch ([130.223.144.143]:51854 "EHLO ulima.unil.ch")
	by vger.kernel.org with ESMTP id <S266949AbRGOUR2>;
	Sun, 15 Jul 2001 16:17:28 -0400
Date: Sun, 15 Jul 2001 22:18:24 +0200
From: Gregoire Favre <greg@ulima.unil.ch>
To: linux-kernel@vger.kernel.org
Subject: 2.4.6-ac3 Oops
Message-ID: <20010715221824.A28207@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
User-Agent: Mutt/1.3.19i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

while writing a CD, I got:

Jul 15 18:46:52 greg kernel: Unable to handle kernel paging request at virt=
ual address 5d93bec4
Jul 15 18:46:52 greg kernel:  printing eip:
Jul 15 18:46:52 greg kernel: c0141eb9
Jul 15 18:46:52 greg kernel: *pde =3D 00000000
Jul 15 18:46:52 greg kernel: Oops: 0002
Jul 15 18:46:52 greg kernel: CPU:    0
Jul 15 18:46:52 greg kernel: EIP:    0010:[prune_dcache+137/304]
Jul 15 18:46:52 greg kernel: EIP:    0010:[<c0141eb9>]
Jul 15 18:46:52 greg kernel: EFLAGS: 00010246
Jul 15 18:46:52 greg kernel: eax: 5d93bec0   ebx: dd630658   ecx: dff22ac8 =
  edx: dd55a6e0
Jul 15 18:46:52 greg kernel: esi: dd630640   edi: dfffce08   ebp: 00000141 =
  esp: c18e1f70
Jul 15 18:46:52 greg kernel: ds: 0018   es: 0018   ss: 0018
Jul 15 18:46:52 greg kernel: Process kswapd (pid: 6, stackpage=3Dc18e1000)
Jul 15 18:46:52 greg kernel: Stack: c012b89d 00000000 c17c2ec0 c17c2e98 000=
00000 00000007 c012b72e 00000001=20
Jul 15 18:46:52 greg kernel:        000000c0 0000017c 00000000 0008e000 c01=
42201 00000176 c012ba87 00000006=20
Jul 15 18:46:52 greg kernel:        000000c0 000000c0 00000000 00000000 000=
000c0 00000000 c012bb1e 000000c0=20
Jul 15 18:46:54 greg kernel: Call Trace: [free_shortage+29/144] [page_laund=
er+1566/1648] [shrink_dcache_memory+33/64] [do_try_to_free_pages+39/96] [ks=
wapd+94/240]=20
Jul 15 18:46:54 greg kernel: Call Trace: [<c012b89d>] [<c012b72e>] [<c01422=
01>] [<c012ba87>] [<c012bb1e>]=20
Jul 15 18:46:54 greg kernel:    [_stext+0/48] [_stext+0/48] [kernel_thread+=
38/48] [kswapd+0/240]=20
Jul 15 18:46:54 greg kernel:    [<c0105000>] [<c0105000>] [<c01054e6>] [<c0=
12bac0>]=20
Jul 15 18:46:54 greg kernel:=20
Jul 15 18:46:54 greg kernel: Code: 89 50 04 89 02 8b 7b f0 85 ff 74 38 c7 4=
3 f0 00 00 00 00 8d=20

I put the System.map-2.4.6-ac3 under http://ulima.unil.ch/greg/linux/System=
.map-2.4.6-ac3 and the output of
lspci -v under http://ulima.unil.ch/greg/linux/lspci and the config file un=
der
http://ulima.unil.ch/greg/linux/246-ac3

Just let me know if some other informations are needed ;-)

Thanks and have a great day,

	Greg
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.5 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7UfqPFDWhsRXSKa0RAvvWAKDUMa/p+DcdQ3kOpoHc7dkKTKXQEQCdFK+N
4HGcfkv5cVWxbauAqCbO6sQ=
=aS/E
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
