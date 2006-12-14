Return-Path: <linux-kernel-owner+w=401wt.eu-S1750722AbWLND5G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbWLND5G (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 22:57:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750849AbWLND5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 22:57:05 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:15982 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750842AbWLND5E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 22:57:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WYfw4eLtngEHjwr+BoeayAV4Rcu2RL8CPZWuzfIDMaglE6zjOrgmWafJaH4gM76hDJUUbNiQq61EgjqhVA4Q72jekCeaz7hipToqENuyqPrrfm+C0I9DCaJHI1vzEr8XRKoHxAK+q9TdiksnlKWdxBgBjTBWxqlCB3e68cYEl0s=
Message-ID: <8136c77f0612131957p7069dc15h3bd6a1fe46cef71a@mail.gmail.com>
Date: Thu, 14 Dec 2006 11:57:02 +0800
From: "david lee" <huaq.li@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Fwd: why the linux console always print repeat message
Cc: linux-arm@lists.arm.linux.org.uk
In-Reply-To: <8136c77f0611240235tbe5e568uddd76eaee939cab3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <8136c77f0611240235tbe5e568uddd76eaee939cab3@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,all:
   I run linux on our arm board,when I enable the serial_console,the
printk will
always print the loop message ,though it can run to busybox start up,but what 's
wrong with it?
  if I disable the serial_console ,and enable the DEBUG_LL,it 's just
print these message once,so I am messed what's wrong of my printk?
 who know the problem?thanks.

following is the message:
------------------------------------------------------------------------
# Linux version 2.6.14-awt (david@fc4) (gcc version 3.4.3) #11 Mon Oct
30 20:00:03 EST 2006
<4>CPU: ARM926EJ-Sid(wt) [41069265] revision 5 (ARMv5TEJ)
<4>Machine: ApaceWave AWT110
<4>paging_init start
<5>for_each_online_node:
<5>memtable_init
<4>Memory policy: ECC disabled, Data cache writethrough
<5>for_each_online_node: 0xc002e1a4
<7>On node 0 totalpages: 4096
<7>  DMA zone: 4096 pages, LIFO batch:1
<7>  Normal zone: 0 pages, LIFO batch:1
<7>  HighMem zone: 0 pages, LIFO batch:1
<4>request_standard_resources start
<4>cpu_init()
<4>CPU0: D VIVT write-back cache
<4>CPU0: I cache: 32768 bytes, associativity 4, 32 byte lines, 256 sets
<4>CPU0: D cache: 32768 bytes, associativity 4, 32 byte lines, 256 sets
<4>Built 1 zonelists
<5>Kernel command line: root=/dev/ram0 console=ttyS0,9600n8
<4>PID hash table entries: 128 (order: 7, 2048 bytes)
<4>1...............TIMER_CTRL:0x0
<4>2...............TIMER_CTRL:0xcc
<4>vic_unmask_irq:irq==5
<4>Console: colour dummy device 80x30
CPU: ARM926EJ-Sid(wt) [41069265] revision 5 (ARMv5TEJ)
<4>Machine: ApaceWave AWT110
<4>paging_init start
<5>for_each_online_node:
<5>memtable_init
<4>Memory policy: ECC disabled, Data cache writethrough
<5>for_each_online_node: 0xc002e1a4
<7>On node 0 totalpages: 4096
<7>  DMA zone: 4096 pages, LIFO batch:1
<7>  Normal zone: 0 pages, LIFO batch:1
<7>  HighMem zone: 0 pages, LIFO batch:1
<4>request_standard_resources start
<4>cpu_init()
<4>CPU0: D VIVT write-back cache
<4>CPU0: I cache: 32768 bytes, associativity 4, 32 byte lines, 256 sets
<4>CPU0: D cache: 32768 bytes, associativity 4, 32 byte lines, 256 sets
<4>Built 1 zonelists
<5>Kernel command line: root=/dev/ram0 console=ttyS0,9600n8
<4>PID hash table entries: 128 (order: 7, 2048 bytes)
<4>1...............TIMER_CTRL:0x0
<4>2...............TIMER_CTRL:0xcc
<4>vic_unmask_irq:irq==5
<4>Console: colour dummy device 80x30
Machine: ApaceWave AWT110
<4>paging_init start
<5>for_each_online_node:
<5>memtable_init
<4>Memory policy: ECC disabled, Data cache writethrough
<5>for_each_online_node: 0xc002e1a4
<7>On node 0 totalpages: 4096
<7>  DMA zone: 4096 pages, LIFO batch:1
<7>  Normal zone: 0 pages, LIFO batch:1
<7>  HighMem zone: 0 pages, LIFO batch:1
<4>request_standard_resources start
<4>cpu_init()
<4>CPU0: D VIVT write-back cache
<4>CPU0: I cache: 32768 bytes, associativity 4, 32 byte lines, 256 sets
<4>CPU0: D cache: 32768 bytes, associativity 4, 32 byte lines, 256 sets
<4>Built 1 zonelists
<5>Kernel command line: root=/dev/ram0 console=ttyS0,9600n8
<4>PID hash table entries: 128 (order: 7, 2048 bytes)
<4>1...............TIMER_CTRL:0x0
<4>2...............TIMER_CTRL:0xcc
<4>vic_unmask_irq:irq==5
<4>Console: colour dummy device 80x30
paging_init start
<5>for_each_online_node:
<5>memtable_init
<4>Memory policy: ECC disabled, Data cache writethrough
<5>for_each_online_node: 0xc002e1a4
<7>On node 0 totalpages: 4096
<7>  DMA zone: 4096 pages, LIFO batch:1
<7>  Normal zone: 0 pages, LIFO batch:1
<7>  HighMem zone: 0 pages, LIFO batch:1
<4>request_standard_resources start
<4>cpu_init()
<4>CPU0: D VIVT write-back cache
<4>CPU0: I cache: 32768 bytes, associativity 4, 32 byte lines, 256 sets
<4>CPU0: D cache: 32768 bytes, associativity 4, 32 byte lines, 256 sets
<4>Built 1 zonelists
<5>Kernel command line: root=/dev/ram0 console=ttyS0,9600n8
<4>PID hash table entries: 128 (order: 7, 2048 bytes)
<4>1...............TIMER_CTRL:0x0
<4>2...............TIMER_CTRL:0xcc
<4>vic_unmask_irq:irq==5
<4>Console: colour dummy device 80x30
for_each_online_node:
<5>memtable_init
<4>Memory policy: ECC disabled, Data cache writethrough
<5>for_each_online_node: 0xc002e1a4
<7>On node 0 totalpages: 4096
<7>  DMA zone: 4096 pages, LIFO batch:1
<7>  Normal zone: 0 pages, LIFO batch:1
<7>  HighMem zone: 0 pages, LIFO batch:1
<4>request_standard_resources start
<4>cpu_init()
<4>CPU0: D VIVT write-back cache
<4>CPU0: I cache: 32768 bytes, associativity 4, 32 byte lines, 256 sets
<4>CPU0: D cache: 32768 bytes, associativity 4, 32 byte lines, 256 sets
<4>Built 1 zonelists
<5>Kernel command line: root=/dev/ram0 console=ttyS0,9600n8
<4>PID hash table entries: 128 (order: 7, 2048 bytes)
<4>1...............TIMER_CTRL:0x0
<4>2...............TIMER_CTRL:0xcc
<4>vic_unmask_irq:irq==5
<4>Console: colour dummy device 80x30
memtable_init
<4>Memory policy: ECC disabled, Data cache writethrough
<5>for_each_online_node: 0xc002e1a4
<7>On node 0 totalpages: 4096
<7>  DMA zone: 4096 pages, LIFO batch:1
<7>  Normal zone: 0 pages, LIFO batch:1
<7>  HighMem zone: 0 pages, LIFO batch:1
<4>request_standard_resources start
<4>cpu_init()
<4>CPU0: D VIVT write-back cache
<4>CPU0: I cache: 32768 bytes, associativity 4, 32 byte lines, 256 sets
<4>CPU0: D cache: 32768 bytes, associativity 4, 32 byte lines, 256 sets
<4>Built 1 zonelists
<5>Kernel command line: root=/dev/ram0 console=ttyS0,9600n8
<4>PID hash table entries: 128 (order: 7, 2048 bytes)
<4>1...............TIMER_CTRL:0x0
<4>2...............TIMER_CTRL:0xcc
<4>vic_unmask_irq:irq==5
<4>Console: colour dummy device 80x30
Memory policy: ECC disabled, Data cache writethrough
<5>for_each_online_node: 0xc002e1a4
<7>On node 0 totalpages: 4096
<7>  DMA zone: 4096 pages, LIFO batch:1
<7>  Normal zone: 0 pages, LIFO batch:1
<7>  HighMem zone: 0 pages, LIFO batch:1
<4>request_standard_resources start
<4>cpu_init()
<4>CPU0: D VIVT write-back cache
<4>CPU0: I cache: 32768 bytes, associativity 4, 32 byte lines, 256 sets
<4>CPU0: D cache: 32768 bytes, associativity 4, 32 byte lines, 256 sets
<4>Built 1 zonelists
<5>Kernel command line: root=/dev/ram0 console=ttyS0,9600n8
<4>PID hash table entries: 128 (order: 7, 2048 bytes)
<4>1...............TIMER_CTRL:0x0
<4>2...............TIMER_CTRL:0xcc
<4>vic_unmask_irq:irq==5
<4>Console: colour dummy device 80x30
for_each_online_node: 0xc002e1a4
<7>On node 0 totalpages: 4096
<7>  DMA zone: 4096 pages, LIFO batch:1
<7>  Normal zone: 0 pages, LIFO batch:1
<7>  HighMem zone: 0 pages, LIFO batch:1
<4>request_standard_resources start
<4>cpu_init()
<4>CPU0: D VIVT write-back cache
<4>CPU0: I cache: 32768 bytes, associativity 4, 32 byte lines, 256 sets
<4>CPU0: D cache: 32768 bytes, associativity 4, 32 byte lines, 256 sets
<4>Built 1 zonelists
<5>Kernel command line: root=/dev/ram0 console=ttyS0,9600n8
<4>PID hash table entries: 128 (order: 7, 2048 bytes)
<4>1...............TIMER_CTRL:0x0
<4>2...............TIMER_CTRL:0xcc
<4>vic_unmask_irq:irq==5
<4>Console: colour dummy device 80x30
request_standard_resources start
<4>cpu_init()
<4>CPU0: D VIVT write-back cache
<4>CPU0: I cache: 32768 bytes, associativity 4, 32 byte lines, 256 sets
<4>CPU0: D cache: 32768 bytes, associativity 4, 32 byte lines, 256 sets
<4>Built 1 zonelists
<5>Kernel command line: root=/dev/ram0 console=ttyS0,9600n8
<4>PID hash table entries: 128 (order: 7, 2048 bytes)
<4>1...............TIMER_CTRL:0x0
<4>2...............TIMER_CTRL:0xcc
<4>vic_unmask_irq:irq==5
<4>Console: colour dummy device 80x30
cpu_init()
<4>CPU0: D VIVT write-back cache
<4>CPU0: I cache: 32768 bytes, associativity 4, 32 byte lines, 256 sets
<4>CPU0: D cache: 32768 bytes, associativity 4, 32 byte lines, 256 sets
<4>Built 1 zonelists
<5>Kernel command line: root=/dev/ram0 console=ttyS0,9600n8
<4>PID hash table entries: 128 (order: 7, 2048 bytes)
<4>1...............TIMER_CTRL:0x0
<4>2...............TIMER_CTRL:0xcc
<4>vic_unmask_irq:irq==5
