Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319244AbSHNQkt>; Wed, 14 Aug 2002 12:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319245AbSHNQkp>; Wed, 14 Aug 2002 12:40:45 -0400
Received: from pa147.antoniuk.sdi.tpnet.pl ([213.25.59.147]:34550 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S319244AbSHNQkm>; Wed, 14 Aug 2002 12:40:42 -0400
Date: Wed, 14 Aug 2002 18:46:40 +0200
From: Jacek =?iso-8859-2?Q?Pop=B3awski?= <jpopl@interia.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jacek =?iso-8859-2?Q?Pop=B3awski?= <jpopl@interia.pl>,
       linux-kernel@vger.kernel.org
Subject: Re: can't use 2.4 on my 486 server
Message-ID: <20020814164640.GA966@darkwood.localdomain>
References: <20020814103544.GA1018@darkwood.localdomain> <1029326492.26226.3.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <1029326492.26226.3.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2002 at 01:01:32PM +0100, Alan Cox wrote:
> Two things to check first:  The memory (we've seen 2.4 find bad ram bugs
> 2.2 did not) and also that its getting the memory size right. 2.4 uses
> E820 then E801 memory sizing, older 2.2 (< 2.2.18 or so) didnt do this.
> So far I only know of one box that gets memory size wrong just with
> E820.

I haven't checked RAM with memtest, yet.

There is 16MB of RAM there. 

jp@darkstar:~$ cat /proc/meminfo 
        total:    used:    free:  shared: buffers:  cached:
Mem:  14778368 14372864   405504 10383360   372736  3284992
Swap: 21639168   196608 21442560
MemTotal:     14432 kB
MemFree:        396 kB
MemShared:    10140 kB
Buffers:        364 kB
Cached:        3208 kB
SwapTotal:    21132 kB
SwapFree:     20940 kB

(this is 2.2.19 raport)

> Finally what is plugged into it ?

This is Dell computer with video card on motherboard, without PCI slots.
There is one hard disk:

hda: ST3630A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: ST3630A, 601MB w/120kB Cache, CHS=1223/16/63

and one Ethernet:
eth0: 3c509 at 0x300 tag 1, 10baseT port, address  00 20 af 1b 91 55, IRQ 10.

There is also ppp connection by serial port (ericsson terminal called HIS).

No soundcard, no floppy, no other network devices.

-- 
http://decopter.sf.net - free unrealistic helicopter simulator
