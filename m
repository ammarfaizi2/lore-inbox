Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318045AbSIOMiH>; Sun, 15 Sep 2002 08:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318047AbSIOMiH>; Sun, 15 Sep 2002 08:38:07 -0400
Received: from mail.seaplace.org ([209.184.155.43]:54151 "EHLO
	lynn.seaplace.org") by vger.kernel.org with ESMTP
	id <S318045AbSIOMiE>; Sun, 15 Sep 2002 08:38:04 -0400
Message-ID: <3D84804F.70007@seaplace.org>
Date: Sun, 15 Sep 2002 07:42:55 -0500
From: "Kevin N. Carpenter" <kevinc@seaplace.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.0.0) Gecko/20020530
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Fwd: Re: Think 2.4.10 broke my PCI subsystem.]
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Sorry if I wasn't clear last night, twas late when I posted.

I'd love to be running a current kernel, but anything after 2.4.9 
exhibits the same problem.  It took me an evening of compiles to track 
it down to 2.4.10, but thats about the limit of my diagnostic skills.

All help sincerely appreciated,

Kevin C.

-------- Original Message --------
Subject: Re: Think 2.4.10 broke my PCI subsystem.
Date: Sun, 15 Sep 2002 05:24:45 -0400
From: Ahmed Masud <masud@googgun.com>
To: Kevin Carpenter <kevinc@seaplace.org>
References: <200209150529.g8F5Tgh14760@lynn.seaplace.org>



Kevin Carpenter wrote:

>I've recently been okaying around with low cost motherboards and have been
>problems on two of them:  the BIOSTAT micro-ATX mobo M7VKQ, and the ESC L7SOM
>mobos.
>
>BOth work fine so long as I hold the kernel to 2.4.9 or earlier.  Once the
>2.4.10 patch is applied, the kernel no longer recognises the PCI Buss.
>
>Under 2.4.9 /proc/pci shows:
>
>PCI devices found:
>  Bus  0, device   0, function  0:
>    Host bridge: PCI device 1039:0740 (Silicon Integrated Systems [SiS]) (rev 1).
>      Master Capable.  Latency=32.  
>      Non-prefetchable 32 bit memory at 0xe8000000 [0xe8ffffff].
>  Bus  0, device   1, function  0:
>    PCI bridge: Silicon Integrated Systems [SiS] 5591/5592 AGP (rev 0).
>      Master Capable.  Latency=99.  Min Gnt=12.
>  Bus  0, device   2, function  0:
>    ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513 (rev 0).
>  Bus  0, device   2, function  5:
>    IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev 208).
>      Master Capable.  Latency=16.  
>      I/O at 0x4000 [0x400f].
>  Bus  0, device   2, function  7:
>    Multimedia audio controller: PCI device 1039:7012 (Silicon Integrated Systems [SiS]) (rev 160).
>      IRQ 10.
>      Master Capable.  Latency=32.  Min Gnt=52.Max Lat=11.
>      I/O at 0xe000 [0xe0ff].
>      I/O at 0xe400 [0xe47f].
>  Bus  0, device  15, function  0:
>    Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 16).
>      IRQ 11.
>      Master Capable.  Latency=32.  Min Gnt=32.Max Lat=64.
>      I/O at 0xe800 [0xe8ff].
>      Non-prefetchable 32 bit memory at 0xe9102000 [0xe91020ff].
>  Bus  1, device   0, function  0:
>    VGA compatible controller: PCI device 1039:6325 (Silicon Integrated Systems [SiS]) (rev 0).
>      Prefetchable 32 bit memory at 0xe0000000 [0xe7ffffff].
>      Non-prefetchable 32 bit memory at 0xe9000000 [0xe901ffff].
>      I/O at 0xd000 [0xd07f].
>
>Using lspci:
>
>00:00.0 Host bridge: Silicon Integrated Systems [SiS] 740 Host (rev 01)
>00:01.0 PCI bridge: Silicon Integrated Systems [SiS] 5591/5592 AGP
>00:02.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513
>00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0)
>00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS] SiS7012 PCI Audio Accelerator (rev a0)
>00:0f.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
>01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS]: Unknown device 6325
>
>>From DMESG:
>
>POSIX conformance testing by UNIFIX
>PCI: PCI BIOS revision 2.10 entry at 0xfb5f0, last bus=1
>PCI: Probing PCI hardware
>PCI: Using IRQ router SIS [1039/0008] at 00:02.0
>Linux NET4.0 for Linux 2.4
>
>After rebuilding with any kernel greater than patch level 9, I get the following
>messages as part of the boot sequence:
>
>mtrr: detected mtrr type: Intel
>PCI: PCI BIOS revision 2.10 entry at 0xfb5f0, last bus=1
>PCI: System does not support PCI
>isapnp: Scanning for PnP cards...
>
>HELP PLEASE!  I don't want to be stuck on 2.4.9 forever!
>
>I have one development box that I can do just about anything you wish to. 
>Please let me know how to help.
>
>Thanks,
>
>Kevin C.
>  
>
Have you considered using 2.4.18 ????


You are a bit behind on the kernel releases.





