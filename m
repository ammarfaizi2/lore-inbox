Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264161AbSIVJhS>; Sun, 22 Sep 2002 05:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264261AbSIVJhS>; Sun, 22 Sep 2002 05:37:18 -0400
Received: from f138.law12.hotmail.com ([64.4.19.138]:27140 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S264161AbSIVJhR>;
	Sun, 22 Sep 2002 05:37:17 -0400
X-Originating-IP: [203.149.1.103]
From: "walairat kladmuk" <praduddao@hotmail.com>
To: linux-kernel@vger.kernel.org
Cc: dominicscaife@yahoo.com
Subject: Kernel Issues
Date: Sun, 22 Sep 2002 09:42:21 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F138D7O5CkJNQNXSqVd00002250@hotmail.com>
X-OriginalArrivalTime: 22 Sep 2002 09:42:21.0592 (UTC) FILETIME=[59425180:01C2621C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have a problem installing Mandrake 8.2.

Installation appears to work fine but when I try and boot the system the 
following is a copy of the kernel messages as boot fails (last 8 lines)

PCI <something>
PCI <something>
PCI <something>
PCI <something>
Isapnp: Scanning for PnP Cards
CPU0: Machine Check Exception: 00000000000000000007
Bank 3: b40000000000000000000083b at 0000000000000001fc0003b3
Kernel Panic: Unable to continue

Having played around with numerous installation techniques (full/min, 
various partition configs/types) over the last 4 days I haven't made any 
progress.

I even tried Red Hat 7.3 (Valhalla) and the same happened.

I built the system last week.
Here is an outline of my system:

Motherboard:
http://www.octek.com.hk/products/ATI/ati13xp-mse.htm

CPU:
AMD Athlon 1.6 XP

RAM:
256MB 266 DDR one module (1 free)

HD:
Seagate 40MB

CDROM:
LG DVD Drive

No PCI Cards mounted or AGP cards.

Sound and Video is onboard, see http above for details.

In my exploring of the installation via the rescue mode, I noticed the 
Config file in boot and was wondering how this is used? Is this only used 
when compiling the kernel or would changes make any difference now? A few of 
the switches looked promising to try playing with but since I am not really 
sure where to start compiling the kernel some advice here would help. Where 
do I find documentation on what each config_Switch in the config file does 
for example?

The third party kernel modules that are asked for when installing might also 
be worth a try... advice here appreciated.

My gut feeling is that given the error message the boot fails when looking 
for an ISApnp card... my motherboard is very new 
(http://www.octek.com.hk/products/ATI/ati13xp-mse.htm) and doesn't have an 
ISA slot.

Can anyone offer me a little advice here?  Is there any way to do it without 
having to recompile the kernel? (Not done this before relatively new to 
Linux, though I have plenty of time to burn :)

D Scaife
dominicscaife@yahoo.com (yahoo only sends html style mail which list sees as 
spam hence the reason this comes from elsewhere)

p.s. Also played with the System.map and tried deleting all those lines 
beginning with isapnp... no luck... these are shots in the dark :)ut feeling 
is that given the error message the boot fails when looking for an ISApnp 
card... my motherboard is very new (see profile) and doesn't have an ISA 
slot.


_________________________________________________________________
MSN Photos is the easiest way to share and print your photos: 
http://photos.msn.com/support/worldwide.aspx

