Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932598AbVHSJhL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932598AbVHSJhL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 05:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932599AbVHSJhL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 05:37:11 -0400
Received: from 13.2-host.augustakom.net ([80.81.2.13]:62104 "EHLO phoebee.mail")
	by vger.kernel.org with ESMTP id S932598AbVHSJhI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 05:37:08 -0400
Date: Fri, 19 Aug 2005 11:37:01 +0200
From: Martin Zwickel <martin.zwickel@technotrend.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.12.5: P4 2.0GHz detected as 2.6GHz?
Message-ID: <20050819113701.26d14c5a@phoebee>
X-Mailer: Sylpheed-Claws 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Linux Phoebee 2.6.7-rc2-mm2 i686 Intel(R) Pentium(R) 4
 CPU 2.40GHz
X-Face: $rTNP}#i,cVI9h"0NVvD.}[fsnGqI%3=N'~,}hzs<FnWK/T]rvIb6hyiSGL[L8S,Fj`u1t.
 ?J0GVZ4&
Organization: Technotrend AG
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=Signature_Fri__19_Aug_2005_11_37_01_+0200_S+XttQ2Ygo.WYlEG;
 protocol="application/pgp-signature"; micalg=pgp-sha1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature_Fri__19_Aug_2005_11_37_01_+0200_S+XttQ2Ygo.WYlEG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Did someone overclock our router or is this a misdetection?

dmesg:
Linux version 2.6.12.5 (root@router) (gcc version 3.3.5 (Debian
1:3.3.5-13)) #1  Thu Aug 18 11:23:14 CEST 2005
...
Kernel command line: auto BOOT_IMAGE=3DLinux2.6.12.5 ro root=3D303
Local APIC disabled by BIOS -- you can enable it with "lapic"
mapped APIC to ffffd000 (01201000)
Initializing CPU#0
PID hash table entries: 1024 (order: 10, 16384 bytes)
Detected 2655.765 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 254876k/262080k available (2571k kernel code, 6632k reserved,
971k data, 188k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode...
Ok. Calibrating delay loop... 5242.88 BogoMIPS (lpj=3D2621440)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebf9ff 00000000 00000000 00000000
00000400  00000000 00000000
CPU: After vendor identify, caps: bfebf9ff 00000000 00000000 00000000
00000400 0 0000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 128K
CPU: After all inits, caps: bfebf9ff 00000000 00000000 00000080 00000400
0000000 0 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
CPU: Intel(R) Celeron(R) CPU 2.00GHz stepping 07
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: setting ELCR to 0200 (from 1820)



# cat /proc/cpuinfo=20
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Celeron(R) CPU 2.00GHz
stepping        : 7
cpu MHz         : 2655.765
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 5242.88


--=20
MyExcuse:
your keyboard's space bar is generating spurious keycodes.

Martin Zwickel <martin.zwickel@technotrend.de>
Research & Development

TechnoTrend AG <http://www.technotrend.de>

--Signature_Fri__19_Aug_2005_11_37_01_+0200_S+XttQ2Ygo.WYlEG
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDBag9mjLYGS7fcG0RAoopAKCFGRzTd7Si6k2focK0ualv/yMw/ACeJh7k
ktOUi4WRpDQ9mvKTVunsSgA=
=8wOm
-----END PGP SIGNATURE-----

--Signature_Fri__19_Aug_2005_11_37_01_+0200_S+XttQ2Ygo.WYlEG--
