Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129280AbRBEWJL>; Mon, 5 Feb 2001 17:09:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129516AbRBEWJB>; Mon, 5 Feb 2001 17:09:01 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:38162 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S129280AbRBEWIl>; Mon, 5 Feb 2001 17:08:41 -0500
Message-ID: <3A7F245E.16899A08@Hell.WH8.TU-Dresden.De>
Date: Mon, 05 Feb 2001 23:08:30 +0100
From: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>
Organization: Dept. Of Computer Science, Dresden University Of Technology
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-ac2 i686)
X-Accept-Language: en, de-DE
MIME-Version: 1.0
To: Peter Horton <pdh@colonel-panic.com>, linux-kernel@vger.kernel.org
Subject: Re: VIA silent disk corruption - bad news
In-Reply-To: <20010205195331.A736@colonel-panic.com> <3A7F230A.BB1CBA25@Hell.WH8.TU-Dresden.De>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Udo A. Steinberg" wrote:
> 
> FWIW, here's the output of my lspci for A7V with working 1003 BIOS
> and still no corruption (after 2 hours stresstest).

Bugger, forgot the end bit. Here's it again:

00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0305 (rev 02)
        Subsystem: Asustek Computer, Inc.: Unknown device 8033
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
        Latency: 0
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 05 03 06 00 10 a2 02 00 00 06 00 00 00 00
10: 08 00 00 e0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 33 80
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 17 a4 eb b4 06 81 10 10 88 00 04 08 0c 10 10 10
60: 0f ff 0f b0 e6 e6 e5 00 40 78 86 0f 08 7f 00 00
70: de c0 cc 0c 0e a1 d2 00 01 b4 11 02 00 00 00 01
80: 0f 40 00 00 80 00 00 00 03 00 4c 01 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 02 c0 20 00 17 02 00 1f 00 00 00 00 6a 02 14 00
b0: 5a ec 80 a5 32 33 28 00 00 00 00 00 00 00 00 00
c0: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 0e 22 00 00 00 00 00 91 06    

-Udo.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
