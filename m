Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265374AbUBFKfO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 05:35:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265383AbUBFKfO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 05:35:14 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:53226 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S265374AbUBFKfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 05:35:07 -0500
From: Michael Frank <mhf@linuxmail.org>
To: linux-kernel@vger.kernel.org
Subject: 2.4.25-rc1: BUG: wrong zone alignment, it will crash
Date: Fri, 6 Feb 2004 18:34:08 +0800
User-Agent: KMail/1.5.4
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200402061735.07726.mhf@linuxmail.org>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As with 2.4.24, using the highmem option causes the BUG message.

This is a kernel ex BK without any patches.

Linux version 2.4.25-rc1 (root@mhfl4) (gcc version 2.95.3 20010315 (release)) #5 Fri Feb 6 17:27:18 HKT 2004
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
Kernel command line: vga=0xf07 root=/dev/hda4 console=tty0 console=ttyS0,115200n8r devfs=nomount nousb acpi=off highmem=300m
Initializing CPU#0
Detected 2399.771 MHz processor.
Console: colour VGA+ 80x60
Calibrating delay loop... 4784.12 BogoMIPS
Memory: 498696k/507840k available (1589k kernel code, 8756k reserved, 676k data, 120k init, 307200k highmem)

The kernel seems to experience stability problems.

How to resolve?

Michael

