Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262008AbREPQ6P>; Wed, 16 May 2001 12:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262006AbREPQ6F>; Wed, 16 May 2001 12:58:05 -0400
Received: from moe.unleashed.org ([216.86.199.34]:23559 "HELO
	mail.unleashed.org") by vger.kernel.org with SMTP
	id <S262012AbREPQ5w>; Wed, 16 May 2001 12:57:52 -0400
Date: Wed, 16 May 2001 09:57:50 -0700
From: Leah Cunningham <leah@unleashed.org>
To: ps <ps@rzeczpospolita.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RH 7.1 on IBM xSeries 240
Message-ID: <20010516095750.A40686@unleashed.org>
In-Reply-To: <3B02504E.8F8926AB@rzeczpospolita.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <3B02504E.8F8926AB@rzeczpospolita.pl>; from ps@rzeczpospolita.pl on Wed, May 16, 2001 at 12:02:54PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This may be way off, but have you flashed the BIOS to the most
current revision? This machine should work properly.  How many
processors and what SR card are you using?

ps (ps@rzeczpospolita.pl) [010516 03:07]:
- > I'm trying to run Linux RH 7.1 on the rack-mounted 
- > IBM xSeries 240 with ServeRAID but without success.
- > I've tried some kernels from 2.2.19-7.0.1smp up to
- > 2.4.3-2.14.14.i686 and 2.4.4.
- > 
- > During boot all kernels reported errors (attached at the end).
- > When I try to write to disk (untar 100MB) machine almost hangs -
- > I must wait MINUTES for any simple "ll" or "who".
- > 
- > Thanks in advance for any help.
- > 
- >  - Piotr Szymanek
- > 
- > =================================================
- >    ...
- > 
- > found SMP MP-table at 0009e140
- > hm, page 0009e000 reserved twice.
- > hm, page 0009f000 reserved twice.
- > hm, page 000a0000 reserved twice.
- > hm, page 0009e000 reserved twice.
- > hm, page 0009f000 reserved twice.
- > hm, page 000a0000 reserved twice.
- > WARNING: MP table in the EBDA can be UNSAFE
- > 
- >    ...
- > 
- > ENABLING IO-APIC IRQs
- > ...changing IO-APIC physical APIC ID to 14 ... ok.
- > BIOS bug, IO-APIC#1 ID is 15 in the MPC table!...
- > ... fixing up to 15. (tell your hw vendor)
- > ...changing IO-APIC physical APIC ID to 15 ... ok.
- > Synchronizing Arb IDs.
- > init IO_APIC IRQs
- >  IO-APIC (apicid-pin) 14-0, 14-5, 15-0, 15-1, 15-2, 15-3, 15-14, 15-15
- > not connected.
- > ..TIMER: vector=49 pin1=2 pin2=0
- > ..MP-BIOS bug: 8254 timer not connected to IO-APIC
- > ...trying to set up timer (IRQ0) through the 8259A ... 
- > ..... (found pin 0) ...works.
- > number of MP IRQ sources: 31.
- > number of IO-APIC #14 registers: 16.
- > number of IO-APIC #15 registers: 16.
- > testing the IO APIC.......................
- > 
- >    ...
- > 
- > CPU1<T0:1332736,T1:444240,D:6,S:444245,C:1332737>
- > checking TSC synchronization across CPUs: passed.
- > Setting commenced=1, go go go
- > mtrr: your CPUs had inconsistent fixed MTRR settings
- > mtrr: probably your BIOS does not setup all CPUs
- > PCI: PCI BIOS revision 2.10 entry at 0xfd34c, last bus=4
- > -
- > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
- > the body of a message to majordomo@vger.kernel.org
- > More majordomo info at  http://vger.kernel.org/majordomo-info.html
- > Please read the FAQ at  http://www.tux.org/lkml/

             I can't believe it's not UNIX!!!
------------------------------------------------------------
Leah Cunningham             |  SuSE Expert, NOS Engineer, 
Undisclosed Address         |  QA & Linux geek, et al.        
