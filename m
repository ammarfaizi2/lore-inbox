Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268140AbRGWHjL>; Mon, 23 Jul 2001 03:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268139AbRGWHjC>; Mon, 23 Jul 2001 03:39:02 -0400
Received: from www.sam-net.de ([212.118.203.2]:21522 "EHLO www.sam-net.de")
	by vger.kernel.org with ESMTP id <S268140AbRGWHit>;
	Mon, 23 Jul 2001 03:38:49 -0400
Message-ID: <3B5BD487.2050308@kling-bauer.de>
Date: Mon, 23 Jul 2001 09:38:47 +0200
From: Dietmar Kling <d.kling@kling-bauer.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:0.9.2+) Gecko/20010719
X-Accept-Language: en-us
MIME-Version: 1.0
To: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.7 and setpci no go
In-Reply-To: <Pine.LNX.4.10.10107222138280.27761-100000@coffee.psychology.mcmaster.ca>
Content-Type: multipart/mixed;
 boundary="------------080604000900060504060001"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

This is a multi-part message in MIME format.
--------------080604000900060504060001
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

> it looks like you setpci while the driver was loaded.
> normally, drivers only query the irq on load.



Sorry but i did set all this values in the init script (even before proc 
with the -H1 switch
of setpci) of my redhat 7.1
but the output of dump_irq ( i've read about this on the 
kernel-mailing-list )
looks rather strange.

output of lscpi -vv -xxxx attached toot

Any Hints?

Regards
Dietmar



Interrupt routing table found at address 0xfdf00:
  Version 1.0, size 0x0090
  Interrupt router is device 00:00.0
  PCI exclusive interrupt mask: 0x0820 [5,11]
 
Device 00:08.0 (slot 1):
  INTA: link 0x01, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTB: link 0x02, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTC: link 0x03, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTD: link 0x04, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
 
Device 00:09.0 (slot 2): Ethernet controller
  INTA: link 0x02, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTB: link 0x03, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTC: link 0x04, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTD: link 0x01, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
 
Device 00:0a.0 (slot 3):
  INTA: link 0x03, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTB: link 0x04, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTC: link 0x01, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTD: link 0x02, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
 
Device 00:0b.0 (slot 4):
  INTA: link 0x04, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTB: link 0x01, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTC: link 0x02, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTD: link 0x03, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
 
Device 00:0c.0 (slot 5):
  INTA: link 0x01, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTB: link 0x02, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTC: link 0x03, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTD: link 0x04, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
 
Device 00:0d.0 (slot 6):
  INTA: link 0x01, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTB: link 0x02, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTC: link 0x03, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTD: link 0x04, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
 
Device 00:01.0 (slot 0): PCI bridge
  INTA: link 0x01, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTB: link 0x02, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTC: link 0x03, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
  INTD: link 0x04, irq mask 0xdeb8 [3,4,5,7,9,10,11,12,14,15]
 
Interrupt router at 00:00.0: unknown vendor 0x1106 device 0x3099
  PIRQ? (link 0x01): unrouted?
  PIRQ? (link 0x02): irq 10
  PIRQ? (link 0x03): unrouted?
  PIRQ? (link 0x04): unrouted?
[root@thor /root]#





Mark Hahn wrote:

>it looks like you setpci while the driver was loaded.
>normally, drivers only query the irq on load.
>
>
>>### Example 1 ####
>>/sbin/setpci  -v -s 00:11.5 INTERRUPT_LINE=9
>>00:11.5:3c 09
>>/sbin/lspci  -v -s 00:11.5 -x
>>00:11.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio 
>>Controller (rev 10)
>>        Subsystem: Elitegroup Computer Systems: Unknown device 0996
>>        Flags: medium devsel, IRQ 11
>>        I/O ports at e400 [size=256]
>>        Capabilities: [c0] Power Management version 2
>>00: 06 11 59 30 01 00 10 02 10 00 01 04 00 00 00 00
>>10: 01 e4 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>20: 00 00 00 00 00 00 00 00 00 00 00 00 19 10 96 09
>>30: 00 00 00 00 c0 00 00 00 00 00 00 00 09 03 00 00
>>                                                                  ^^<--- 
>>changed
>>### Example 2  ####
>>/sbin/setpci  -v -s 00:11.5 INTERRUPT_LINE=0x0a
>>00:11.5:3c 0a
>>/sbin/lspci  -v -s 00:11.5 -x
>>00:11.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio 
>>Controller (rev 10)
>>        Subsystem: Elitegroup Computer Systems: Unknown device 0996
>>        Flags: medium devsel, IRQ 11
>>        I/O ports at e400 [size=256]
>>        Capabilities: [c0] Power Management version 2
>>00: 06 11 59 30 01 00 10 02 10 00 01 04 00 00 00 00
>>10: 01 e4 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>20: 00 00 00 00 00 00 00 00 00 00 00 00 19 10 96 09
>>30: 00 00 00 00 c0 00 00 00 00 00 00 00 10 03 00 00
>>                                                                  ^^<--- 
>>changed                                                                   
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>Please read the FAQ at  http://www.tux.org/lkml/
>>
>



--------------080604000900060504060001
Content-Type: application/octet-stream;
 name="lspci.txt.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="lspci.txt.gz"

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
/seBef8BYfekcVs5AAA=
--------------080604000900060504060001--

