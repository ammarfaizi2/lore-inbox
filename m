Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263777AbUBKI4P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 03:56:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263787AbUBKI4P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 03:56:15 -0500
Received: from ns0.eris.qinetiq.com ([128.98.1.1]:42329 "HELO
	mail.eris.qinetiq.com") by vger.kernel.org with SMTP
	id S263777AbUBKI4N convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 03:56:13 -0500
From: Mark Watts <m.watts@eris.qinetiq.com>
Organization: QinetiQ
To: Dan Hopper <ku4nf@austin.rr.com>, linux-kernel@vger.kernel.org
Subject: Re: Promise PDC20378 PATA support?
Date: Wed, 11 Feb 2004 08:50:40 +0000
User-Agent: KMail/1.5.3
References: <20040207071023.GA2304@yoda.dummynet>
In-Reply-To: <20040207071023.GA2304@yoda.dummynet>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200402110850.40689.m.watts@eris.qinetiq.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


> Hi,
>
> Has anyone had any luck getting PATA working on Promise PDC20378

I lied - I have the PDC20376 not the 8 varient.

00:0d.0 RAID bus controller: Promise Technology, Inc. PDC20376 (rev 02)
        Subsystem: Promise Technology, Inc.: Unknown device 6620
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 96 (1000ns min, 4500ns max), cache line size 08
        Interrupt: pin A routed to IRQ 19
        Region 0: I/O ports at cc00 [size=64]
        Region 1: I/O ports at c800 [size=16]
        Region 2: I/O ports at c400 [size=128]
        Region 3: Memory at dfffd000 (32-bit, non-prefetchable) [size=4K]
        Region 4: Memory at dffc0000 (32-bit, non-prefetchable) [size=128K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-


During boot I see the following:

PROMISE SATA150 Series Linux Driver v1.00.0.10
pdc-ultra:[info] Drive 5: MAXTOR 6L020J1          40132502s  20548MB  UDMA6
scsi0 : pdc-ultra
  Vendor:           Model: MAXTOR 6L020J1    Rev:
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi disk sda at scsi0, channel 0, id 4, lun 0
SCSI device sda: 40132503 512-byte hdwr sectors (20548 MB)
 /dev/scsi/host0/bus0/target4/lun0: p1

Drive is a 20Gig Maxtor PATA device.

Cheers,

Mark.

- -- 
Mark Watts
Senior Systems Engineer
QinetiQ TIM
St Andrews Road, Malvern
GPG Public Key ID: 455420ED

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAKezgBn4EFUVUIO0RAr/vAKDICBtq9KoZ5ra/zRyKQnN3HU+mXACg094k
89yDB5lyez3+4WsAA3PWxFY=
=z3Gi
-----END PGP SIGNATURE-----

