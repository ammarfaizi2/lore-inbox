Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262042AbVFWESE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262042AbVFWESE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 00:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262057AbVFWESE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 00:18:04 -0400
Received: from wproxy.gmail.com ([64.233.184.203]:30068 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262042AbVFWER7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 00:17:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=OeVK2LqDm/syKTQVApbBuyKMHjuuNEkr+8pbAgxdErqamek7o8xY/XIf1xBgojEYfEzrgMp+zR1bfD/QAUkcLA6OhC7p2vv8gduuF30zF0Zl7Ve7hVwAla/YtFVFpxJAgMiUGKjbJ1BtDO3IvTtDFRpm+sUHT9ZlU5yrDur5vMw=
Message-ID: <d73ab4d005062221176e77a960@mail.gmail.com>
Date: Thu, 23 Jun 2005 12:17:58 +0800
From: guorke <gourke@gmail.com>
Reply-To: guorke <gourke@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.12 can not support via rhine?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi
when i reboot use 2.6.11,it's ok.
but when i use 2.6.12 kernel, i get this:

via rhine device dose not seem to be present , delaying eth0 initialzation..
but in 2.6.11, it's say ok, I must say i have add via rhine support.
this following is difference output demsg :
diff -y dmesg_2.6.11 dmesg_2.6.12

VFS: Mounted root (ext3 filesystem) readonly.                   VFS:
Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 220k freed                      |
Freeing unused kernel memory: 224k freed
kjournald starting.  Commit interval 5 seconds                <
EXT3 FS on hda1, internal journal                               EXT3
FS on hda1, internal journal
Adding 265064k swap on /dev/hda2.  Priority:-1 extents:1        Adding
265064k swap on /dev/hda2.  Priority:-1 extents:1
via-rhine.c:v1.10-LK1.2.0-2.6 June-10-2004 Written by Donald  <
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 12             <
PCI: setting IRQ 12 as level-triggered                        <
ACPI: PCI interrupt 0000:00:09.0[A] -> GSI 12 (level, low) -> <
eth0: VIA Rhine II at 0x1e800, 00:05:5d:fb:7d:29, IRQ 12.     <
eth0: MII PHY found at address 8, status 0x782d advertising 0 <
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1               <

like no via rhine.

Thanks
