Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317791AbSG2TJy>; Mon, 29 Jul 2002 15:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317815AbSG2TJy>; Mon, 29 Jul 2002 15:09:54 -0400
Received: from acd.ufrj.br ([146.164.3.7]:57357 "EHLO acd.ufrj.br")
	by vger.kernel.org with ESMTP id <S317791AbSG2TJx>;
	Mon, 29 Jul 2002 15:09:53 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Scorpion <scorpionlab@ieg.com.br>
Reply-To: scorpionlab@ieg.com.br
Organization: ScorpionLAB
To: linux-kernel@vger.kernel.org
Subject: IO-APIC in SMP dual Athlon XP1800
Date: Mon, 29 Jul 2002 16:12:32 -0300
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200207291612.38473.scorpionlab@ieg.com.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi follows,
I'm getting in troubles with a A7M266-D motherboard with two
Athlon XP 1800 cpus (yes, XP not MP!).
Following the screen shot of my problem:
^-------cut here---------^
EIP:    0010:[<c0111686>]    Not tainted
EFLAGS: 00011046
<4>CPU:    1
<4>CPU:    1
EIP:    0010:[<c0111686>]    Not tainted
EFLAGS:  00011046
 `u!wisuu`m aeesess 7eg111eg
 printing eip:
 printing eip:
*pde = 11111010
Stuck ??
CPU #1 not responding - cannot use it.
Error: only one processor found.
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-10, 2-11, 2-12, 2-13, 2-16, 2-17, 2-20, 2-21, 2-22, 
2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
^-----cut here-----^

After spend some times put printk's in kernel source like "Reach this point!"
I was trying disable IO_APIC in .config file but some link erros ocurred. 
Has any way to turn IO_APIC disable? Or its extreme necessary?

Thanks,
Ricardo.
