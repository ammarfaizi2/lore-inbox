Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261498AbULFLSk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbULFLSk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 06:18:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261496AbULFLSk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 06:18:40 -0500
Received: from 13.2-host.augustakom.net ([80.81.2.13]:41660 "EHLO phoebee.mail")
	by vger.kernel.org with ESMTP id S261498AbULFLQM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 06:16:12 -0500
Date: Mon, 6 Dec 2004 12:16:08 +0100
From: Martin Zwickel <martin.zwickel@technotrend.de>
To: "Riley Williams" <riley_howard_williams@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: nVidea Graphics card not recognised by lspci
Message-ID: <20041206121608.585d7526@phoebee>
In-Reply-To: <BAY101-F22378AB0D9016021445311ABB40@phx.gbl>
References: <kiiZIHd0T0000153f@hotmail.com>
	<BAY101-F22378AB0D9016021445311ABB40@phx.gbl>
X-Mailer: Sylpheed-Claws 0.9.12cvs53 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Linux Phoebee 2.6.7-rc2-mm2 i686 Intel(R) Pentium(R) 4
 CPU 2.40GHz
X-Face: $rTNP}#i,cVI9h"0NVvD.}[fsnGqI%3=N'~,}hzs<FnWK/T]rvIb6hyiSGL[L8S,Fj`u1t.
 ?J0GVZ4&
Organization: Technotrend AG
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Mon__6_Dec_2004_12_16_08_+0100_EMonHeytyI=nQNQP"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Mon__6_Dec_2004_12_16_08_+0100_EMonHeytyI=nQNQP
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Mon, 06 Dec 2004 10:44:16 +0000
"Riley Williams" <riley_howard_williams@hotmail.com> bubbled:

> Hi all.
> 
> The enclosed is the output from `lspci -vvv` for the video card on one
> of my systems. Can anybody tell me any more about this card, as
> "Unknown device 0322" isn't too useful a description.

Your lspci database is too old.

Your card should be (taken from pci.ids):
    0322  NV34 [GeForce FX 5200]


> 
> If any further information is required, please tell me where to find
> it and I will report it here.
> 
> Best wishes from Riley.
> 
> *********************************************************************
> ********
> 
> 01:00.0 VGA compatible controller: nVidia Corporation: Unknown device
> 0322 (rev a1) (prog-if 00 [VGA])
> Subsystem: Unknown device 1682:203c
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
> Stepping- SERR- FastB2B-
> Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
> Latency: 64 (1250ns min, 250ns max)
> Interrupt: pin A routed to IRQ 11
> Region 0: Memory at d1000000 (32-bit, non-prefetchable) [size=16M]
> Region 1: Memory at e0000000 (32-bit, prefetchable) [size=256M]
> Expansion ROM at <unassigned> [disabled] [size=128K]
> Capabilities: [60] Power Management version 2
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-) Status: D0 PME-Enable- DSel=0 DScale=0
> PME- Capabilities: [44] AGP version 3.0
> Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2,x4
> Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


-- 
MyExcuse:
Domain controller not responding

Martin Zwickel <martin.zwickel@technotrend.de>
Research & Development

TechnoTrend AG <http://www.technotrend.de>

--Signature=_Mon__6_Dec_2004_12_16_08_+0100_EMonHeytyI=nQNQP
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBtD97mjLYGS7fcG0RApdpAKCFywru/BBQ/bjeznXXoPmhdTiBBgCdHEw/
IHzgFf0BkGJ2gqPEwIuI71E=
=lkyl
-----END PGP SIGNATURE-----

--Signature=_Mon__6_Dec_2004_12_16_08_+0100_EMonHeytyI=nQNQP--
