Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265065AbTBBRiM>; Sun, 2 Feb 2003 12:38:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265093AbTBBRiM>; Sun, 2 Feb 2003 12:38:12 -0500
Received: from jive.SoftHome.net ([66.54.152.27]:45545 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id <S265065AbTBBRiL>;
	Sun, 2 Feb 2003 12:38:11 -0500
From: b_adlakha@softhome.net
To: linux-kernel@vger.kernel.org
Subject: what all has changed in ppp?
Date: Sun, 02 Feb 2003 10:47:37 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [210.214.83.172]
Message-ID: <courier.3E3D59B9.00006CAD@softhome.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sorry, I haven't been keeping up with the changes in 2.5, but I can't get 
pppd to work with 2.5.59, it dies with error code 1 while it works alright 
with 2.4.20... 

This is the first 2.5 kernel i've tried out, first I went for a wild goose 
chase in finding a version of modutils to go with the shiny new bzImage, 
then I finally downloaded module-init*, and installed it over the previous 
tools, then I remembered that I still might have to use 2.4 (which I am), so 
I fetched modutils again and installed it, then I installed module-init* 
with make *specialoption*,  and then (aaah, finished...)but no, I cannot 
dial to my isp...
pppd dies with error code 1 

Also, Does a Pentium4 have a local APIC? IO APIC?
I selected it anyway in the kernel config, and it shows some warning message 
at boot: 

: ENABLING IO-APIC IRQs
: init IO_APIC IRQs
:  IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-21, 2-22, 2-23 not 
connected.
: ..TIMER: vector=0x31 pin1=2 pin2=0
: number of MP IRQ sources: 17.
: number of IO-APIC #2 registers: 24.
: testing the IO APIC.......................
:
: IO APIC #2......
: .... register #00: 02000000
: .......    : physical APIC id: 02
: .......    : Delivery Type: 0
: .......    : LTS          : 0
: .... register #01: 00178000
: .......     : max redirection entries: 0017
: .......     : PRQ implemented: 1
: .......     : IO APIC version: 0000
:  WARNING: unexpected IO-APIC, please mail
:           to linux-smp@vger.kernel.org
: .... IRQ redirection table:
:  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
:  00 000 00  1    0    0   0   0    0    0    00
:  01 001 01  0    0    0   0   0    1    1    39
:  02 001 01  0    0    0   0   0    1    1    31
:  03 001 01  0    0    0   0   0    1    1    41
:  04 001 01  0    0    0   0   0    1    1    49
:  05 001 01  0    0    0   0   0    1    1    51
:  06 001 01  0    0    0   0   0    1    1    59
:  07 001 01  0    0    0   0   0    1    1    61
:  08 001 01  0    0    0   0   0    1    1    69
:  09 001 01  0    0    0   0   0    1    1    71
:  0a 001 01  0    0    0   0   0    1    1    79
:  0b 001 01  0    0    0   0   0    1    1    81
:  0c 001 01  0    0    0   0   0    1    1    89
:  0d 001 01  0    0    0   0   0    1    1    91
:  0e 001 01  0    0    0   0   0    1    1    99
:  0f 001 01  0    0    0   0   0    1    1    A1
:  10 000 00  1    0    0   0   0    0    0    00
:  11 000 00  1    0    0   0   0    0    0    00
:  12 000 00  1    0    0   0   0    0    0    00
:  13 000 00  1    0    0   0   0    0    0    00
:  14 001 01  1    1    0   1   0    1    1    71
:  15 000 00  1    0    0   0   0    0    0    00
:  16 000 00  1    0    0   0   0    0    0    00
:  17 000 00  1    0    0   0   0    0    0    00
: IRQ to pin mappings:
: IRQ0 -> 0:2
: IRQ1 -> 0:1
: IRQ3 -> 0:3
: IRQ4 -> 0:4
: IRQ5 -> 0:5
: IRQ6 -> 0:6
: IRQ7 -> 0:7
: IRQ8 -> 0:8
: IRQ9 -> 0:9-> 0:20
: IRQ10 -> 0:10
: IRQ11 -> 0:11
: IRQ12 -> 0:12
: IRQ13 -> 0:13
: IRQ14 -> 0:14
: IRQ15 -> 0:15
: .................................... done.
: Using local APIC timer interrupts.
: calibrating APIC timer ...
: ..... CPU clock speed is 2659.0663 MHz.
: ..... host bus clock speed is 132.0983 MHz. 


Is anything wrong with this?
thank you very much for reading/replying 
