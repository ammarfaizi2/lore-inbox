Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262170AbRF1UeG>; Thu, 28 Jun 2001 16:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262607AbRF1Ud4>; Thu, 28 Jun 2001 16:33:56 -0400
Received: from dfw-smtpout1.email.verio.net ([129.250.36.41]:14773 "EHLO
	dfw-smtpout1.email.verio.net") by vger.kernel.org with ESMTP
	id <S262170AbRF1Udr>; Thu, 28 Jun 2001 16:33:47 -0400
Message-ID: <3B3B94A6.455C3834@bigfoot.com>
Date: Thu, 28 Jun 2001 13:33:42 -0700
From: Tim Moore <timothymoore@bigfoot.com>
Organization: Yoyodyne Propulsion Systems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.20p6ai i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: joeja@mindspring.com, Dave Jones <davej@suse.de>
Subject: Re: AMD thunderbird oops
In-Reply-To: <Springmail.105.993672371.0.48374000@www.springmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

joeja@mindspring.com wrote:
> 
> Well considering the other night the power supply went dead, I think that is part of the problem.  It is brand new, and I am being sent another one (free of course).
> 
> I also had my mb loaded at the time (scsi cd-rw, cdrom, internal zip, floppy, 1 hd, Sound card, video, modem, NIC, scsi card) but my last tyan was fine with that load it may be a kt7a thing.
> 
> Several people said that random (keyword here) oopses are more often a hardware thing.  I wonder if the kt7a is going to be able to perform  fully loaded..
> 
> is anyone running one fully loaded? 4 ide drives, 2 floppy, (5 pci and 1 isa) or 6pci, agp, 512MEG+ RAM?
> 
> Joe

Similar board (KA7) had non-heat related lockups with 133MHz FSB (1756
BogoM).  100MHz FSB + 4 way interleave has been fast and stable (1690
BogoM).

/dev/hda:
 Timing buffer-cache reads:   128 MB in  1.00 seconds =128.00 MB/sec

Abit KA7 (VT82C686a, rev 22), Athlon 850, 2x256MB PC133@CL2, 2 ide,
CR-RW, Colorado Travan, linux 2.2.20p6+ide.2.2.19.04092001, SPI 300W
power, PCI: Firewire, Netgear FA310TX, Turtle Beach Santa Cruz audio,
AGP: 32MB TNT2.

CONFIG_M686=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_1GB=y
CONFIG_MTRR=y

--
