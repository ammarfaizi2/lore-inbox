Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266456AbTATS14>; Mon, 20 Jan 2003 13:27:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266520AbTATS1z>; Mon, 20 Jan 2003 13:27:55 -0500
Received: from vsmtp3.tin.it ([212.216.176.223]:41686 "EHLO smtp3.cp.tin.it")
	by vger.kernel.org with ESMTP id <S266456AbTATS1w>;
	Mon, 20 Jan 2003 13:27:52 -0500
Message-ID: <3E2C4256.7050303@tin.it>
Date: Mon, 20 Jan 2003 19:39:18 +0100
From: AnonimoVeneziano <voloterreno@tin.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Rolland <rol@as2917.net>
CC: "'LKML'" <linux-kernel@vger.kernel.org>, thunder7@xs4all.nl
Subject: Re: RE : IO-APIC says: unexpected IO-APIC was found
References: <006901c2c0b0$bd1719a0$4000a8c0@witbe>
In-Reply-To: <006901c2c0b0$bd1719a0$4000a8c0@witbe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Rolland wrote:

>Got the same with an ASUS P4S8X...
>
>Sent a mail to linux-smp@vger.kernel.org, as requested, but got
>no news...
>
>If you get some, please tell ;-)
>
>Regards,
>Paul
>
>  
>
>>-----Original Message-----
>>From: linux-kernel-owner@vger.kernel.org 
>>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of 
>>AnonimoVeneziano
>>Sent: Monday, January 20, 2003 5:50 PM
>>To: LKML
>>Subject: IO-APIC says: unexpected IO-APIC was found
>>
>>
>>Hi , I use on a system composed by a MSI KT4 Ultra 
>>Motherboard (KT400 - 
>>vt8235 Bios 1.3)  and an Athlon XP 2400+ the kernel 2.4.21-pre3-ac4 
>> with enabled UP-APIC and UP_IO_APIC.
>>
>>When I start the system the log says:
>>
>>    
>>
>>>00000000
>>>CPU: AMD Athlon(tm) XP 2400+ stepping 01
>>>Enabling fast FPU save and restore... done.
>>>Enabling unmasked SIMD FPU exception support... done. 
>>>      
>>>
>>Checking 'hlt' 
>>    
>>
>>>instruction... OK. POSIX conformance testing by UNIFIX
>>>enabled ExtINT on CPU#0
>>>ESR value before enabling vector: 00000080
>>>ESR value after enabling vector: 00000000
>>>ENABLING IO-APIC IRQs
>>>Setting 2 in the phys_id_present_map
>>>...changing IO-APIC physical APIC ID to 2 ... ok.
>>>init IO_APIC IRQs
>>> IO-APIC (apicid-pin) 2-0, 2-10, 2-11, 2-17, 2-19, 2-20, 
>>>      
>>>
>>2-21, 2-22, 
>>    
>>
>>>2-23 not connected.
>>>..TIMER: vector=0x31 pin1=2 pin2=0
>>>number of MP IRQ sources: 17.
>>>number of IO-APIC #2 registers: 24.
>>>testing the IO APIC.......................
>>>
>>>IO APIC #2......
>>>.... register #00: 02000000
>>>.......    : physical APIC id: 02
>>>.... register #01: 00178003
>>>.......     : max redirection entries: 0017
>>>.......     : PRQ implemented: 1
>>>.......     : IO APIC version: 0003
>>>An unexpected IO-APIC was found. If this kernel release is 
>>>      
>>>
>>less than 
>>    
>>
>>>three months old please report this to 
>>>      
>>>
>>linux-smp@vger.kernel.org .... 
>>    
>>
>>>IRQ redirection table:
>>> NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
>>> 00 000 00  1    0    0   0   0    0    0    00
>>> 01 001 01  0    0    0   0   0    1    1    39
>>> 02 001 01  0    0    0   0   0    1    1    31
>>> 03 001 01  0    0    0   0   0    1    1    41
>>> 04 001 01  0    0    0   0   0    1    1    49
>>> 05 001 01  0    0    0   0   0    1    1    51
>>> 06 001 01  0    0    0   0   0    1    1    59
>>> 07 001 01  0    0    0   0   0    1    1    61
>>> 08 001 01  0    0    0   0   0    1    1    69
>>> 09 001 01  0    0    0   0   0    1    1    71
>>> 0a 000 00  1    0    0   0   0    0    0    00
>>> 0b 000 00  1    0    0   0   0    0    0    00
>>> 0c 001 01  0    0    0   0   0    1    1    79
>>> 0d 001 01  0    0    0   0   0    1    1    81
>>> 0e 001 01  0    0    0   0   0    1    1    89
>>> 0f 001 01  0    0    0   0   0    1    1    91
>>> 10 001 01  1    1    0   1   0    1    1    99
>>> 11 000 00  1    0    0   0   0    0    0    00
>>> 12 001 01  1    1    0   1   0    1    1    A1
>>> 13 000 00  1    0    0   0   0    0    0    00
>>> 14 000 00  1    0    0   0   0    0    0    00
>>> 15 000 00  1    0    0   0   0    0    0    00
>>> 16 000 00  1    0    0   0   0    0    0    00
>>> 17 000 00  1    0    0   0   0    0    0    00
>>>IRQ to pin mappings:
>>>IRQ0 -> 0:2
>>>IRQ1 -> 0:1
>>>IRQ3 -> 0:3
>>>IRQ4 -> 0:4
>>>IRQ5 -> 0:5
>>>IRQ6 -> 0:6
>>>IRQ7 -> 0:7
>>>IRQ8 -> 0:8
>>>IRQ9 -> 0:9
>>>IRQ12 -> 0:12
>>>IRQ13 -> 0:13
>>>IRQ14 -> 0:14
>>>IRQ15 -> 0:15
>>>IRQ16 -> 0:16
>>>IRQ18 -> 0:18
>>>.................................... done.
>>>Using local APIC timer interrupts.
>>>calibrating APIC timer ...
>>>      
>>>
>>Unexpected IO-APIC was found???
>>
>>I've tried to compile the kernel without IO-APIC, with only 
>>UP-APIC, but 
>>it during the start
>>says:
>>
>>spurious 8259A interrupt: IRQ7 ????????? What does it mean??
>>
>>What is my problem with APIC??
>>
>>Thanks
>>
>>Bye
>>
>>Marcello
>>
>>
>>-
>>To unsubscribe from this list: send the line "unsubscribe 
>>linux-kernel" in the body of a message to 
>>majordomo@vger.kernel.org More majordomo info at  
>>    
>>
>http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>
Ops excuse me, I'me very stupid , I've not see that !! :p Is incredible, 
I've read that message 2 o 3 thousands times
X Paul:

I'll report you if I find something.
I've tried yet to report the problem?
What response have you recived?
Thanks


Bye

 Marcello

