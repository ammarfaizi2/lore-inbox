Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129478AbRCBWip>; Fri, 2 Mar 2001 17:38:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129581AbRCBWif>; Fri, 2 Mar 2001 17:38:35 -0500
Received: from b1.ovh.net ([213.186.33.51]:18161 "HELO ns0.ovh.net")
	by vger.kernel.org with SMTP id <S129478AbRCBWi0>;
	Fri, 2 Mar 2001 17:38:26 -0500
From: "Stéphane GARIN" <sgarin@sgarin.com>
To: <linux-kernel@vger.kernel.org>
Subject: 2.2.19pre - Kernel Panic: no init found
Date: Fri, 2 Mar 2001 23:36:56 +0100
Message-ID: <002501c0a369$4abe8f70$4601a8c0@oracle.intranet>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.3612.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a kernel panic with the patch 2.2.19pre16 that I test. I use a 2.2.18
Kernel very well. I used the last patch on this kernel and make my kernel
with sames parameters without error message. At the boot, I can see this :

...
eth0: RealTek RTL8139 Fast Ethernet at 0xa800, IRQ 10, 00:50:fc:0b:60:70
eth1: RealTek RTL8139 Fast Ethernet at 0xac00, IRQ 11, 00:50:fc:1f:c1:98
Partition check:
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 hda10 >
Trying to vfree() noexistent vm area (c00f0000)
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 68k freed
Kernel panic: No init found. Try passing init= option to kernel.



I tried to start with init=3 but no change. I send this information on this
mailing list because I think that could be a bug. Sorry if it is a wrong
action of me...

With Regards,
Stephane Garin

