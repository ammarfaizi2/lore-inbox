Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261366AbTHZPoB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 11:44:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262719AbTHZPoB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 11:44:01 -0400
Received: from [24.241.190.29] ([24.241.190.29]:8901 "EHLO wally.rdlg.net")
	by vger.kernel.org with ESMTP id S261366AbTHZPnt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 11:43:49 -0400
Date: Tue, 26 Aug 2003 11:43:43 -0400
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Where'd my second proc go?
Message-ID: <20030826154343.GU16183@rdlg.net>
Mail-Followup-To: Zwane Mwaikambo <zwane@linuxpower.ca>,
	Linux-Kernel <linux-kernel@vger.kernel.org>
References: <20030826151225.GT16183@rdlg.net> <Pine.LNX.4.53.0308261124200.6876@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0cPfB1ccX8kkdppm"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0308261124200.6876@montezuma.fsmlabs.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0cPfB1ccX8kkdppm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Thus spake Zwane Mwaikambo (zwane@linuxpower.ca):

> On Tue, 26 Aug 2003, Robert L. Harris wrote:
>=20
> >=20
> >=20
> > Dual-P3-850.  Bios reports both procs.  2.4.21-ac3 reported both procs.
> > 2.4.22-rc2-ac1 only shows one.  The lilo used to have a "maxcpus=3D1"
> > append but I removed that and I tried changing it to 4 even.  cat
> > /proc/cpu only shows 1 still.
>=20
> dmesg?
>=20
> > root# cat /proc/cpuinfo=20
> > processor       : 0
> > vendor_id       : GenuineIntel
> > cpu family      : 6
> > model           : 8
> > model name      : Pentium III (Coppermine)
> > stepping        : 3
> > cpu MHz         : 846.342
> > cache size      : 256 KB
> > physical id     : 0
> > siblings        : 1
> > fdiv_bug        : no
> > hlt_bug         : no
> > f00f_bug        : no
> > coma_bug        : no
> > fpu             : yes
> > fpu_exception   : yes
> > cpuid level     : 2
> > wp              : yes
> > flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
> > mca cmov pat pse36 mmx fxsr sse
> > bogomips        : 1684.27
> >=20
> > root# uname -a
> > Linux nms-hub2.acs.pnap.net 2.4.22-rc2-ac1 #1 SMP Sat Aug 9 12:32:27 ED=
T 2003 i686 unknown
> >=20
> >=20
> > Pushing to the latest 2.4.22 kernel would be a nightmare as that means
> > another testing cycle and 2.4.23 will be out before it gets passed.
> >=20
> > Thoughts?
> >   Robert


Kernel command line: auto BOOT_IMAGE=3Dlinux ro root=3D801 console=3Dtty0
console=3DttyS0 maxcpus=3D4
Initializing CPU#0
Detected 846.342 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1684.27 BogoMIPS
Memory: 252844k/262080k available (3557k kernel code, 8848k reserved,
1109k data, 620k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU serial number disabled.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU0: Intel Pentium III (Coppermine) stepping 03
per-CPU timeslice cutoff: 731.27 usecs.
task migration cache decay timeout: 10 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Error: only one processor found.
ENABLING IO-APIC IRQs
Setting 0 in the phys_id_present_map
=2E..changing IO-APIC physical APIC ID to 0 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 0-0, 0-9, 0-10, 0-11, 0-16, 0-17, 0-18, 0-20,
0-22, 0-23 not connected.
=2E.TIMER: vector=3D0x31 pin1=3D2 pin2=3D0
number of MP IRQ sources: 17.
number of IO-APIC #0 registers: 24.
testing the IO APIC.......................

IO APIC #0......
=2E... register #00: 00000000
=2E......    : physical APIC id: 00
=2E
=2E
=2E
IRQ21 -> 0:21
=2E................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
=2E.... CPU clock speed is 846.3425 MHz.
=2E.... host bus clock speed is 99.5696 MHz.
cpu: 0, clocks: 995696, slice: 497848
CPU0<T0:995696,T1:497840,D:8,S:497848,C:995696>
migration_task 0 on cpu=3D0
PCI: PCI BIOS revision 2.10 entry at 0xfdab0, last bus=3D2
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Discovered primary peer bus ff [IRQ]
PCI: Using IRQ router PIIX/ICH [8086/7110] at 00:12.0
PCI->APIC IRQ transform: (B0,I12,P0) -> 19
PCI->APIC IRQ transform: (B0,I12,P0) -> 19
PCI->APIC IRQ transform: (B0,I14,P0) -> 21
PCI->APIC IRQ transform: (B0,I18,P3) -> 21
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
PnPBIOS: Found PnP BIOS installation structure at 0xc00f6c60
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xa8cb, dseg 0x400
PnPBIOS: 19 nodes reported by PnP BIOS; 19 recorded by driver
PnPBIOS: PNP0c02: ioport range 0xc00-0xc3f has been reserved
PnPBIOS: PNP0c02: ioport range 0xca0-0xca3 has been reserved
PnPBIOS: PNP0c02: ioport range 0xcb8-0xcbf has been reserved
PnPBIOS: PNP0c02: ioport range 0x4d0-0x4d1 has been reserved
PnPBIOS: PNP0c02: ioport range 0x1000-0x103f has been reserved
PnPBIOS: PNP0c02: ioport range 0x1040-0x104f has been reserved
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
BIOS EDD facility v0.09 2003-Jan-22, 1 devices found
Starting kswapd
Journalled Block Device driver loaded


:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | GPG Key ID: E344DA3B
                                         @ x-hkp://pgp.mit.edu
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.

Life is not a destination, it's a journey.
  Microsoft produces 15 car pileups on the highway.
    Don't stop traffic to stand and gawk at the tragedy.

--0cPfB1ccX8kkdppm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/S4Av8+1vMONE2jsRAkcZAJ4ja6yZL9up0egNNPtAKi1ooGizmwCgj+h4
swOKAMTnebdMLm6cBzDldro=
=NrBD
-----END PGP SIGNATURE-----

--0cPfB1ccX8kkdppm--
