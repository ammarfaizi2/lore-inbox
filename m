Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129478AbQJZQWB>; Thu, 26 Oct 2000 12:22:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129472AbQJZQVv>; Thu, 26 Oct 2000 12:21:51 -0400
Received: from proxy.ovh.net ([213.244.20.42]:61965 "HELO proxy.ovh.net")
	by vger.kernel.org with SMTP id <S129192AbQJZQVn>;
	Thu, 26 Oct 2000 12:21:43 -0400
Message-ID: <39F85A09.DA88452F@ovh.net>
Date: Thu, 26 Oct 2000 18:21:29 +0200
From: octave klaba <oles@ovh.net>
X-Mailer: Mozilla 4.73 [en] (Win98; I)
X-Accept-Language: fr,en
MIME-Version: 1.0
To: profmakx@profmakx.de
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-net@vger.kernel.org
Subject: Re: VM-global-2.2.18pre17-7
In-Reply-To: <Pine.LNX.4.21.0010251633080.3324-100000@freak.distro.conectiva> <39F84B64.5935C12@ovh.net> <39F8566D.51561CB3@profmakx.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> > Oct 26 16:38:01 ns29 kernel: eth0: card reports no resources.
> let me guess: intel eepro100 or similar??
yeap

00:02.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 08)
        Subsystem: Asustek Computer, Inc.: Unknown device 1043
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 8 min, 56 max, 64 set, cache line size 08
        Interrupt: pin A routed to IRQ 20
        Region 0: Memory at fd000000 (32-bit, non-prefetchable)
        Region 1: I/O ports at d800
        Region 2: Memory at fc800000 (32-bit, non-prefetchable)
        Capabilities: <available only to root>

> Well known problem with that one. dont know if its fully fixed ... With
> 2.4.0-test9-pre3 it doesnt happen on my machine ...
we have 1-2 servers running 2.4.0-test9 and we got this error ...

is there any patch to 2.2.18pre ? since the server has to run on sunday
we can still make the crazy tests 3 days. it would be cool to fix it to 
2.2.X if the bug is known ;)

octave


-- 
Amicalement,
oCtAvE 

"Peu importe ce qu'il y a de l'autre côté.
Tout ce qu'on laisse ici n'est qu'une histoire
dont on se souviendra ou pas."
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
