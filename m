Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318361AbSG3R3R>; Tue, 30 Jul 2002 13:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318365AbSG3R3Q>; Tue, 30 Jul 2002 13:29:16 -0400
Received: from acd.ufrj.br ([146.164.3.7]:32263 "EHLO acd.ufrj.br")
	by vger.kernel.org with ESMTP id <S318361AbSG3R3N>;
	Tue, 30 Jul 2002 13:29:13 -0400
Content-Type: text/plain; charset=US-ASCII
From: Scorpion <scorpionlab@ieg.com.br>
Reply-To: scorpionlab@ieg.com.br
Organization: ScorpionLAB
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: Re: IO-APIC in SMP dual Athlon XP1800
Date: Tue, 30 Jul 2002 14:32:00 -0300
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0207292151420.20701-100000@linux-box.realnet.co.sz>
In-Reply-To: <Pine.LNX.4.44.0207292151420.20701-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207301432.00401.scorpionlab@ieg.com.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I tried using:

2.4.18-3smp (red hat 7.3) with options: hdc=ide-scsi
and using ext3 fs.

2.4.18-5custom (red hat 7.3 recompiled with smp, bigmem and ext3 fs) with 
options: hdc=ide-scsi

2.4.18-5smp (red hat 7.3 upgrade of bigmem header problem and ext3 fs problem) 
with options: hdc=ide-scsi

2.4.18-3 (red hat 7.3 uniprocessor for get up) with options:
hdc=ide-scsi noprobe mem=256m

details about the last:  
    When changing mem parameter value to 64 or 512 or 128 its stop in 
different places (using the "printk debbug technic") in io_apic.c/apic.c 
parts.

After that I tried the kernel from kernel.org and got the following message:

-----------^^^cut here^^^------------
Total of 2 processors activated (6121.06 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
...TIMER: vector=0x31 pin1=2 pin2=0
testing the IO APIC...........................................

......................................................................done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1533.2911 MHz.
..... host bus clock speed is 266.6593 MHz.
cpu: 0, clocks: 2666593, slice: 888864
CPU0<T0:2666592,T1:1777728,D:0,S:888864,C:2666593>
-----------^^^cut here^^^------------

Its a error? Should a try the last last kernel patchs?

I'm not thinking about a hadware problem, cause BIOS detect
2 CPUS and Linux agree with this. Am I wrong?

Regards,
Ricardo.


On Monday 29 July 2002 16:52, The Kernel Developer Zwane Mwaikambo wrote:
> On Mon, 29 Jul 2002, Scorpion wrote:
> > I'm getting in troubles with a A7M266-D motherboard with two
> > Athlon XP 1800 cpus (yes, XP not MP!).
>
> Which kernel version ?
>
> 	Zwane

