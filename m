Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312704AbSCZUcX>; Tue, 26 Mar 2002 15:32:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312680AbSCZUcM>; Tue, 26 Mar 2002 15:32:12 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:43268
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S312706AbSCZUcB>; Tue, 26 Mar 2002 15:32:01 -0500
Date: Tue, 26 Mar 2002 12:31:45 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Kai-Boris Schad <kschad@correo.e-technik.uni-ulm.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.17 with VT8367 [KT266] crashes on heavy ide load
 togeter with heavy network load
In-Reply-To: <200203261127.MAA05078@correo.e-technik.uni-ulm.de>
Message-ID: <Pine.LNX.4.10.10203261229080.2450-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is an identical problem I am seeing w/ VIA and any add on card.

Everybody and their brother is attempting NAS with cheap VIA boards and
addon cards and they go south and die.

http://www.tecchannel.de/hardware/817/index.html

This is one of the better explaination why :-/

Regards,

Andre Hedrick
LAD Storage Consulting Group



On Tue, 26 Mar 2002, Kai-Boris Schad wrote:

> Hi !
> 
> I have problems with PC mainboard using the Via VT8367 [KT266] chipset.  
> lspci shows the configuration:
> lspci
> 00:00.0 Host bridge: VIA Technologies, Inc. VT8367 [KT266]
> 00:01.0 PCI bridge: VIA Technologies, Inc. VT8367 [KT266 AGP]
> 00:0c.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
> 00:0e.0 Unknown mass storage controller: Promise Technology, Inc. 20268 (rev 
> 01)00:0f.0 Unknown mass storage controller: Promise Technology, Inc. 20268 
> (rev 01)00:11.0 ISA bridge: VIA Technologies, Inc. VT8233 PCI to ISA Bridge
> 00:11.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
> 01:00.0 VGA compatible controller: ATI Technologies Inc Rage XL AGP (rev 27)
> 
> The CPU is a 1400MHz Athlon. 
> We use this system for a software Raid 5. If we produce heavy load on the 
> disks and network the system hangs. There is no log of errors at all. We 
> tried to change the network card form a 3com to a rtl83xx. The system remains 
> a litle longer stable but crashes then too. We also tried to have the 
> harddisks on seperate ide channels but this didn't solve the crashs. 
> It seems to be something with the dma, because if we disable the dma of the 
> harddisks the system is stable. Does anybody also recognise this problem ?
> Is there any solution for this effect ?
> 
> Thanks a lot 
> 
> Kai
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


