Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316569AbSFUL3Y>; Fri, 21 Jun 2002 07:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316571AbSFUL3X>; Fri, 21 Jun 2002 07:29:23 -0400
Received: from line103-203.adsl.actcom.co.il ([192.117.103.203]:42247 "HELO
	alhambra.merseine.nu") by vger.kernel.org with SMTP
	id <S316569AbSFUL3W>; Fri, 21 Jun 2002 07:29:22 -0400
Date: Fri, 21 Jun 2002 14:25:13 +0300
From: Muli Ben-Yehuda <mulix@actcom.co.il>
To: cling-li@ali.com.tw, matt_wu@acersoftech.com.cn
Cc: linux-kernel@vger.kernel.org
Subject: thinkpad R-30 Ali M5451 lockdown
Message-ID: <20020621142513.E7006@alhambra.actcom.co.il>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="TD8GDToEDw0WLGOL"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TD8GDToEDw0WLGOL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Occasionally the ALI M5451 driver (trident.c) would lock down my IBM
thinkpad R30. The console would continously flash the message:=20

ali: AC97 CODEC read timed out.

And the machine wouldn't respond to the keyboard or ssh. I'm trying to
reproduce and debug it now. Has anyone else run accross it? google has
been less than helpful.=20

relevant lspci -vv output:=20

00:06.0 Multimedia audio controller: Acer Laboratories Inc. [ALi] M5451 PCI=
 AC-Link Controller Audio Device (rev 01)
        Subsystem: IBM: Unknown device 0506
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR+ <PERR+
        Latency: 32 (500ns min, 6000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at 9400 [size=3D256]
        Region 1: Memory at 81c00000 (32-bit, non-prefetchable) [size=3D4K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1-,D2=
+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
--=20
http://vipe.technion.ac.il/~mulix/
http://syscalltrack.sf.net/

--TD8GDToEDw0WLGOL
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9Ew0YKRs727/VN8sRArL8AKCvmdzfxoqaazSNsT85ftF+cAHg2gCfTV5z
sb4iVNGvyzFyxlvupsTQdLA=
=3VYx
-----END PGP SIGNATURE-----

--TD8GDToEDw0WLGOL--
