Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262213AbVFURr3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262213AbVFURr3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 13:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262169AbVFURr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 13:47:29 -0400
Received: from odpn1.odpn.net ([212.40.96.53]:41157 "EHLO odpn1.odpn.net")
	by vger.kernel.org with ESMTP id S262213AbVFURpG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 13:45:06 -0400
From: "Gabor Z. Papp" <gzp@papp.hu>
To: linux-kernel@vger.kernel.org, linux-aacraid-devel@dell.com
Subject: 2.4 and aacraid dmesg
Date: Tue, 21 Jun 2005 19:45:04 +0200
Message-ID: <x64qbrvc2n@gzp>
User-Agent: Gnus/5.110004 (No Gnus v0.4)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Authenticated: gzp1 odpn1.odpn.net a3085bdc7b32ae4d7418f70f85f7cf5f
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is this

PCI: Found IRQ 4 for device 03:0d.0
PCI: Sharing IRQ 4 with 03:09.0

repeated kernel message okay for so many times?

Linux version 2.4.31 (root@gzp) (gcc version 3.4.3) #1 Tue Jun 7 18:53:06 CEST 2005
[...]
SCSI subsystem driver Revision: 1.00
Red Hat/Adaptec aacraid driver (1.1-3 Jun  7 2005 18:53:28)
PCI: Found IRQ 4 for device 03:0d.0
PCI: Sharing IRQ 4 with 03:09.0
AAC0: kernel 4.2.4 build 7349
AAC0: monitor 4.2.4 build 7349
AAC0: bios 4.2.0 build 7349
AAC0: serial bad0fafaf001
AAC0: Non-DASD support enabled
spurious 8259A interrupt: IRQ7.
PCI: Found IRQ 4 for device 03:0d.0
PCI: Sharing IRQ 4 with 03:09.0
PCI: Found IRQ 4 for device 03:0d.0
PCI: Sharing IRQ 4 with 03:09.0
PCI: Found IRQ 4 for device 03:0d.0
PCI: Sharing IRQ 4 with 03:09.0
PCI: Found IRQ 4 for device 03:0d.0
PCI: Sharing IRQ 4 with 03:09.0
PCI: Found IRQ 4 for device 03:0d.0
PCI: Sharing IRQ 4 with 03:09.0
PCI: Found IRQ 4 for device 03:0d.0
PCI: Sharing IRQ 4 with 03:09.0
PCI: Found IRQ 4 for device 03:0d.0
PCI: Sharing IRQ 4 with 03:09.0
PCI: Found IRQ 4 for device 03:0d.0
PCI: Sharing IRQ 4 with 03:09.0
PCI: Found IRQ 4 for device 03:0d.0
PCI: Sharing IRQ 4 with 03:09.0
PCI: Found IRQ 4 for device 03:0d.0
PCI: Sharing IRQ 4 with 03:09.0
PCI: Found IRQ 4 for device 03:0d.0
PCI: Sharing IRQ 4 with 03:09.0
PCI: Found IRQ 4 for device 03:0d.0
PCI: Sharing IRQ 4 with 03:09.0
PCI: Found IRQ 4 for device 03:0d.0
PCI: Sharing IRQ 4 with 03:09.0
PCI: Found IRQ 4 for device 03:0d.0
PCI: Sharing IRQ 4 with 03:09.0
PCI: Found IRQ 4 for device 03:0d.0
PCI: Sharing IRQ 4 with 03:09.0
PCI: Found IRQ 4 for device 03:0d.0
PCI: Sharing IRQ 4 with 03:09.0
PCI: Found IRQ 4 for device 03:0d.0
PCI: Sharing IRQ 4 with 03:09.0
PCI: Found IRQ 4 for device 03:0d.0
PCI: Sharing IRQ 4 with 03:09.0
scsi0 : aacraid
  Vendor: ADAPTEC   Model: Adaptec Mirror    Rev: V1.0
  Type:   Direct-Access                      ANSI SCSI revision: 02

lspci not very informative about the card:

03:0d.0 RAID bus controller: Adaptec AAC-RAID (rev 01)

Its an Adaptec 2120S pci raid controller.
