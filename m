Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261767AbTDOQPH (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 12:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbTDOQPH 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 12:15:07 -0400
Received: from web41813.mail.yahoo.com ([66.218.93.147]:55693 "HELO
	web41813.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261767AbTDOQPG (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 12:15:06 -0400
Message-ID: <20030415162652.80297.qmail@web41813.mail.yahoo.com>
Date: Tue, 15 Apr 2003 09:26:52 -0700 (PDT)
From: Christian Staudenmayer <eggdropfan@yahoo.com>
Subject: warnings when booting 2.5.67 or 2.4.21-pre7
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,


1) i get the following warnings when booting up kernel versions 2.5.67 or 2.4.21-pre7,
the bootup with 2.4.20 doesn't show these warnings.

ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hda: task_no_data_intr: error=0x10 { SectorIdNotFound }, LBAsect=0, sector=0
hda: 2116800 sectors (1084 MB) w/128KiB Cache, CHS=2100/16/63
 hda: hda1 hda2
hdb: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hdb: task_no_data_intr: error=0x04 { DriveStatusError }
hdb: 2358720 sectors (1208 MB) w/109KiB Cache, CHS=2340/16/63
 hdb: hdb4
hdc: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hdc: task_no_data_intr: error=0x04 { DriveStatusError }
hdc: 4124736 sectors (2112 MB) w/128KiB Cache, CHS=4092/16/63
 hdc: hdc1
hdd: ATAPI 48X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.12

i didn't test it extensively, but the behaviour of the system doesn't seem to be affected by
this problem. i'd still be happy for any hints on what may be wrong.

2) when booting 2.5.67 i get lots of warning messages, for example complaining about obsolete
functions, or when i run "top" it tells me "Unknow HZ value! (83) Assume 100.
i'll post some of the boot-up warnings here:

PCI: Enabling device 00:0a.0 (0006 -> 0007)
PCI: Unable to reserve mem region #2:1000@eb001000 for device 00:0a.0
PCI: Unable to reserve mem region #2:1000@eb001000 for device 00:0a.0

process `named' is using obsolete setsockopt SO_BSDCOMPAT
(this is shown 5 times)

note: the pci error dissappears when using the option acpi=off

now to my question: is that just normal when running a beta kernel or shouldn't these
be there? if so, how can i fix it?

thanks in advance!

greetings, chris



__________________________________________________
Do you Yahoo!?
Yahoo! Platinum - Watch CBS' NCAA March Madness, live on your desktop!
http://platinum.yahoo.com
