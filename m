Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932345AbWEDPx5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345AbWEDPx5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 11:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932346AbWEDPx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 11:53:57 -0400
Received: from imo-m25.mx.aol.com ([64.12.137.6]:22714 "EHLO
	imo-m25.mx.aol.com") by vger.kernel.org with ESMTP id S932345AbWEDPx5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 11:53:57 -0400
Message-ID: <445A238A.8040705@aol.com>
Date: Thu, 04 May 2006 11:53:46 -0400
From: andy liebman <andyliebman@aol.com>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Boot Halts with "Scheduling while atomic:  ksoftirqd"
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AOL-IP: 146.115.27.35
X-Mailer: Unknown (No Version)
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have seen a few similar postings on the kernel list. Occassionally -- 
like one time out of every 40 -- my machines with SATA OS drives stop 
booting early in the boot process.

The last messages on the boot screen are approximately:

ata1:  SATA MAX UDMA/133 .... irq 17
ata2:  SATA MAX UDMA/133 .... irq 17
ata1:  dev 0 ATA
ata1:  dev 0 configured for UDMA/133
scsi0: ata_piix
ata2:  SATA port has no device
scsi: ata_piix
    Vender:  ATA   Model:  Maxtor
    Type:  Direct Access
Scheduling while atomic: ksoftirqd/0/0x00000100/3
[<c02dd460>] schedule+0x990/0xd0b
[<01745d3>] dput+0xf4/0x20b

Then the boot stops.

I am running the 2.6.14.6 kernel.  Has this issue been fixed since then? 
Thanks in advance for the reply.

Andy Liebman


