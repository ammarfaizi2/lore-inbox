Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277271AbRJQWxO>; Wed, 17 Oct 2001 18:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277276AbRJQWwz>; Wed, 17 Oct 2001 18:52:55 -0400
Received: from netdoor.com ([208.137.128.6]:46831 "EHLO pike.netdoor.com")
	by vger.kernel.org with ESMTP id <S277271AbRJQWwq>;
	Wed, 17 Oct 2001 18:52:46 -0400
Message-ID: <3BCE0C28.9090001@netdoor.com>
Date: Wed, 17 Oct 2001 17:54:32 -0500
From: Brad Chandler <mbc@netdoor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2-2 i686; en-US; 0.7) Gecko/20010316
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kernel panic when adding ram
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I apologize if this isn't the appropriate place for this question. I'm 
having trouble when I try to add a second stick of ram to the #2 slot on 
my motherboard. At this point I don't know whether it's a hardware or 
software problem.

I have two 256mb ECC Crucial ram that I cannot get to work in Linux. At 
first I thought one of the sticks was bad, but I've been able to get 
both sticks to work when used alone in the first slot. Both sticks 
together will not work.  The computer will boot up fine and the bios 
passes things off to the OS.  The bios appears to detect all the ram.  
Linux (RedHat 7.1) will start to boot but will kernel panic soon after.  
I've tried it with Kernel 2.4.2-2 and Kernel 2.4.12.


Here is everything I could get off the screen when it kernel panics:

IP: routing cache hash table of 4096 buckets, 32kbytes
uhici.c: cc00: host system error, PCI problems?
uhici.c: cc00: host controller halted. very bad.
TCP: Hash tables configured (established 32768 bind 32768)
Unable to handle kernel paging request at virtual address 177e7038
printing eip:
c0124b73
*pde=00000000
Oops: 0000
CPU: 0
EIP: 0010:[] Not tainted
Eflags: 00010807
eax: cde3b808 ebx: c1807280 ecx: dfef9000 edx: c02a9a9c
esi: 00000246 edi: f1dc0400 ebp: c1807280 esp: c181ff30
dsi: 0018 es: 0018 ss:0018
Processor swapper (pid: 1 stackpage=c181f000)
Stack 81240001 c029367d c0208c01 c18063do 000003f0 c02ccab4
00008124 c02cca94
c0293673 c0293676 c0147d98 c181ffac c029367d 00008124
00000001 c02cca44
c02cca94 c02e4b09 c0293679 00000000 c1809c40 0008e000
c02132f9 00000020
Call Trace: [] []

Code f3 ab 8d 45 01 3d ff 01 00 00 8d 7b 4c 8b 74 24 04 77 14 89
<0> Kernel panic: Attempted to kill init



Could someone please tell me what is happening? Thanks in advance for
any help.

Could you please CC my address since I'm not subscribed to the list.

Brad Chandler


