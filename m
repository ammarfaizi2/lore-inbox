Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312465AbSCZUmc>; Tue, 26 Mar 2002 15:42:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312474AbSCZUmX>; Tue, 26 Mar 2002 15:42:23 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:46084
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S312465AbSCZUmM>; Tue, 26 Mar 2002 15:42:12 -0500
Date: Tue, 26 Mar 2002 12:42:03 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Kai-Boris Schad <kschad@correo.e-technik.uni-ulm.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Update: Kernel 2.4.17/19-pre4  with VT8367 [KT266] crashes on
 heavy ide load togeter with heavy network load
In-Reply-To: <200203261904.UAA08226@correo.e-technik.uni-ulm.de>
Message-ID: <Pine.LNX.4.10.10203261241130.2450-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


00:00.0 Host bridge: VIA Technologies, Inc. VT8367 [KT266]
00:01.0 PCI bridge: VIA Technologies, Inc. VT8367 [KT266 AGP]
00:08.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
00:0b.0 RAID bus controller: HighPoint Technologies, Inc.: Unknown device 0008 (rev 07)
00:0b.1 RAID bus controller: HighPoint Technologies, Inc.: Unknown device 0008 (rev 07)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8233 PCI to ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] 86C326 (rev 0b)

Nope I can crash it randomly  :-/


On Tue, 26 Mar 2002, Kai-Boris Schad wrote:

> Hi !
> 
> First thanks a lot for the good ideas and comments on my previous posting. I 
> updated the kernel to 2.4.19-pre4 and it seem's to improve the situation. 
> There  was no crash with the RTL Network Card but the system response boged 
> down sometimes for a few (up to 10) seconds. Then I tried the same togeter 
> with the "3com 3c905C" networkcard and the system hung a few seconds after 
> starting the copy-commands "dd count=16M if=/dev/zero of=/home/test0&" and
>  "cp /home/zero /dev/null&" and "ico" on an remote terminal for network load. 
> Thus my personal work arround would be to use the rtl network card - but 
> there remains this problem.
> 
> Kai
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

