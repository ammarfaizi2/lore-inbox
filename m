Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751489AbWFPQs3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489AbWFPQs3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 12:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751491AbWFPQs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 12:48:29 -0400
Received: from web33514.mail.mud.yahoo.com ([68.142.206.163]:38768 "HELO
	web33514.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751489AbWFPQs2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 12:48:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=3t03u/0s3aMVlE97OeCNvFZaFDyTMvTrBgL7lcT52xG7QlMQWLqtBO6NJ6FNytuWyHqy5EDC0ZwGgbFg/I57Oc7BtdzMxCQB5LZ08PoLwnQog9bcfFTBdASIB1KrxWJIDr/Gx0pDnMhlkWdqRbjKrxUGqzwsqB82F7SsNNEgRMk=  ;
Message-ID: <20060616164827.18258.qmail@web33514.mail.mud.yahoo.com>
Date: Fri, 16 Jun 2006 09:48:27 -0700 (PDT)
From: Narendra Hadke <nhadke@yahoo.com>
Subject: sata_mv driver on 88sx6041 (kernel version 2.6.13)
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I am using sata_mv driver as exists in kernel 2.6.13,
reached to a stage where after detecting the disk,
control gets struck. Any ideas? 
  I see this driver is modified a lot in latest kernel
version. Will it help to patch with latest changes.
Apreciate your help.

Here is the log:

........
........
RAMDISK driver initialized: 1 RAM disks of 500000K
size 1024 blocksize
loop: loaded (max 8 devices)
Intel(R) PRO/1000 Network Driver - version
6.0.60-k2-NAPI
Copyright (c) 1999-2005 Intel Corporation.
PCI: Enabling device 0000:00:0e.0 (0000 -> 0003)
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network
Connection
PCI: Enabling device 0000:00:0e.1 (0000 -> 0003)
e1000: eth1: e1000_probe: Intel(R) PRO/1000 Network
Connection
Uniform Multi-Platform E-IDE driver Revision:
7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes;
override with idebus=xx
PCI: Enabling device 0000:00:0d.0 (0000 -> 0003)
ata1: SATA max PIO4 cmd 0x0 ctl 0x90011B0008022120
bmdma 0x0 irq 45
ata2: SATA max PIO4 cmd 0x0 ctl 0x90011B0008024120
bmdma 0x0 irq 45
ata3: SATA max PIO4 cmd 0x0 ctl 0x90011B0008026120
bmdma 0x0 irq 45
ata4: SATA max PIO4 cmd 0x0 ctl 0x90011B0008028120
bmdma 0x0 irq 45
ata1: no device found (phy stat 00000000)
scsi0 : sata_mv
ata2: no device found (phy stat 00000000)
scsi1 : sata_mv
ata3: dev 0 ATA, max UDMA/100, 156301488 sectors:
lba48
........
.......

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
