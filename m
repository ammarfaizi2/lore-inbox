Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261766AbUDCOKr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 09:10:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbUDCOKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 09:10:47 -0500
Received: from fep03.tuttopmi.it ([212.131.248.106]:5322 "EHLO
	fep03-svc.flexmail.it") by vger.kernel.org with ESMTP
	id S261746AbUDCOKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 09:10:46 -0500
Date: Sat, 3 Apr 2004 16:16:05 +0200
From: Elisabetta Galli <brainfs@tin.it>
To: linux-kernel@vger.kernel.org
Message-Id: <20040403161605.665e1a47.brainfs@tin.it>
Reply-To: brainfs@tin.it
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 192.168.254.1
X-SA-Exim-Mail-From: brainfs@tin.it
Subject: SiS 964 serial ata on Asus P4S800D problems
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 4.0 (built Tue, 16 Mar 2004 19:40:56 +0100)
X-SA-Exim-Scanned: Yes (on mfa.master)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

I'm trying to set up a raid array using two Maxtor DMaxPlus 6Y080M0
Sata, kernel 2.4.25 with libata 2.4.25-16 including support for Sis 964
chipset by Uwe Koziolek / Jeff Garzik.

Although Bios recognizes the disks during the post, the kernel doesn't
see them and gives out this message:

SCSI subsystem driver Revision: 1.00
libata version 1.02 loaded.
PCI: Found IRQ 10 for device 00:05.0
ata1: SATA max UDMA/133 cmd 0xEFF0 ctl 0xEFE6 bmdma 0xEF90 irq 10
ata2: SATA max UDMA/133 cmd 0xEFA8 ctl 0xEFE2 bmdma 0xEF98 irq 10
ata1: no device found (phy stat 5dfdfffe)
ata1: thread exiting
i8253 count too high! resetting..
ata2: no device found (phy stat 0094108a)
ata2: thread exiting
scsi0 : sata_sis
scsi1 : sata_sis
i8253 count too high! resetting..

Could it be a problem with the libata patch? Any suggestions?

Thank you.

Elisa
