Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291041AbSBLNhb>; Tue, 12 Feb 2002 08:37:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291042AbSBLNhN>; Tue, 12 Feb 2002 08:37:13 -0500
Received: from unicef.org.yu ([194.247.200.148]:1294 "EHLO unicef.org.yu")
	by vger.kernel.org with ESMTP id <S291041AbSBLNhE>;
	Tue, 12 Feb 2002 08:37:04 -0500
Date: Tue, 12 Feb 2002 14:36:56 +0100 (CET)
From: Davidovac Zoran <zdavid@unicef.org.yu>
To: Martin Josefsson <gandalf@wlug.westbo.se>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Question about i820 chipset.
In-Reply-To: <Pine.LNX.4.21.0202121345430.20359-100000@tux.rsn.bth.se>
Message-ID: <Pine.LNX.4.33.0202121435010.7616-100000@unicef.org.yu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> Using an UP kernel with IO-APIC support and MPS 1.4 they don't share irqs:

try without IO-APIC support is it still the same ?

Z
>
>            CPU0
>   0:   66083638    IO-APIC-edge  timer
>   1:        828    IO-APIC-edge  keyboard
>   2:          0          XT-PIC  cascade
>   4:          3    IO-APIC-edge  serial
>   8:          0    IO-APIC-edge  rtc
>  14:      17840    IO-APIC-edge  ide0
>  16:         14   IO-APIC-level  eth2
>  17:         12   IO-APIC-level  eth3
>  18:      20790   IO-APIC-level  eth0
>  19:         39   IO-APIC-level  eth1
> NMI:   66083576
> LOC:   66081746
> ERR:          0
> MIS:          0
>
> I've tried changing slots aswell and I havn't seen any improvments with
> either MPS 1.1 or 1.4
>
> /Martin
>
> Never argue with an idiot. They drag you down to their level, then beat you with experience.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

