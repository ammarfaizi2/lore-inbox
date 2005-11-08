Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965208AbVKHRLI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965208AbVKHRLI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 12:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965236AbVKHRLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 12:11:08 -0500
Received: from ns.snowman.net ([66.92.160.21]:1487 "EHLO ns.snowman.net")
	by vger.kernel.org with ESMTP id S965208AbVKHRLF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 12:11:05 -0500
Date: Tue, 8 Nov 2005 12:11:41 -0500
From: Stephen Frost <sfrost@snowman.net>
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NVidia nForce4 + AMD Athlon64 X2 --> no access to north-bridge PCI resources
Message-ID: <20051108171141.GN6026@ns.snowman.net>
Mail-Followup-To: Matti Aarnio <matti.aarnio@zmailer.org>,
	linux-kernel@vger.kernel.org
References: <20051107225755.GE5706@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VkHpN0AwuqNaTa40"
Content-Disposition: inline
In-Reply-To: <20051107225755.GE5706@mea-ext.zmailer.org>
X-Editor: Vim http://www.vim.org/
X-Info: http://www.snowman.net
X-Operating-System: Linux/2.4.24ns.3.0 (i686)
X-Uptime: 09:12:31 up 150 days,  6:26,  2 users,  load average: 0.09, 0.10, 0.09
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VkHpN0AwuqNaTa40
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Matti Aarnio (matti.aarnio@zmailer.org) wrote:
> The _very_short_ view of  lspci  output on a problem machine:

You might want to provide the kernel version.

sfrost@snowman:/home/sfrost> uname -a        =20
Linux snowman 2.6.12-1-amd64-k8-smp #1 SMP Fri Sep 23 13:03:18 CEST 2005 x8=
6_64 GNU/Linux

sfrost@snowman:/home/sfrost> lspci           =20
0000:00:00.0 Memory controller: nVidia Corporation CK804 Memory Controller =
(rev a3)
0000:00:01.0 ISA bridge: nVidia Corporation CK804 ISA Bridge (rev a3)
0000:00:01.1 SMBus: nVidia Corporation CK804 SMBus (rev a2)
0000:00:02.0 USB Controller: nVidia Corporation CK804 USB Controller (rev a=
2)
0000:00:02.1 USB Controller: nVidia Corporation CK804 USB Controller (rev a=
3)
0000:00:04.0 Multimedia audio controller: nVidia Corporation CK804 AC'97 Au=
dio Controller (rev a2)
0000:00:06.0 IDE interface: nVidia Corporation CK804 IDE (rev f2)
0000:00:07.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller =
(rev f3)
0000:00:08.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller =
(rev f3)
0000:00:09.0 PCI bridge: nVidia Corporation CK804 PCI Bridge (rev a2)
0000:00:0a.0 Bridge: nVidia Corporation CK804 Ethernet Controller (rev a3)
0000:00:0b.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
0000:00:0c.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
0000:00:0d.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
0000:00:0e.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron=
] HyperTransport Technology Configuration
0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron=
] Address Map
0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron=
] DRAM Controller
0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron=
] Miscellaneous Control
0000:01:00.0 VGA compatible controller: nVidia Corporation NV40 [GeForce 68=
00 Ultra/GeForce 6800 GT] (rev a2)
0000:05:07.0 Multimedia audio controller: Creative Labs SB Audigy (rev 04)
0000:05:07.1 Input device controller: Creative Labs SB Audigy MIDI/Game por=
t (rev 04)
0000:05:07.2 FireWire (IEEE 1394): Creative Labs SB Audigy FireWire Port (r=
ev 04)
0000:05:0b.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A IEEE-1394a=
-2000 Controller (PHY/Link)
0000:05:0c.0 Ethernet controller: Marvell Technology Group Ltd. 88E8001 Gig=
abit Ethernet Controller (rev 13)

