Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310515AbSCPSHd>; Sat, 16 Mar 2002 13:07:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310516AbSCPSHX>; Sat, 16 Mar 2002 13:07:23 -0500
Received: from web10506.mail.yahoo.com ([216.136.130.156]:13687 "HELO
	web10506.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S310515AbSCPSHH>; Sat, 16 Mar 2002 13:07:07 -0500
Message-ID: <20020316180705.34916.qmail@web10506.mail.yahoo.com>
Date: Sat, 16 Mar 2002 10:07:05 -0800 (PST)
From: S W <egberts@yahoo.com>
Subject: 2.4.19-pre2 Cyrix III SEGFAULT (Cyrix II redux?)
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In compiling the kernel, I've been experiencing the
same gcc-2.96 (and gcc-3.0+) SEGFAULT again on Cyrix
III GigaPro (733Mhz, Samuel II core chipset).

But I recalled Linux 2.2 having a bug fix for broken
L2 cache in Cyrix II.  So, it got me thinking again...
(did Cyrix fix this L2 cache in certain subsequential
core?)

Does anyone recall where exactly are the Cyrix II L2
cache bug fix in the kernelso that I can experiement
them toward the Cyrix III?

Assuming no else sees VM bugs, I'll assume that this
is Cyrix-specific.  I've seen various VM BUGs for each
patch releases since 2.4.17 particularly when
compiling.

MOBO DETAILS:
Soyo 7VEM motherboard (686A PL133, despite having an
ALL VIA-chipsets (Cyrix III-733Mhz, VIA-VT82C596A
multifunctional audio/AGPvideo/modem, Rhine Ethernet,
Trident APG), no drivers are loaded into the kernel
except for EXT2, Trident Video (no framebuffer
support) and IDE (via82cxxx.c).  BARE KERNEL.  (BTW,
it was a $250 Fry's special running a barebone
multimedia Linux, so no snickering please.).

Passed memtest86.

__________________________________________________
Do You Yahoo!?
Yahoo! Sports - live college hoops coverage
http://sports.yahoo.com/
