Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264517AbTIITlV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 15:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264520AbTIITlU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 15:41:20 -0400
Received: from kiuru.kpnet.fi ([193.184.122.21]:21174 "EHLO kiuru.kpnet.fi")
	by vger.kernel.org with ESMTP id S264517AbTIITlE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 15:41:04 -0400
Subject: Re: Nforce2
From: Markus =?ISO-8859-1?Q?H=E4stbacka?= <midian@ihme.org>
To: Alistair J Strachan <alistair@devzero.co.uk>
Cc: Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <200309091801.17024.alistair@devzero.co.uk>
References: <1063114472.589.4.camel@midux>
	 <200309091801.17024.alistair@devzero.co.uk>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-SU9sr0rUUuLm1vhLn+Je"
Message-Id: <1063136426.3406.7.camel@midux>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 09 Sep 2003 22:40:26 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-SU9sr0rUUuLm1vhLn+Je
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

Hello Alistair,

I've tested everything, I think. It just can't use AGP 4x. I tryed with
NvAGP 1 and 3. Here's the output in /var/log/XFree86.0.log:
[...snip...]
(**) NVIDIA(0): Option "NvAGP" "3"
(**) NVIDIA(0): Use of any AGP requested (try AGPGART, then try NVIDIA's
AGP)
[...snip...]
(WW) NVIDIA(0): Failed to verify AGP usage
[...snip...]
And I just noticed that 2.4 is not telling me the truth. The agp isn't
enbaled there either. I don't know anything to do anymore.
Looks like linux totally lacks support for my Mobo. *sigh*.

midian@midux:~$ uname -r
2.6.0-test5-mm1

NVRM version: NVIDIA Linux x86 nvidia.o Kernel Module  1.0-4496  Wed Jul
16 19:03:09 PDT 2003
GCC version:  gcc version 3.3.2 20030831 (Debian prerelease)

midian@midux:~$ cat /proc/driver/nvidia/agp/status
Status:          Disabled

midian@midux:~$ lspci
00:00.0 Host bridge: nVidia Corporation: Unknown device 01e0 (rev c1)
00:00.1 RAM memory: nVidia Corporation: Unknown device 01eb (rev c1)
00:00.2 RAM memory: nVidia Corporation: Unknown device 01ee (rev c1)
00:00.3 RAM memory: nVidia Corporation: Unknown device 01ed (rev c1)
00:00.4 RAM memory: nVidia Corporation: Unknown device 01ec (rev c1)
00:00.5 RAM memory: nVidia Corporation: Unknown device 01ef (rev c1)
00:01.0 ISA bridge: nVidia Corporation nForce2 ISA Bridge (rev a4)
00:01.1 SMBus: nVidia Corporation nForce2 SMBus (MCP) (rev a2)
00:02.0 USB Controller: nVidia Corporation nForce2 USB Controller (rev
a4)
00:02.1 USB Controller: nVidia Corporation nForce2 USB Controller (rev
a4)
00:02.2 USB Controller: nVidia Corporation nForce2 USB Controller (rev
a4)
00:04.0 Ethernet controller: nVidia Corporation nForce2 Ethernet
Controller (rev a1)
00:08.0 PCI bridge: nVidia Corporation: Unknown device 006c (rev a3)
00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2)
00:1e.0 PCI bridge: nVidia Corporation nForce2 AGP (rev c1)
01:06.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev
07)
01:06.1 Input device controller: Creative Labs SB Live! MIDI/Game Port
(rev 07)
01:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
01:0d.0 FireWire (IEEE 1394): Lucent Microelectronics FW323 (rev 61)
02:00.0 VGA compatible controller: nVidia Corporation NV17 [GeForce4 MX
440] (rev a3)

Thanks.
--=20
----
Markus H=E4stbacka <midian@ihme.org>

--=-SU9sr0rUUuLm1vhLn+Je
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/Xiyp3+NhIWS1JHARAhskAJ98jU/K/2ofcr96F5jf95EmH8XCGwCg7Tw6
D/QLIw1XM9nmu6u1hdQLT0A=
=P2El
-----END PGP SIGNATURE-----

--=-SU9sr0rUUuLm1vhLn+Je--

