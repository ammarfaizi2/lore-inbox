Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130577AbRCPPuB>; Fri, 16 Mar 2001 10:50:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130600AbRCPPtv>; Fri, 16 Mar 2001 10:49:51 -0500
Received: from [212.6.145.2] ([212.6.145.2]:1555 "HELO heaven.astaro.de")
	by vger.kernel.org with SMTP id <S130577AbRCPPtp>;
	Fri, 16 Mar 2001 10:49:45 -0500
Date: Fri, 16 Mar 2001 16:46:15 -0800
From: Daniel Stutz <dstutz@astaro.de>
To: linux-kernel@vger.kernel.org
Subject: APM and cs4281 sound module
Message-ID: <20010316164615.B581@mukmin.astaro.de>
Reply-To: Daniel.Stutz@astaro.de
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="NDin8bjvE/0mNLFQ"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Astaro AG
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--NDin8bjvE/0mNLFQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

as I posted here ~2 weeks ago my system locks when going to suspend mode.

Now I was able to locate the problem in the sound module. (More information
at EOF)

When I make a 'rmmod cs4281' suspend and resume works very well.

System hangs only when suspending with loaded sound module.

Kernel is 2.4.2-ac20

lspci -vv

00:08.0 Multimedia audio controller: Cirrus Logic Crystal CS4281 PCI Audio
(rev 01)
        Subsystem: Citicorp TTI Crystal CS4281 PCI Audio
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (1000ns min, 6000ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at fc101000 (32-bit, non-prefetchable) [size=3D4K]
        Region 1: Memory at fc110000 (32-bit, non-prefetchable) [size=3D64K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=3D0mA
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME+


--=20
--
In God we Trust, all others please submit signed PGP/X.509 key
Daniel Stutz <Daniel.Stutz@astaro.de>    | Product Development
Astaro AG | http://www.astaro.de  | +49-721-490069-0 | Fax -55

--NDin8bjvE/0mNLFQ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1e-SuSE (GNU/Linux)
Comment: For info see http://www.gnupg.org

iQEXAwUBOrKz10vYZOFi63MrFAOFdwQAijdkdKeYiTSoNqKD6HD7z2wM5WY8E6QV
T3pA8bsI+hmFmTyXTIj13hx4ST+oiyOvJzCZMbFPfn1im4YMoqGQ+3WmvF3EF8ks
kRlyCDMk4B0+t9EswfjIH7RH4d3eSCBs+VNXGo57//F2uHFwXv8QIlPImCfjiCLr
sbECOWJlu78D/jW64s2wb0lwuldZXGXE1NaK6+7UccnhPzkd4hzFebW0ZaHQk+fK
Lq2yjhoTzZI5fhtkc9c0IqGQc4JCBG42nG8HBRCd59E0wF02Id52FdTrt2EdYDvP
bjfsRBRifhWFoee1Jne0h1cj9LaPgxpbSUCZxyVUt7a9ZkJkElmAs4S7
=iJkS
-----END PGP SIGNATURE-----

--NDin8bjvE/0mNLFQ--
