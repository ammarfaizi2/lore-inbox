Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280095AbRKVRQt>; Thu, 22 Nov 2001 12:16:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280114AbRKVRQe>; Thu, 22 Nov 2001 12:16:34 -0500
Received: from [212.18.232.186] ([212.18.232.186]:25617 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S280095AbRKVRPu>; Thu, 22 Nov 2001 12:15:50 -0500
Date: Thu, 22 Nov 2001 17:15:32 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Ishak Hartono <lotus@upnaway.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: anyone got the same problem with DIGITAL 21143 network card ?
Message-ID: <20011122171531.A18181@flint.arm.linux.org.uk>
In-Reply-To: <001201c1735c$9ac546d0$0b01a8c0@lotus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <001201c1735c$9ac546d0$0b01a8c0@lotus>; from lotus@upnaway.com on Thu, Nov 22, 2001 at 09:50:10PM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2001 at 09:50:10PM +0800, Ishak Hartono wrote:
> I tried to compile 2.4.14 and successfully detect the digital 21143 network
> card, however, i can't ping out
> 
> this is just a curiosity, because it works with my 2.2.17 kernel
> 
> the reason why i didn't move to 2.4.x yet because i got this problem with
> 2.4.5 as well and gave it a try again on 2.4.14 kernel
> 
> anyone know what should i check in the system  other than blaming on the
> kernel ?

I'm not sure if this counts or not.  One of my kernel build boxes for ARM
is a NetWinder, which I run over the 100MBit port (which is a 21143).  I've
been building kernels on it for ages under various 2.4 kernel versions (both
Linus and -ac) without any problems.

Linux sturm 2.4.15-pre5 #32 Sat Nov 17 22:10:45 GMT 2001 armv4l unknown

lspci reports:

00:0a.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
        Subsystem: Unknown device 574e:5554
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 20 min, 40 max, 32 set, cache line size 08
        Interrupt: pin A routed to IRQ 22
        Region 0: I/O ports at 6000 [size=128]
        Region 1: Memory at c1000000 (32-bit, non-prefetchable) [size=1K]
        Expansion ROM at 80000000 [disabled] [size=256K]

Note that I haven't tried 2.4.14 on this machine, only 2.4.13-ac8 and
2.4.15-pre*.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

