Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261764AbTJFX6K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 19:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261768AbTJFX6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 19:58:10 -0400
Received: from [38.119.218.103] ([38.119.218.103]:48514 "HELO
	mail.bytehosting.com") by vger.kernel.org with SMTP id S261764AbTJFX6D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 19:58:03 -0400
X-Qmail-Scanner-Mail-From: drunk@conwaycorp.net via digital.bytehosting.com
X-Qmail-Scanner: 1.20rc3 (Clear:RC:1:. Processed in 0.109313 secs)
Date: Mon, 6 Oct 2003 18:57:59 -0500
From: Nathan <kraken@drunkmonkey.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test6[-mm4] boot failure on alpha
Message-ID: <20031006235759.GA26127@wang-fu.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


I'm having a problem getting 2.6.0-test6 and/or 2.6.0-test6-mm4 to boot
on my AS2100.  It boots and runs fine with 2.4.21.  The following is what
I get when I boot -test6-mm4 (although it stops at the same point with
vanilla -test6).  Any suggestions, comments, or requests for further
information are welcome.


aboot: starting kernel boot/vmlinuz-2.6.0-test6-mm4 with arguments ro root=
=3D/dev/sda1 console=3DttyS0,9600n8
Linux version 2.6.0-test6-mm4 (root@buddha) (gcc version 3.3.2 20030908 (De=
bian prerelease)) #1 SMP Mon Oct 6 18:14:06 CDT 2003
Booting on Sable using machine vector Sable from SRM
Major Options: SMP LEGACY_START VERBOSE_MCHECK MAGIC_SYSRQ=20
Command line: ro root=3D/dev/sda1 console=3DttyS0,9600n8
memcluster 0, usage 1, start        0, end      256
memcluster 1, usage 0, start      256, end    65527
memcluster 2, usage 1, start    65527, end    65536
freeing pages 256:384
freeing pages 811:65527
reserving pages 811:812
t2_init_arch: enabling SG TLB, IOCSR was 0xfe000084230a8190
SMP: 4 CPUs probed -- cpu_present_mask =3D f
On node 0 totalpages: 65527
  DMA zone: 65527 pages, LIFO batch:8
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
Building zonelist for node : 0
Kernel command line: ro root=3D/dev/sda1 console=3DttyS0,9600n8
PID hash table entries: 2048 (order 11: 32768 bytes)
Using epoch =3D 1952
Turning on RTC interrupts.
Console: colour VGA+ 80x25
Memory: 512960k/524216k available (2056k kernel code, 8840k reserved, 301k =
data, 440k init)
Calibrating delay loop... 545.60 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 5, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 8192 bytes)
POSIX conformance testing by UNIFIX
per-CPU timeslice cutoff: 374.48 usecs.
task migration cache decay timeout: 0 msecs.
SMP starting up secondaries.
Starting migration thread for cpu 0
Bringing up 1
Calibrating delay loop... 547.16 BogoMIPS
CPU 1 IS NOW UP!
Starting migration thread for cpu 1
Bringing up 2
Calibrating delay loop... 547.16 BogoMIPS
CPU 2 IS NOW UP!
Starting migration thread for cpu 2
Bringing up 3
Calibrating delay loop... 549.72 BogoMIPS
CPU 3 IS NOW UP!
Starting migration thread for cpu 3
CPUS done 4
SMP: Total of 4 processors activated (2195.89 BogoMIPS).
NET: Registered protocol family 16
EISA bus registered
PCI: Bus 1, bridge: 0000:00:07.0
  IO window: 9000-9fff
  MEM window: 01100000-011fffff
  PREFETCH window: disabled.
PCI: Bus 2, bridge: 0000:00:08.0

----
When I boot with 2.4.21, the PCI lines look like:

PCI: Bus 1, bridge: Digital Equipment Corporation DECchip 21050
  IO window: 9000-9fff
  MEM window: 01100000-011fffff
  PREFETCH window: disabled.
PCI: Bus 2, bridge: Digital Equipment Corporation DECchip 21152
  IO window: a000-afff
  MEM window: 01200000-012fffff
  PREFETCH window: 01300000-013fffff


--=20
Nathan Poznick <kraken@drunkmonkey.org>

Debt is a prolific mother of folly and of crime. - Benjamin Disraeli


--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/ggGHYOn9JTETs+URAj8AAKCIvrKljpfgslKjZREuZpfU1YK9hQCePzLf
lH8U3nNrR31TQvhpbq+6jgI=
=f42Q
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
