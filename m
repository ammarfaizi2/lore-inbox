Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266723AbUFYMMx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266723AbUFYMMx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 08:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266720AbUFYMMx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 08:12:53 -0400
Received: from ucs.co.za ([196.23.43.2]:3487 "EHLO ucsns.ucs.co.za")
	by vger.kernel.org with ESMTP id S266727AbUFYMMU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 08:12:20 -0400
Subject: HP Proliant ML350 kernel panic
From: Mark Hamilton <man@ucs.co.za>
To: linux-kernel@vger.kernel.org
Cc: Berend <bds@ucs.co.za>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-nehtwzoZikXu+xvXxLss"
Organization: 
Message-Id: <1088165491.2255.62.camel@man.ucs.co.za>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 25 Jun 2004 14:11:31 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-nehtwzoZikXu+xvXxLss
Content-Type: multipart/mixed; boundary="=-2BYKGSlBjZTBTCc6Eiw3"


--=-2BYKGSlBjZTBTCc6Eiw3
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I'm running RH9.0 with a 2.4.26 kernel on an HP Proliant ML350 server.
This is one of 3 identical machines, the other 2 servers are live
without any problems, so far.

The kernel panic is intermittent. This particular instance occurred at
boot time, but it will reoccur randomly while the machine is up and
under various load conditions. I've been unable to trigger the panic.

--=-2BYKGSlBjZTBTCc6Eiw3
Content-Disposition: attachment; filename=kernel_oops.txt
Content-Type: text/plain; name=kernel_oops.txt; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

=3D=3D=3D=3D=3D=3D=3D=3D=3D
The Panic
=3D=3D=3D=3D=3D=3D=3D=3D=3D


Unable to handle kernel NULL pointer dereference at virtual address 0000000=
1

*pde =3D 00000000
Oops =3D 0000
CPU: 0
EIP: 0010:[<00000001>] Not tainted
EFLAGS: 00010282
eax: f779e900 ebx: 00000001 ecx: f779e900 edx: f779e900
esi: 00000000 edi: 00001875 edp: f67c5a18 esp: f67bbda0
ds: 0018 es: 0018 ss: 0018
Process  (pid: 0, stackpage=3Df67bb000)
Stack:  00000000 00000000 00000000 f67c5a28 c02b7380 00000000 f7fad880 0000=
0000
	00000000 00000000 c02b77f8 c02b77f8 c02b78f8 00000002 f67edb80 c013ecb5
	4001c000 c1a85e40 f6906a80 f67edc80 4001c000 f67ba000 c02b77f8 c02b78f4
Call Trace: [<c013ecb5>][<c0136e15>][<c012bd75>][<c012be21>][<c011f9b8>]

Code: Bad EIP value.
 <0> kernel panic: Attempted to kill the idle task!
In idle task - not syncing.

--=-2BYKGSlBjZTBTCc6Eiw3
Content-Disposition: attachment; filename=ver_linux
Content-Type: text/plain; name=ver_linux; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
% sh scripts/ver_linux
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Linux b900700.co.za 2.4.26 #1 SMP Thu Jun 24 04:35:03 SAST 2004 i686 i686 i=
386 GNU/Linux
=20
Gnu C                  3.2.2
Gnu make               3.79.1
util-linux             2.11y
mount                  2.11y
modutils               2.4.22
e2fsprogs              1.32
jfsutils               1.0.17
reiserfsprogs          3.6.4
pcmcia-cs              3.1.31
quota-tools            3.06.
PPP                    2.4.1
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 2.0.11
Net-tools              1.60
Kbd                    1.08
Sh-utils               4.5.3
Modules Loaded         vga16fb fbcon-vga-planes parport_pc lp parport tg3 i=
de-scsi ide-cd cdrom dm-mod lvm-mod keybdev mousedev input hid usb-ohci usb=
core ext3 jbd cciss aic7xxx sd_mod scsi_mod

--=-2BYKGSlBjZTBTCc6Eiw3
Content-Disposition: attachment; filename=cpuinfo
Content-Type: text/plain; name=cpuinfo; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
% cat /proc/cpuinfo
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D


processor	: 0
vendor_id	: GenuineIntel
cpu family	: 15
model		: 2
model name	: Intel(R) Xeon(TM) CPU 2.40GHz
stepping	: 9
cpu MHz		: 2392.328
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat =
pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips	: 4771.02

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 15
model		: 2
model name	: Intel(R) Xeon(TM) CPU 2.40GHz
stepping	: 9
cpu MHz		: 2392.328
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat =
pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips	: 4784.12


--=-2BYKGSlBjZTBTCc6Eiw3
Content-Disposition: attachment; filename=modules
Content-Type: text/plain; name=modules; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
% cat /proc/modules
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D



vga16fb                11712  63
fbcon-vga-planes        5480   0 [vga16fb]
parport_pc             19204   1 (autoclean)
lp                      9188   0 (autoclean)
parport                39040   1 (autoclean) [parport_pc lp]
tg3                    57736   1
ide-scsi               12336   0
ide-cd                 35776   0 (autoclean)
cdrom                  34176   0 (autoclean) [ide-cd]
dm-mod                 60036   2
lvm-mod                62784   0 (unused)
keybdev                 3136   0 (unused)
mousedev                5688   0 (unused)
input                   6144   0 [keybdev mousedev]
hid                    12476   0 (unused)
usb-ohci               22184   0 (unused)
usbcore                82560   1 [hid usb-ohci]
ext3                   74468   3
jbd                    56656   3 [ext3]
cciss                  59264   4
aic7xxx               165296   0 (unused)
sd_mod                 13356   0 (unused)
scsi_mod              111320   3 [ide-scsi cciss aic7xxx sd_mod]

--=-2BYKGSlBjZTBTCc6Eiw3--

--=-nehtwzoZikXu+xvXxLss
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQBA3BZwFuBO7h0LngURAoR2AJ9cJ0n7OgHyat7ChPQU+jgl3ICuKQCeM4ef
CEsysEVWE40bCpcTL2l/S9o=
=UdTG
-----END PGP SIGNATURE-----

--=-nehtwzoZikXu+xvXxLss--

