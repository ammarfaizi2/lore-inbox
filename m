Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293276AbSCVIm3>; Fri, 22 Mar 2002 03:42:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310258AbSCVImU>; Fri, 22 Mar 2002 03:42:20 -0500
Received: from dialin-145-254-149-022.arcor-ip.net ([145.254.149.22]:19438
	"HELO schottelius.org") by vger.kernel.org with SMTP
	id <S293276AbSCVImD>; Fri, 22 Mar 2002 03:42:03 -0500
Date: Thu, 21 Mar 2002 22:00:10 +0000
From: Nico Schottelius <nicos-mutt@pcsystems.de>
To: ecd@skynet.be, brad@neruo.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: atyfb makes the screen black
Message-ID: <20020321220010.GA15951@schottelius.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-MSMail-Priority: Is not really needed
X-Mailer: Yam on Linux ?
X-Operating-System: Linux flapp 2.5.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!=20

I tried to get a nice fbdev running with my card, but when I load aty_fb
from kernel 2.4.17 or 2.5.6 it just makes my screen black and forces me to
reboot so I can see anything again.
It looks like it is supported in aty/atyfb_base.c, but=20
Q: Is my card supported ?
Q: Will it ever be supported ?

Here's my lspci output, so you can see what I use...

01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage P/M Mobilit=
y AGP        Subsystem: Acer Incorporated [ALI]: Unknown device 1010
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Step        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAb=
ort- <TAbort        Latency: 32 (2000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at 81000000 (32-bit, non-prefetchable) [size=3D16M]
        Region 1: I/O ports at 8000 [size=3D256]
        Region 2: Memory at 80600000 (32-bit, non-prefetchable) [size=3D4K]
        Expansion ROM at 80620000 [disabled] [size=3D128K]
        Capabilities: [50] AGP version 1.0
                Status: RQ=3D255 SBA+ 64bit- FW- Rate=3Dx1,x2
                Command: RQ=3D0 SBA- AGP- 64bit- FW- Rate=3D<none>
        Capabilities: [5c] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1-,D2=
-,D3hot                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-



Thanks in advance!

Nico

p.s.: hopefully i hit the maintainer (who is not in the MAINTAINERS file)
with this mail...

--=20
Nico Schottelius

Please send your messages pgp-signed or pgp-encrypted.
If you don't know what pgp is visit www.gnupg.org.
(public pgp key: ftp.schottelius.org/pub/familiy/nico/pgp-key)

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Weitere Infos: siehe http://www.gnupg.org

iD8DBQE8mlfptnlUggLJsX0RAos+AJ4oL113FnPN5ELsxhbSDhwoq95B6QCeOL2D
rE+t8z8H8Oxqh9BdmsukIKE=
=ja/D
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
