Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750843AbVICKK4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750843AbVICKK4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 06:10:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161202AbVICKK4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 06:10:56 -0400
Received: from 59-171-177-165.rev.home.ne.jp ([59.171.177.165]:19072 "EHLO
	localhost") by vger.kernel.org with ESMTP id S1750843AbVICKK4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 06:10:56 -0400
Date: Sat, 03 Sep 2005 19:10:53 +0900 (JST)
Message-Id: <20050903.191053.-1350500431.whatisthis@jcom.home.ne.jp>
To: spam.david.trap@unsolicited.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [x86_64] Exception when using powernowd.
From: Kyuma Ohta <whatisthis@jcom.home.ne.jp>
In-Reply-To: <43195FF4.7000207@unsolicited.net>
References: <20050903.021820.1300541056.whatisthis@jcom.home.ne.jp>
	<43195FF4.7000207@unsolicited.net>
X-Mailer: Mew version 4.2.52 on Emacs 22.0.50 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanx David,

Written by David Ranson <spam.david.trap@unsolicited.net>
   at Sat, 03 Sep 2005 09:33:56 +0100 :
Subject: Re: [x86_64] Exception when using powernowd.

spam.david.trap> Kyuma Ohta wrote:
spam.david.trap> 
spam.david.trap> 
spam.david.trap> >>Hi,
spam.david.trap> >>
spam.david.trap> >>I'm using MSI K8T Neo2 (VIA K8T800 chipset) and Athlon64 3000+
spam.david.trap> >>with  linux x86_64 2.6.13 kernel and Debian/sid.
spam.david.trap> >>  
spam.david.trap> >>
spam.david.trap> >  
spam.david.trap> >
spam.david.trap> I'm using a K8T Neo2 FIR with the same processor and powernow-k8. Up
spam.david.trap> with 2.6.13 since Sunday, no problems noted. Mine is a SuSE 9.1 based
spam.david.trap> system though.
spam.david.trap> 
spam.david.trap> Maybe BIOS related??

I thought this problem,too.

But,I was upgrade BIOS from v3.3 to v9.2,this issue has happened yet.

# And,I have to put "pnpacpi=off" to kernel boot line to 
# use w83627ths sensor (-_-;

When upgrade X 6.8.2-4 to 6.8.2-5(or after),this issue has often happend.
I'm using nVidia Geforce 5200 as Display adapter,but this issue
has happend bot Debian's driver and nVidia's driver.

What's wrong?

For relate,I put result of "lspci" on this machine below.

Ohta.
--
0000:00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0282
0000:00:00.1 Host bridge: VIA Technologies, Inc.: Unknown device 1282
0000:00:00.2 Host bridge: VIA Technologies, Inc.: Unknown device 2282
0000:00:00.3 Host bridge: VIA Technologies, Inc.: Unknown device 3282
0000:00:00.4 Host bridge: VIA Technologies, Inc.: Unknown device 4282
0000:00:00.7 Host bridge: VIA Technologies, Inc.: Unknown device 7282
0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI bridge [K8T800 South]
0000:00:07.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 46)
0000:00:08.0 Multimedia video controller: Internext Compression Inc iTVC16 (CX23416) MPEG-2 Encoder (rev 01)
0000:00:0a.0 Multimedia controller: Philips Semiconductors SAA7134 (rev 01)
0000:00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8169 Gigabit Ethernet (rev 10)
0000:00:0f.0 IDE interface: VIA Technologies, Inc. VIA VT6420 SATA RAID Controller (rev 80)
0000:00:0f.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
0000:00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
0000:00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86)
0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge [K8T800 South]
0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:01:00.0 VGA compatible controller: nVidia Corporation NV34 [GeForce FX 5200] (rev a1)
