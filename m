Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261316AbRERSOl>; Fri, 18 May 2001 14:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261388AbRERSOb>; Fri, 18 May 2001 14:14:31 -0400
Received: from natpost.webmailer.de ([192.67.198.65]:31465 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S261335AbRERSO1>; Fri, 18 May 2001 14:14:27 -0400
Date: Fri, 18 May 2001 18:42:27 +0200
From: Andreas Bergen <andreas.bergen@online.de>
To: linux-kernel@vger.kernel.org
Subject: Oops
Message-ID: <20010518184227.A1068@erde.erde.bergen>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3uo+9/B/ebqu+fSQ"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3uo+9/B/ebqu+fSQ
Content-Type: multipart/mixed; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi, this is an oops-file I "created" today.

Attached is the original version as found in /var/log/messages as well
as the ksymoops-ed version.

Hope, it helps. If you need further info, don't hesitate to contact me.

My machine is a Cyrix 6x68 166+; 96 MB RAM.

Yours
  Andreas Bergen
--=20
Andreas Bergen
E-Mail: andreas.bergen@online.de
PGP-Key on keyservers.
"Freuet euch in dem Herrn allewege, und abermals sage ich: Freuet euch!" Ph=
i 4,4

--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="oops.txt"

May 18 17:27:20 erde kernel: Unable to handle kernel paging request at virtual address 0696f974
May 18 17:27:20 erde kernel: current->tss.cr3 = 044e0000, %cr3 = 044e0000
May 18 17:27:20 erde kernel: *pde = 00000000
May 18 17:27:20 erde kernel: Oops: 0000
May 18 17:27:20 erde kernel: CPU:    0
May 18 17:27:20 erde kernel: EIP:    0010:[ext2_getblk+30/540]
May 18 17:27:20 erde kernel: EFLAGS: 00010246
May 18 17:27:20 erde kernel: eax: c5f95a00   ebx: fffffff4   ecx: c1a5be60   edx: 00000400
May 18 17:27:20 erde kernel: esi: 00000000   edi: c2a6ecc0   ebp: c2a6ecc0   esp: c1a5bdfc
May 18 17:27:20 erde kernel: ds: 0018   es: 0018   ss: 0018
May 18 17:27:20 erde kernel: Process ksysguard (pid: 6625, process nr: 91, stackpage=c1a5b000)
May 18 17:27:20 erde kernel: Stack: c2a6ecc0 c5a897c0 c2bbb000 00100000 00000014 00000400 00000001 00000001
May 18 17:27:20 erde kernel:        c027363c c0145e09 c2a6ecc0 00000000 00000000 c1a5be60 fffffff4 c4546340
May 18 17:27:20 erde kernel:        c2a6ecc0 c5a897c0 c1ea1ef8 c1a5be68 c1a5be84 00000000 00000000 00001000
May 18 17:27:20 erde kernel: Call Trace: [ext2_find_entry+129/784] [process_timeout+14/20] [timer_bh+644/928] [ext2_lookup+48/140] [do_IRQ+65/72] [real_lookup+91/180] [common_interrupt+24/32]
May 18 17:27:20 erde kernel:        [lookup_dentry+304/504] [getname+95/156] [__namei+49/104] [do_8259A_IRQ+143/156] [sys_access+143/268] [system_call+52/64] [startup_32+43/285]
May 18 17:27:20 erde kernel: Code: 24 1c 8b 98 08 01 00 00 c7 01 fb ff ff ff 85 f6 7d 0c 83 c4

--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ksymoops-oops.txt"

ksymoops 0.7c on i586 2.2.17.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.2.17/ (default)
     -m /boot/System.map.2.2.17 (specified)

May 18 17:27:20 erde kernel: Unable to handle kernel paging request at virtual address 0696f974
May 18 17:27:20 erde kernel: current->tss.cr3 = 044e0000, %cr3 = 044e0000
May 18 17:27:20 erde kernel: *pde = 00000000
May 18 17:27:20 erde kernel: Oops: 0000
May 18 17:27:20 erde kernel: CPU:    0
May 18 17:27:20 erde kernel: EIP:    0010:[ext2_getblk+30/540]
May 18 17:27:20 erde kernel: EFLAGS: 00010246
May 18 17:27:20 erde kernel: eax: c5f95a00   ebx: fffffff4   ecx: c1a5be60   edx: 00000400
May 18 17:27:20 erde kernel: esi: 00000000   edi: c2a6ecc0   ebp: c2a6ecc0   esp: c1a5bdfc
May 18 17:27:20 erde kernel: ds: 0018   es: 0018   ss: 0018
May 18 17:27:20 erde kernel: Process ksysguard (pid: 6625, process nr: 91, stackpage=c1a5b000)
May 18 17:27:20 erde kernel: Stack: c2a6ecc0 c5a897c0 c2bbb000 00100000 00000014 00000400 00000001 00000001
May 18 17:27:20 erde kernel:        c027363c c0145e09 c2a6ecc0 00000000 00000000 c1a5be60 fffffff4 c4546340
May 18 17:27:20 erde kernel:        c2a6ecc0 c5a897c0 c1ea1ef8 c1a5be68 c1a5be84 00000000 00000000 00001000
May 18 17:27:20 erde kernel: Call Trace: [ext2_find_entry+129/784] [process_timeout+14/20] [timer_bh+644/928] [ext2_lookup+48/140] [do_IRQ+65/72] [real_lookup+91/180] [common_interrupt+24/32]
May 18 17:27:20 erde kernel: Code: 24 1c 8b 98 08 01 00 00 c7 01 fb ff ff ff 85 f6 7d 0c 83 c4
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   24 1c                     and    $0x1c,%al
Code;  00000002 Before first symbol
   2:   8b 98 08 01 00 00         mov    0x108(%eax),%ebx
Code;  00000008 Before first symbol
   8:   c7 01 fb ff ff ff         movl   $0xfffffffb,(%ecx)
Code;  0000000e Before first symbol
   e:   85 f6                     test   %esi,%esi
Code;  00000010 Before first symbol
  10:   7d 0c                     jge    1e <_EIP+0x1e> 0000001e Before first symbol
Code;  00000012 Before first symbol
  12:   83 c4 00                  add    $0x0,%esp


--BOKacYhQ+x31HxR3--

--3uo+9/B/ebqu+fSQ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: Weitere Infos: siehe http://www.gnupg.org

iD8DBQE7BVDz/28tHYzewY8RAg2CAKCuKxbVwhvm5ne+Q8jPWGLCS9ObQQCggYqL
pRitZfv/ZZqpH8HDlfXIQ/8=
=bjwn
-----END PGP SIGNATURE-----

--3uo+9/B/ebqu+fSQ--