sfrost@snowman:/home/sfrost> cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 35
model name      : AMD Athlon(tm) 64 X2 Dual Core Processor 4400+
stepping        : 2
cpu MHz         : 2211.375
cache size      : 1024 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 2
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca =
cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt lm 3=
dnowext 3dnow pni lahf_lm cmp_legacy
bogomips        : 4374.52
TLB size        : 1024 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 35
model name      : AMD Athlon(tm) 64 X2 Dual Core Processor 4400+
stepping        : 2
cpu MHz         : 2211.375
cache size      : 1024 KB
physical id     : 0
siblings        : 2
core id         : 1
cpu cores       : 2
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca =
cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt lm 3=
dnowext 3dnow pni lahf_lm cmp_legacy
bogomips        : 4407.29
TLB size        : 1024 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp

However, it seems things changed under 2.6.14...

sfrost@snowman:/home/sfrost> uname -a
Linux snowman 2.6.14-1-amd64-k8-smp #1 SMP Wed Nov 2 20:53:55 CET 2005 x86_=
64 GNU/Linux
sfrost@snowman:/home/sfrost> lspci
0000:00:00.0 Memory controller: nVidia Corporation CK804 Memory Controller =
(rev a3)
0000:00:01.0 ISA bridge: nVidia Corporation CK804 ISA Bridge (rev a3)
0000:00:01.1 SMBus: nVidia Corporation CK804 SMBus (rev a2)
0000:00:02.0 USB Controller: nVidia Corporation CK804 USB Controller (rev a=
2)
0000:00:02.1 USB Controller: nVidia Corporation CK804 USB Controller (rev a=
3)
0000:00:04.0 Multimedia audio controller: nVidia Corporation CK804 AC'97 Au=
dio Controller (rev a2)
0000:00:06.0 IDE interface: nVidia Corporation CK804 IDE (rev f2)
0000:00:07.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller =
(rev f3)
0000:00:08.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller =
(rev f3)
0000:00:09.0 PCI bridge: nVidia Corporation CK804 PCI Bridge (rev a2)
0000:00:0a.0 Bridge: nVidia Corporation CK804 Ethernet Controller (rev a3)
0000:00:0b.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
0000:00:0c.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
0000:00:0d.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
0000:00:0e.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
0000:01:00.0 VGA compatible controller: nVidia Corporation NV40 [GeForce 68=
00 Ultra/GeForce 6800 GT] (rev a2)
0000:05:07.0 Multimedia audio controller: Creative Labs SB Audigy (rev 04)
0000:05:07.1 Input device controller: Creative Labs SB Audigy MIDI/Game por=
t (rev 04)
0000:05:07.2 FireWire (IEEE 1394): Creative Labs SB Audigy FireWire Port (r=
ev 04)
0000:05:0b.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A IEEE-1394a=
-2000 Controller (PHY/Link)
0000:05:0c.0 Ethernet controller: Marvell Technology Group Ltd. 88E8001 Gig=
abit Ethernet Controller (rev 13)

sfrost@snowman:/home/sfrost> cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 35
model name      : AMD Athlon(tm) 64 X2 Dual Core Processor 4400+
stepping        : 2
cpu MHz         : 2211.382
cache size      : 1024 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 2
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca =
cmov pat pse36 clflush mm x fxsr sse sse2 ht syscall nx mmxext fxsr_opt lm =
3dnowext 3dnow pni lahf_lm cmp_legacy
bogomips        : 4425.45
TLB size        : 1024 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 35
model name      : AMD Athlon(tm) 64 X2 Dual Core Processor 4400+
stepping        : 2
cpu MHz         : 2211.382
cache size      : 1024 KB
physical id     : 0
siblings        : 2
core id         : 1
cpu cores       : 2
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca =
cmov pat pse36 clflush mm x fxsr sse sse2 ht syscall nx mmxext fxsr_opt lm =
3dnowext 3dnow pni lahf_lm cmp_legacy
bogomips        : 4422.04
TLB size        : 1024 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp

Enjoy..

	Stephen

--VkHpN0AwuqNaTa40
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDcNxNrzgMPqB3kigRAvH7AJsHpcPxaXiIV316iYRLKBz6RlLFlACeOPwb
v9wi4IB7LKpTjCQgJgisPuw=
=d7pZ
-----END PGP SIGNATURE-----

--VkHpN0AwuqNaTa40--
