Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261856AbREPKD3>; Wed, 16 May 2001 06:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261860AbREPKDK>; Wed, 16 May 2001 06:03:10 -0400
Received: from gate1.rzeczpospolita.pl ([195.8.129.1]:35851 "EHLO
	rzeczpospolita.pl") by vger.kernel.org with ESMTP
	id <S261856AbREPKDG>; Wed, 16 May 2001 06:03:06 -0400
Message-ID: <3B02504E.8F8926AB@rzeczpospolita.pl>
Date: Wed, 16 May 2001 12:02:54 +0200
From: ps <ps@rzeczpospolita.pl>
X-Mailer: Mozilla 4.08 [en] (Win98; I)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: RH 7.1 on IBM xSeries 240
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to run Linux RH 7.1 on the rack-mounted 
IBM xSeries 240 with ServeRAID but without success.
I've tried some kernels from 2.2.19-7.0.1smp up to
2.4.3-2.14.14.i686 and 2.4.4.

During boot all kernels reported errors (attached at the end).
When I try to write to disk (untar 100MB) machine almost hangs -
I must wait MINUTES for any simple "ll" or "who".

Thanks in advance for any help.

 - Piotr Szymanek

=================================================
   ...

found SMP MP-table at 0009e140
hm, page 0009e000 reserved twice.
hm, page 0009f000 reserved twice.
hm, page 000a0000 reserved twice.
hm, page 0009e000 reserved twice.
hm, page 0009f000 reserved twice.
hm, page 000a0000 reserved twice.
WARNING: MP table in the EBDA can be UNSAFE

   ...

ENABLING IO-APIC IRQs
...changing IO-APIC physical APIC ID to 14 ... ok.
BIOS bug, IO-APIC#1 ID is 15 in the MPC table!...
... fixing up to 15. (tell your hw vendor)
...changing IO-APIC physical APIC ID to 15 ... ok.
Synchronizing Arb IDs.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 14-0, 14-5, 15-0, 15-1, 15-2, 15-3, 15-14, 15-15
not connected.
..TIMER: vector=49 pin1=2 pin2=0
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ... 
..... (found pin 0) ...works.
number of MP IRQ sources: 31.
number of IO-APIC #14 registers: 16.
number of IO-APIC #15 registers: 16.
testing the IO APIC.......................

   ...

CPU1<T0:1332736,T1:444240,D:6,S:444245,C:1332737>
checking TSC synchronization across CPUs: passed.
Setting commenced=1, go go go
mtrr: your CPUs had inconsistent fixed MTRR settings
mtrr: probably your BIOS does not setup all CPUs
PCI: PCI BIOS revision 2.10 entry at 0xfd34c, last bus=4
