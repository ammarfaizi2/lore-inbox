Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315272AbSEONtO>; Wed, 15 May 2002 09:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315407AbSEONtN>; Wed, 15 May 2002 09:49:13 -0400
Received: from sprocket.loran.com ([209.167.240.9]:2045 "EHLO
	ottonexc1.peregrine.com") by vger.kernel.org with ESMTP
	id <S315272AbSEONtN>; Wed, 15 May 2002 09:49:13 -0400
Subject: AIC7xxx in 2.4.19-pre8?
From: Dana Lacoste <dana.lacoste@peregrine.com>
To: linux-kernel@vger.kernel.org
Cc: aic7xxx@freebsd.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 15 May 2002 09:49:12 -0400
Message-Id: <1021470553.28001.37.camel@dlacoste.ottawa.loran.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Kernel version is 2.4.19-pre8.  Let me know if you want more info :)

(Motherboard is Nexcom Peak 632 : 440BX with Adaptec 7890U2)

I'm getting (over and over and over and over) the message from line
1854 of drivers/scsi/aic7xxx/aic7xxx_pci.c :

scsi0: PCI error Interrupt at seqaddr = 0x8
scsi0: PCI error Interrupt at seqaddr = 0x9

(0x9 is more common, no pattern detected between 0x8 and 0x9)

It's interlaced with :
scsi0: Received a Target Abort

which means the status1 flag RTA was set, but I'm now officially out
of my league :)

This box was going fine till this morning (we upgraded from 2.4.18
last night) and a second box we did the same thing to also had the
same problem, so it looks like a kernel issue somehow, not just
faulty hardware.  Retrograding to 2.4.18 caused the problem to go
away.

Has anyone else seen this?
(or if you have suggestions, please let me know!)
 
Dana Lacoste
Ottawa, Canada

