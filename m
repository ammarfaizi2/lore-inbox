Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130842AbRALMQW>; Fri, 12 Jan 2001 07:16:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131141AbRALMQD>; Fri, 12 Jan 2001 07:16:03 -0500
Received: from enterprise.cistron.net ([195.64.68.33]:34311 "EHLO
	enterprise.cistron.net") by vger.kernel.org with ESMTP
	id <S130842AbRALMQA>; Fri, 12 Jan 2001 07:16:00 -0500
From: dth@lin-gen.com (Danny ter Haar)
Subject: Re: PRoblem with pcnet32 under 2.4.0 , was :Drivers under 2.4
Date: Fri, 12 Jan 2001 12:16:05 +0000 (UTC)
Organization: Linux Generation bv
Message-ID: <93msi4$s1v$1@voyager.cistron.net>
In-Reply-To: <20010112125010.A6371@lin-gen.com> <Pine.LNX.4.30.0101121357370.707-100000@prime.sun.ac.za>
Reply-To: dth@lin-gen.com
X-Trace: voyager.cistron.net 979301765 28735 195.64.80.162 (12 Jan 2001 12:16:05 GMT)
X-Complaints-To: abuse@cistron.nl
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Grobler  <grobh@sun.ac.za> wrote:
>> lspci -vx output:
>What about the other devices?

ok, here's the full listing :

00:00.0 Host bridge: Cyrix Corporation PCI Master                               
        Flags: bus master, medium devsel, latency 0                             
00: 78 10 01 00 07 00 80 02 00 00 00 06 00 00 00 00                             
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00                             
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00                             
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00                             
                                                                                
00:0e.0 VGA compatible controller: Intergraphics Systems CyberPro 5000 (rev 02) 
(prog-if 00 [VGA])                                                              
        Subsystem: Unknown device 0280:7000                                     
        Flags: medium devsel, IRQ 11                                            
        Memory at fd000000 (32-bit, non-prefetchable) [size=16M]                
        Expansion ROM at <unassigned> [disabled] [size=64K]                     
00: ea 10 00 50 03 00 00 02 02 00 00 03 04 40 00 00                             
10: 00 00 00 fd 00 00 00 00 00 00 00 00 00 00 00 00                             
20: 00 00 00 00 00 00 00 00 00 00 00 00 80 02 00 70                             
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 00 00     

00:0f.0 Ethernet controller: Advanced Micro Devices [AMD] 79c970 [PCnet LANCE] (
rev 42)                                                                         
        Subsystem: Advanced Micro Devices [AMD]: Unknown device 2000            
        Flags: bus master, medium devsel, latency 64, IRQ 9                     
        I/O ports at fce0 [size=32]                                             
        Memory at fedffc00 (32-bit, non-prefetchable) [size=32]                 
        Expansion ROM at <unassigned> [disabled] [size=1M]                      
        Capabilities: [40] Power Management version 1                           
00: 22 10 00 20 07 00 90 02 42 00 00 02 00 40 00 00                             
10: e1 fc 00 00 00 fc df fe 00 00 00 00 00 00 00 00                             
20: 00 00 00 00 00 00 00 00 00 00 00 00 22 10 00 20                             
30: 00 00 00 00 40 00 00 00 00 00 00 00 09 01 18 18   

00:12.1 Bridge: Cyrix Corporation 5530 SMI [Kahlua]                             
        Flags: medium devsel                                                    
        Memory at 40012000 (32-bit, non-prefetchable) [size=256]                
00: 78 10 01 01 02 00 80 02 00 00 80 06 00 00 00 00                             
10: 00 20 01 40 00 00 00 00 00 00 00 00 00 00 00 00                             
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00                             
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00                             
                                                                                
00:12.2 IDE interface: Cyrix Corporation 5530 IDE [Kahlua] (prog-if 00 [])      
        Flags: medium devsel                                                    
        I/O ports at fc00 [size=16]                                             
00: 78 10 02 01 01 00 80 02 00 00 01 01 00 00 00 00                             
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00                             
20: 01 fc 00 00 00 00 00 00 00 00 00 00 00 00 00 00                             
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  

00:12.3 Multimedia audio controller: Cyrix Corporation 5530 Audio [Kahlua]      
        Flags: bus master, medium devsel, latency 0                             
        Memory at 40011000 (32-bit, non-prefetchable) [size=128]                
00: 78 10 03 01 06 00 80 02 00 00 01 04 00 00 00 00                             
10: 00 10 01 40 00 00 00 00 00 00 00 00 00 00 00 00                             
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00                             
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00                             
                                                                                
00:13.0 USB Controller: Compaq Computer Corporation: Unknown device a0f8 (rev 06
) (prog-if 10 [OHCI])                                                           
        Subsystem: Compaq Computer Corporation: Unknown device a0f8             
        Flags: medium devsel, IRQ 10                                            
        Memory at fedfe000 (32-bit, non-prefetchable) [size=4K]                 
00: 11 0e f8 a0 13 00 80 02 06 10 03 0c 00 40 00 00                             
10: 00 e0 df fe 00 00 00 00 00 00 00 00 00 00 00 00                             
20: 00 00 00 00 00 00 00 00 00 00 00 00 11 0e f8 a0                             
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 01 00 50          

00:14.0 Multimedia video controller: Zoran Corporation ZR36120 (rev 03)         
        Subsystem: Optibase Ltd: Unknown device 5000                            
        Flags: fast devsel, IRQ 10                                              
        Memory at fedfd000 (32-bit, non-prefetchable) [size=4K]                 
00: de 11 20 61 02 00 00 00 03 00 00 04 00 40 00 00                             
10: 00 d0 df fe 00 00 00 00 00 00 00 00 00 00 00 00                             
20: 00 00 00 00 00 00 00 00 00 00 00 00 55 12 00 50                             
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 01 02 10  

The last one is an plugin pci mpeg2 decoder (which is optional)

>> irq  0:     16840 timer                 irq  9:         0 acpi, PCnet/FAST III
>
>Ok, this may not mean much, but have you tried compiling without acpi?
>Just to remove some variables...

yesterdays trials were with 2.4.0-ac4 which did not include acpi.
Wil re-compile (slow!! :) wihout acpi and re-try.

Danny

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
