Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932182AbWAUNZc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182AbWAUNZc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 08:25:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932188AbWAUNZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 08:25:32 -0500
Received: from mail.gmx.de ([213.165.64.21]:28548 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932182AbWAUNZc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 08:25:32 -0500
X-Authenticated: #6864226
Content-Disposition: inline
From: Gerrit =?iso-8859-1?q?Bruchh=E4user?= <gbruchhaeuser@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: (SOLVED!) AHA-7850 doesn't detect scanner anymore
Date: Sat, 21 Jan 2006 14:25:29 +0100
User-Agent: KMail/1.8.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200601211425.29291.gbruchhaeuser@gmx.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One pin on the connector didn't have proper contact. 
Thx,
Gerrit

----------  Weitergeleitete Nachricht  ----------

Subject: AHA-7850 doesn't detect scanner anymore
Date: Samstag, 21. Januar 2006 13:46
From: Gerrit Bruchhäuser <gbruchhaeuser@gmx.de>
To: linux-kernel@vger.kernel.org

Hello,
my old "HP ScanJet IIc" used to work so perfectly but now the kernel can only
see something at SCSI-ID 1, but is not able to detect the device properly :-(

These are the 'kernel.log' entries after I switched on 'options aic7xxx

aic7xxx=verbose,periodic_otag' in modules.conf file :
| Jan 21 13:17:18 gbpc PCI: Enabling device 0000:00:0d.0 (0116 -> 0117)
| Jan 21 13:17:18 gbpc ACPI: PCI Interrupt 0000:00:0d.0[A] -> GSI 17 (level,

low) -> IRQ 185

| Jan 21 13:17:18 gbpc ahc_pci:0:13:0: hardware scb 64 bytes; kernel scb 52

bytes; ahc_dma 8 bytes

| Jan 21 13:17:18 gbpc ahc_pci:0:13:0: Host Adapter Bios disabled.  Using

default SCSI device parameters

| Jan 21 13:17:18 gbpc scsi12 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER,

Rev 7.0

| Jan 21 13:17:18 gbpc <Adaptec 2902/04/10/15/20C/30C SCSI adapter>
| Jan 21 13:17:18 gbpc aic7850: Single Channel A, SCSI Id=7, 3/253 SCBs
| Jan 21 13:17:18 gbpc
| Jan 21 13:17:33 gbpc (scsi12:A:0:0): Saw Selection Timeout for SCB 0x3
| Jan 21 13:17:34 gbpc (scsi12:A:1:0): SCB 2: requests Check Status
| Jan 21 13:17:34 gbpc (scsi12:A:1:0): Handled Residual of 36 bytes
| Jan 21 13:17:34 gbpc (scsi12:A:1:0): Sending Sense
| Jan 21 13:17:34 gbpc (scsi12:A:1:0): Handled Residual of 36 bytes
| Jan 21 13:17:34 gbpc (scsi12:A:1:0): SCB 3: requests Check Status
| Jan 21 13:17:34 gbpc (scsi12:A:1:0): Handled Residual of 36 bytes
| Jan 21 13:17:34 gbpc (scsi12:A:1:0): Sending Sense
| Jan 21 13:17:34 gbpc (scsi12:A:1:0): Handled Residual of 36 bytes
| Jan 21 13:17:35 gbpc (scsi12:A:1:0): SCB 2: requests Check Status
| Jan 21 13:17:35 gbpc (scsi12:A:1:0): Handled Residual of 36 bytes
| Jan 21 13:17:35 gbpc (scsi12:A:1:0): Sending Sense
| Jan 21 13:17:35 gbpc (scsi12:A:1:0): Handled Residual of 36 bytes
| Jan 21 13:17:35 gbpc (scsi12:A:2:0): Saw Selection Timeout for SCB 0x3
| Jan 21 13:17:35 gbpc (scsi12:A:3:0): Saw Selection Timeout for SCB 0x2
| Jan 21 13:17:36 gbpc (scsi12:A:4:0): Saw Selection Timeout for SCB 0x3
| Jan 21 13:17:36 gbpc (scsi12:A:5:0): Saw Selection Timeout for SCB 0x2
| Jan 21 13:17:36 gbpc (scsi12:A:6:0): Saw Selection Timeout for SCB 0x3

The SCSI-terminator is properly attached to the scanner and the wires are
 okay as well. Is there a way to find-out more what actually causes the
 problem?

As I am not subscribed to the list, please when you answer, put my mail
address to CC

Many thanks in advance,
Gerrit

-------------------------------------------------------
