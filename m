Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267539AbSKQSBh>; Sun, 17 Nov 2002 13:01:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267541AbSKQSBh>; Sun, 17 Nov 2002 13:01:37 -0500
Received: from hera.cwi.nl ([192.16.191.8]:31447 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S267539AbSKQSBf>;
	Sun, 17 Nov 2002 13:01:35 -0500
From: Andries.Brouwer@cwi.nl
Date: Sun, 17 Nov 2002 19:08:30 +0100 (MET)
Message-Id: <UTC200211171808.gAHI8U714878.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, jgarzik@pobox.com, mzyngier@freesurf.fr
Subject: Re: [PATCH] sysfs stuff for eisa bus [1/3]
Cc: aebr@win.tue.nl, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       willy@debian.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(i) Continuing the collection of EISA IDs a bit:

52a53
> AIM0002 "AUVA OPTi/EISA 32-Bit 486 All-in-One System Board"
89a91
> AMI44C1 "AMI SCSI Host Adapter - Series 44"
631a634
> INP0010 "Barracuda E/4810"
967c970
< MLX0040 "Mylex GXE020B EISA 32-Bit Graphics Controller"
---
> MLX0040 "Mylex GXE020B or GXE020C EISA 32-Bit Graphics Controller"
969a973
> MLX0071 "Mylex DAC960 EISA Disk Array Controller (3-channel)"
972c976
< MLX0074 "DAC960 EISA Disk Array Controller (1-channel)"
---
> MLX0074 "Mylex DAC960 EISA Disk Array Controller (1-channel)"
975a980
> MLX0101 "Mylex LME596 EISA 32-bit 4 Channel Ethernet LAN Adapter"
979a985
> MTX2040 "MATROX IM-1280/EISA"
980a987,1000
> NIC0202 "AT-MIO-16 Multi-function Board"
> NIC0301 "AT-DIO-32F Digital I/O Board"
> NIC0400 "PC-DIO-24 Digital I/O Board"
> NIC0501 "LAB-PC/LAB-PC+ Multi-function Board"
> NIC0602 "AT-MIO-16F-5 Multi-function Board"
> NIC0700 "PC-DIO-96 Digital I/O Board"
> NIC0800 "PC-LPM-16 Low Power Multi-function Board"
> NIC0900 "PC-TIO-10 Timing I/O Board"
> NIC1000 "AT-A2150 16-bit 4 Channel A/D Board"
> NIC1100 "AT-DSP2200 DSP Accelerator/Audio I/O Board"
> NIC1200 "AT-AO-6/10 ANALOG OUTPUT BOARD"
> NIC1300 "AT-MIO-16X Multi-function Board"
> NIC1400 "AT-MIO-64F-5 Multi-function Board"
> NIC1500 "AT-MIO-16D Multi-function Board"
981a1002,1003
> NICC105 "National Instruments GPIB-PCIIA Interface Board"
> NICC205 "National Instruments GPIB-PCII Interface Board"
1018a1041,1045
> SEC0010 "SAMSUNG ISA Multifunction Card"
> SEC0020 "SAMSUNG VGA Card (GTI VC-004)"
> SEC0021 "WD 90C31 Local Bus VGA"
> SECFF01 "SAMSUNG MAE486 System Board"
> SECFF02 "OPTi/EISA 32-Bit 486 System Board"
1029a1057
> SMCA010 "SMC Ether 10/100"
1074a1103
> TRM0320 "DC-320 EISA SCSI Host Adapter"
1075a1105,1107
> TRM0820 "DC-820 EISA SCSI Cache Host Adapter"
> TRM320E "DC-320E EISA SCSI Host Adapter"
> TRM820B "DC-820B EISA SCSI Cache Host Adapter"


(ii) I asked:

    [In the eisa list we see that ISAAB01 is a "HAYES Smartmodem 1200B".
    My ISAAB01 however is a "Hayes Smartmodem 2400B". What do you print?]

but the answer is of course "nothing" - I should have taken a different
example. These ISA.... numbers are for ISA cards, and one cannot read
their ID, so the kernel (or a utility) will never encounter such numbers.
Corresponding strings are just dead code.

More generally, for quite a lot of EISA cards, maybe more than half,
the ID cannot be read. My list of EISA cards that have a readable ID
has length 312.

Andries


