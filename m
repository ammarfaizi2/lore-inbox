Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266805AbSKUQRe>; Thu, 21 Nov 2002 11:17:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266806AbSKUQRe>; Thu, 21 Nov 2002 11:17:34 -0500
Received: from [207.61.129.108] ([207.61.129.108]:684 "EHLO mail.datawire.net")
	by vger.kernel.org with ESMTP id <S266805AbSKUQRa> convert rfc822-to-8bit;
	Thu, 21 Nov 2002 11:17:30 -0500
From: Shawn Starr <shawn.starr@datawire.net>
Organization: Datawire Communication Networks Inc.
To: linux-kernel@vger.kernel.org
Subject: Re: A7M266-D
Date: Thu, 21 Nov 2002 11:24:36 -0500
User-Agent: KMail/1.4.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200211211124.36280.shawn.starr@datawire.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Works fine in 2.4.18+ (since I had the machine only durning 2.4.18).

Shawn.

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of jan
Sent: Thursday, November 21, 2002 8:34 AM
To: linux-kernel@vger.kernel.org
Subject: A7M266-D

dear list,

i have an A7M266-D board with two AMD Athlon MP 2000+ on it.
Unfortunately I am unable to compile the correct driver for the AM7441 
IDE Controller (using 2.4.19)
I always get this under SuSE :

AMD7441: detected chipset, but driver not compiled in!

When using a precompiled SUSE or RedHat Kernel it gets recognized.



SuSE Linux 2.4.18-64GB-SMP output :

AMD_IDE: IDE controller on PCI bus 00 dev 39
AMD_IDE: chipset revision 4
AMD_IDE: not 100% native mode: will probe irqs later
AMD_IDE: AMD-768 Opus (rev 04) IDE UDMA100 controller on pci00:07.1
     ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:pio, hdd:pio

RedHat 2.4.18-14smp output :

AMD7441: IDE controller on PCI bus 00 dev 39
AMD7441: chipset revision 4
AMD7441: not 100% native mode: will probe irqs later
AMD7441: disabling single-word DMA support (revision < C4)
     ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:pio


What am I doing wrong ? and why RedHat and SuSE Kernel have no Problem 
with this Chipset ?


best regards,


Jan
-- 
Shawn Starr
UNIX Systems Administrator, Operations
Datawire Communication Networks Inc.
10 Carlson Court, Suite 300
Toronto, ON, M9W 6L2
T: 416-213-2001 ext 179  F: 416-213-2008
shawn.starr@datawire.net
"The power to Transact" - http://www.datawire.net

