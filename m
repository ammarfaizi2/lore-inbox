Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131899AbRDCO1I>; Tue, 3 Apr 2001 10:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131942AbRDCO05>; Tue, 3 Apr 2001 10:26:57 -0400
Received: from mx1out.umbc.edu ([130.85.253.51]:36332 "EHLO mx1out.umbc.edu")
	by vger.kernel.org with ESMTP id <S131899AbRDCO0u> convert rfc822-to-8bit;
	Tue, 3 Apr 2001 10:26:50 -0400
Date: Tue, 3 Apr 2001 10:26:06 -0400
From: John Jasen <jjasen1@umbc.edu>
X-X-Sender: <jjasen1@irix2.gl.umbc.edu>
To: =?iso-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
cc: <andre@linux-ide.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Bugreport: Kernel 2.4.x crash
In-Reply-To: <20010403145219.A15009@wohnheim.fh-wedel.de>
Message-ID: <Pine.SGI.4.31L.02.0104031023470.2331583-100000@irix2.gl.umbc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Apr 2001, [iso-8859-1] Jörn Engel wrote:

I don't necessarily believe its the hpt366, as you do. See below: (note:
I've also had it running on a stock 2.4.2 kernel for a while)

> 00:08.0 Unknown mass storage controller: Triones Technologies, Inc. HPT366
> (rev 01)
>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 248 (2000ns min, 2000ns max), cache line size 08
>         Interrupt: pin A routed to IRQ 11
>         Region 0: I/O ports at 6100
>         Region 1: I/O ports at 6200
>         Region 4: I/O ports at 6300
>
> 00:08.1 Unknown mass storage controller: Triones Technologies, Inc. HPT366
> (rev 01)
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 248 (2000ns min, 2000ns max), cache line size 08
>         Interrupt: pin A routed to IRQ 11
>         Region 0: I/O ports at 6400
>         Region 1: I/O ports at 6500
>         Region 4: I/O ports at 6600

00:13.0 Unknown mass storage controller: Triones Technologies, Inc. HPT366
(rev
01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Step
ping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort
- <MAbort- >SERR- <PERR-
        Latency: 8 min, 8 max, 120 set, cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at ac00 [size=8]
        Region 1: I/O ports at b000 [size=4]
        Region 4: I/O ports at b400 [size=256]
        Expansion ROM at ea000000 [disabled] [size=128K]

00:13.1 Unknown mass storage controller: Triones Technologies, Inc. HPT366
(rev
01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Step
ping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort
- <MAbort- >SERR- <PERR-
        Latency: 8 min, 8 max, 120 set, cache line size 08
        Interrupt: pin B routed to IRQ 10
        Region 0: I/O ports at b800 [size=8]
        Region 1: I/O ports at bc00 [size=4]
        Region 4: I/O ports at c000 [size=256]

[root@geisha /root]# uptime
 10:25am  up 8 days, 21:17,  9 users,  load average: 0.00, 0.00, 0.00
[root@geisha /root]# uname -a
Linux geisha 2.4.2-ac20 #6 SMP Sat Mar 24 23:40:02 EST 2001 i686 unknown

--
-- John E. Jasen (jjasen1@umbc.edu)
-- In theory, theory and practise are the same. In practise, they aren't.

