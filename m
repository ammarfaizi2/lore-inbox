Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129649AbQKGOHr>; Tue, 7 Nov 2000 09:07:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129666AbQKGOHh>; Tue, 7 Nov 2000 09:07:37 -0500
Received: from enterprise.cistron.net ([195.64.68.33]:34574 "EHLO
	enterprise.cistron.net") by vger.kernel.org with ESMTP
	id <S129649AbQKGOHZ>; Tue, 7 Nov 2000 09:07:25 -0500
From: reneb@orac.aais.nl (Rene Blokland)
Subject: Re: PCI oddness with Ali 1541 chipset
Date: Tue, 7 Nov 2000 14:44:39 +0100
Organization: Cistron Internet Services B.V.
Message-ID: <slrn90g1q7.c3.reneb@orac.aais.nl>
In-Reply-To: <20001107012205.M12348@arthur.ubicom.tudelft.nl>
Reply-To: reneb@cistron.nl
X-Trace: enterprise.cistron.net 973606045 8705 62.216.0.161 (7 Nov 2000 14:07:25 GMT)
X-Complaints-To: abuse@cistron.nl
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  Tue, 7 Nov 2000 01:22:06 +0100, Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL> wrote:
>
>Hi,
>
>I'm running 2.4.0-test10 on my desktop machine. The system works
>perfectly well, but I get some strange PCI messages at boot time. Here
>is part it:
I've the same motherboard
part of my syslog:
 orac kernel: ALI15X3: IDE controller on PCI bus 00 dev 78
 orac kernel: PCI: No IRQ known for interrupt pin A of device 00:0f.0.
 orac kernel: ALI15X3: chipset revision 193
 orac kernel: ALI15X3: not 100% native mode: will probe irqs later
But  then:
orac kernel: trident: unable to allocate irq 0
orac modprobe: modprobe: Can't locate module sound-slot-0
orac modprobe: modprobe: Can't locate module sound-service-0-0
amd there isn't any sound anymore!!
It was a nice working Trident Microsystems 4DWave DX (rev 01)
in pre-10
-
Groeten / Regards, Rene Blokland                                    -o)
1073KA 13ii the Netherlands                                         /\\
Microsoft - "Creative non-fulfilment of your lowest expectations"  _\_v
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
