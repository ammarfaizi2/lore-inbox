Return-Path: <linux-kernel-owner+w=401wt.eu-S1751097AbXACTfK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbXACTfK (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 14:35:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbXACTfK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 14:35:10 -0500
Received: from smtp.telefonica.net ([213.4.149.66]:35187 "EHLO
	ctsmtpout3.frontal.correo" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751097AbXACTfI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 14:35:08 -0500
From: Jose Alberto Reguero <jareguero@telefonica.net>
To: linux-kernel@vger.kernel.org
Subject: ahci and Marvell 88SE6121
Date: Wed, 3 Jan 2007 20:35:05 +0100
User-Agent: KMail/1.9.5
Cc: Jose Alberto Reguero <jareguero@telefonica.net>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_qVAnFniIxA+h1K7"
Message-Id: <200701032035.06176.jareguero@telefonica.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_qVAnFniIxA+h1K7
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I am trying to make work the driver ahci with Marvell 88SE6121 but not succes.
The log is good?
I atach the log.
Thanks.

Jose Alberto

--Boundary-00=_qVAnFniIxA+h1K7
Content-Type: text/plain;
  charset="us-ascii";
  name="log3"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="log3"

Jan  3 17:03:42 jar kernel: ACPI: PCI Interrupt 0000:06:00.0[A] -> GSI 28 (level, low) -> IRQ 28
Jan  3 17:03:43 jar kernel: ahci 0000:06:00.0: AHCI 0001.0000 32 slots 3 ports 3 Gbps 0x7 impl IDE mode
Jan  3 17:03:43 jar kernel: ahci 0000:06:00.0: flags: 64bit ncq stag led pmp slum part 
Jan  3 17:03:43 jar kernel: ata5: SATA max UDMA/133 cmd 0xFFFFC2000079ED00 ctl 0x0 bmdma 0x0 irq 2298
Jan  3 17:03:43 jar kernel: ata6: SATA max UDMA/133 cmd 0xFFFFC2000079ED80 ctl 0x0 bmdma 0x0 irq 2298
Jan  3 17:03:43 jar kernel: ata7: SATA max UDMA/133 cmd 0xFFFFC2000079EE00 ctl 0x0 bmdma 0x0 irq 2298
Jan  3 17:03:43 jar kernel: scsi4 : ahci
Jan  3 17:03:44 jar kernel: ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Jan  3 17:04:14 jar kernel: ata5.00: qc timeout (cmd 0xec)
Jan  3 17:04:14 jar kernel: ata5.00: failed to IDENTIFY (I/O error, err_mask=0x104)
Jan  3 17:04:14 jar kernel: ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Jan  3 17:04:14 jar kernel: ATA: abnormal status 0x58 on port 0x0
Jan  3 17:04:14 jar kernel: ATA: abnormal status 0x58 on port 0x0
Jan  3 17:04:44 jar kernel: ata5.00: qc timeout (cmd 0xec)
Jan  3 17:04:44 jar kernel: ata5.00: failed to IDENTIFY (I/O error, err_mask=0x104)
Jan  3 17:04:45 jar kernel: ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Jan  3 17:04:45 jar kernel: ATA: abnormal status 0x58 on port 0x0
Jan  3 17:04:45 jar kernel: ATA: abnormal status 0x58 on port 0x0
Jan  3 17:05:15 jar kernel: ata5.00: qc timeout (cmd 0xec)
Jan  3 17:05:15 jar kernel: ata5.00: failed to IDENTIFY (I/O error, err_mask=0x104)
Jan  3 17:05:16 jar kernel: ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Jan  3 17:05:16 jar kernel: scsi5 : ahci
Jan  3 17:05:16 jar kernel: ata6: SATA link down (SStatus 0 SControl 300)
Jan  3 17:05:16 jar kernel: scsi6 : ahci
Jan  3 17:05:17 jar kernel: ata7: SATA link down (SStatus 0 SControl 0)

--Boundary-00=_qVAnFniIxA+h1K7--
