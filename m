Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262356AbRERPuD>; Fri, 18 May 2001 11:50:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262343AbRERPtn>; Fri, 18 May 2001 11:49:43 -0400
Received: from dirac.dina.kvl.dk ([130.225.40.191]:43531 "EHLO
	dirac.dina.kvl.dk") by vger.kernel.org with ESMTP
	id <S262356AbRERPtk>; Fri, 18 May 2001 11:49:40 -0400
Date: Fri, 18 May 2001 17:49:33 +0200 (CEST)
From: "Thomas S. Iversen" <thomassi@dina.kvl.dk>
To: linux-kernel@vger.kernel.org
Subject: PIO mode support for 82371mx?
Message-ID: <Pine.LNX.4.21.0105181748190.3316-100000@dirac.dina.kvl.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi 

I was just wondering if there is any support for the 82371mx accelerator
in the IDE driver. It doesn't appear that way to me, but that can be my
fault :)

Just to be precise. I'm talking about this chip:

  ftp://download.intel.com/support/chipsets/430mx/290525.pdf

I have tried stock debian 2.2 kernel (2.2.18.preX) and the harddrive is
detected as a standard drive:
   ide0 at 0x1f0-0x1f7, 0x3f6 on irq 14

A "hdparm -p /dev/hda" gives:

   HDIO_SET_PIO_MODE failed: Function not implemented

Compiling a new kernel my self didn't yield anything different!! Skimming
through the sources gave me the impression that there isn't support for
this particular IDE chipset.

cat /proc/pci gives:

....

Bus 0, device 1, function 0:
  Bridge: Intel 430MX - 82371MX MPIIX (rev 2)
    Medium devsel. Fast back-to-back capable. Master Capable. No bursts.

Can you help me out?? Anything wrong, or am I just not supposed to tune
the PIO modes on this laptop.

Regards Thomas






