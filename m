Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267131AbSKXCFz>; Sat, 23 Nov 2002 21:05:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267132AbSKXCFz>; Sat, 23 Nov 2002 21:05:55 -0500
Received: from CPE-203-51-30-159.nsw.bigpond.net.au ([203.51.30.159]:14976
	"EHLO matty.emma.house") by vger.kernel.org with ESMTP
	id <S267131AbSKXCFy>; Sat, 23 Nov 2002 21:05:54 -0500
Date: Sun, 24 Nov 2002 13:22:30 +1100
From: Matthew Hawkins <matt@mh.dropbear.id.au>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19-ck13 oops
Message-ID: <20021124022230.GB690@mh.dropbear.id.au>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i0/AhcQY5QxfSsSZ"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--i0/AhcQY5QxfSsSZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Nov 24 00:11:43 matty kernel: Assertion failure in journal_commit_transacti=
on() at commit.c:79: "commit_transaction->t_state =3D=3D T_RUN
NING"
Nov 24 00:11:43 matty kernel: kernel BUG at commit.c:79!
Nov 24 00:11:43 matty kernel: invalid operand: 0000
Nov 24 00:11:43 matty kernel: CPU:    1
Nov 24 00:11:43 matty kernel: EIP:    0010:[journal_commit_transaction+250/=
4307]    Not tainted
Nov 24 00:11:43 matty kernel: EFLAGS: 00010286
Nov 24 00:11:43 matty kernel: eax: 00000070   ebx: d7355494   ecx: ffffff90=
   edx: d76bc000
Nov 24 00:11:43 matty kernel: esi: d7355400   edi: d7355400   ebp: d5f88bc0=
   esp: d76bde74
Nov 24 00:11:43 matty kernel: ds: 0018   es: 0018   ss: 0018
Nov 24 00:11:43 matty kernel: Process kjournald (pid: 103, stackpage=3Dd76b=
d000)
Nov 24 00:11:43 matty kernel: Stack: c0252260 c0252230 c0252227 0000004f c0=
2522e0 d7355450 d7355400 d7355400=20
Nov 24 00:11:43 matty kernel:        00000000 00000000 06c9c930 c8bc85a0 d7=
355450 d7355494 d7ed7120 00000000=20
Nov 24 00:11:43 matty kernel:        00000000 00000000 00000000 c01cfad8 d1=
15d1c0 00001587 ca41c360 ca41c5a0=20
Nov 24 00:11:43 matty kernel: Call Trace:    [ide_do_request+676/768] [load=
_balance+972/1672] [smp_apic_timer_interrupt+243/276] [upd
ate_process_times+37/44] [smp_apic_timer_interrupt+243/276]
Nov 24 00:11:43 matty kernel:   [call_apic_timer_interrupt+5/13] [kjournald=
+342/552] [commit_timeout+0/12] [kernel_thread+40/56]
Nov 24 00:11:43 matty kernel:=20
Nov 24 00:11:43 matty kernel: Code: 0f 0b 4f 00 27 22 25 c0 83 c4 14 8d b4 =
26 00 00 00 00 c7 45=20

--=20
Matt

--i0/AhcQY5QxfSsSZ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE94DfmWzq7BJucGyIRAnXNAJ9bS+KYgc1iskWLWruOb8FTOGnJagCeKlMK
KhWLopwa2H5qDGBh9i6q/TU=
=sDM3
-----END PGP SIGNATURE-----

--i0/AhcQY5QxfSsSZ--
