Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262694AbTLUKzH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 05:55:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262714AbTLUKzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 05:55:07 -0500
Received: from slimnet.xs4all.nl ([194.109.194.192]:14236 "EHLO slimnas.slim")
	by vger.kernel.org with ESMTP id S262694AbTLUKy7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 05:54:59 -0500
Subject: 2.6.0: SBP2 trouble (cont'd)
From: Jurgen Kramer <gtm.kramer@inter.nl.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1072004166.11257.15.camel@paragon.slim>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sun, 21 Dec 2003 11:56:06 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I reported SBP-2 problems with 2.6.0-test11 (somewhere around 28
November). With 2.6.0 the problem still persists. I just tried it again
with the latest IEEE1394 drivers (r1088 / SBP2 r1085) but I still get
logging time out errors on my CD-RW drive.

With 2.4 it just works as it should and I get both my CD-RW drive and my
MO drive.

Under 2.6 SBP2 just somehow does not want to play ball with my CD-RW
drive.
 
Jurgen

Dec 21 11:29:42 paragon kernel: ohci1394: fw-host0: OHCI-1394 1.0 (PCI):
IRQ=[20]  MMIO=[feaff800-feafffff]  Max Packet=[2048]
Dec 21 11:29:42 paragon kernel: ohci1394: fw-host1: OHCI-1394 1.1 (PCI):
IRQ=[20]  MMIO=[feaff000-feaff7ff]  Max Packet=[2048]
Dec 21 11:29:42 paragon kernel: sbp2: $Rev: 1085 $ Ben Collins
<bcollins@debian.org>
Dec 21 11:29:42 paragon kernel: scsi2 : SCSI emulation for IEEE-1394
SBP-2 Devices

The missing drive (from 2.4):

Dec 21 11:36:28 paragon kernel: scsi singledevice 2 0 0 0
Dec 21 11:36:28 paragon kernel:   Vendor: PLEXTOR   Model: CD-R  
PX-W2410A  Rev: 1.04
Dec 21 11:36:28 paragon kernel:   Type:  
CD-ROM                             ANSI SCSI revision: 02


