Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266363AbUBFDYb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 22:24:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266343AbUBFDYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 22:24:30 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:41659 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S266340AbUBFDWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 22:22:34 -0500
From: Michael Frank <mhf@linuxmail.org>
To: linux-kernel@vger.kernel.org
Subject: 2.4.24 HIGHMEM=300m: BUG: wrong zone alignment, it will crash
Date: Fri, 6 Feb 2004 11:21:34 +0800
User-Agent: KMail/1.5.4
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402061121.34174.mhf@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

System has 500M RAM. When using highmem=300m dmesg as follows.

Linux version 2.4.24-mhf168 (root@mhfl4) (gcc version 2.95.3 20010315 (release)) #2 Fri Feb 6 11:08:28 HKT 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001eff0000 (usable)
 BIOS-e820: 000000001eff0000 - 000000001eff3000 (ACPI NVS)
 BIOS-e820: 000000001eff3000 - 000000001f000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
300MB HIGHMEM available.
195MB LOWMEM available.
On node 0 totalpages: 126960
zone(0): 4096 pages.
zone(1): 46064 pages.
zone(2): 76800 pages.
BUG: wrong zone alignment, it will crash
Kernel command line: vga=0xf07 root=/dev/hda4 resume2=swap:/dev/hda1 console=tty0 console=ttyS0,115200n8r devfs=nomount nousb acpi=off highmem=300m

What went wrong ?

Michael

