Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262615AbRFBQg1>; Sat, 2 Jun 2001 12:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262617AbRFBQgQ>; Sat, 2 Jun 2001 12:36:16 -0400
Received: from lenka.ph.ipex.cz ([212.71.128.11]:25640 "EHLO lenka.ph.ipex.cz")
	by vger.kernel.org with ESMTP id <S262615AbRFBQgH>;
	Sat, 2 Jun 2001 12:36:07 -0400
Date: Sat, 2 Jun 2001 18:37:18 +0200
From: Robert Vojta <vojta@ipex.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [bug] at slab.c ...
Message-ID: <20010602183718.A2310@ipex.cz>
In-Reply-To: <E156EFq-0001ts-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
In-Reply-To: <E156EFq-0001ts-00@the-village.bc.nu>
User-Agent: Mutt/1.3.18i
X-Telephone: +420 603 167 911
X-Company: IPEX, s.r.o.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> What X server ? and also run the trace through ksymoops

  It's fresh installation of RH 7.1 (XFree86-4.0.3-5) ...

>>EIP; c0129884 <try_to_swap_out+174/1d0>   <=3D=3D=3D=3D=3D
Trace; c01b08db <skb_checksum+3b/220>
Trace; c01affd7 <pskb_copy+167/170>
Trace; c01e4e79 <netlink_create+59/d0>
Trace; c0129ddc <reclaim_page+1ec/3c0>
Trace; c01adc1c <sys_recvmsg+ac/200>
Trace; c01b0a9b <skb_checksum+1fb/220>
Trace; c01adf53 <sys_socketcall+1a3/200>
Trace; c01adfeb <sock_register+3b/40>
Trace; c01321bc <__remove_inode_queue+1c/20>
Trace; c0129ddc <reclaim_page+1ec/3c0>
Trace; c0140412 <locks_mandatory_locked+2/40>
Trace; c0132323 <set_blocksize+63/1f0>
Trace; c0106cab <system_call+33/38>
Code;  c0129884 <try_to_swap_out+174/1d0>
00000000 <_EIP>:
Code;  c0129884 <try_to_swap_out+174/1d0>   <=3D=3D=3D=3D=3D
   0:   0f 0b                     ud2a      <=3D=3D=3D=3D=3D
Code;  c0129886 <try_to_swap_out+176/1d0>
   2:   58                        pop    %eax
Code;  c0129887 <try_to_swap_out+177/1d0>
   3:   8b 6b 10                  mov    0x10(%ebx),%ebp
Code;  c012988a <try_to_swap_out+17a/1d0>
   6:   5a                        pop    %edx
Code;  c012988b <try_to_swap_out+17b/1d0>
   7:   81 e5 00 04 00 00         and    $0x400,%ebp
Code;  c0129891 <try_to_swap_out+181/1d0>
   d:   74 4d                     je     5c <_EIP+0x5c> c01298e0 <swap_out_=
pmd+0/100>
Code;  c0129893 <try_to_swap_out+183/1d0>
   f:   b8 a5 c2 0f 17            mov    $0x170fc2a5,%eax

Best,
  .R.V.

--=20
   _
  |-|  __      Robert Vojta <vojta-at-ipex.cz>          -=3D Oo.oO =3D-
  |=3D| [Ll]     IPEX, s.r.o.
  "^" =3D=3D=3D=3D`o

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjsZFj4ACgkQInNB3KDLeVPLhACeNkTAy0QJcloMjB7BdL3CJdbT
K7AAn0C0fbEgSs2Lu8jHRyNaLGQ0vx0V
=1J90
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
