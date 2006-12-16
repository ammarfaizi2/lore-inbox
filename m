Return-Path: <linux-kernel-owner+w=401wt.eu-S965484AbWLPRrK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965484AbWLPRrK (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 12:47:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965485AbWLPRrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 12:47:10 -0500
Received: from smtp.telefonica.net ([213.4.149.66]:10633 "EHLO
	ctsmtpout3.frontal.correo" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S965484AbWLPRrJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 12:47:09 -0500
X-Greylist: delayed 340 seconds by postgrey-1.27 at vger.kernel.org; Sat, 16 Dec 2006 12:47:09 EST
From: Jose Alberto Reguero <jareguero@telefonica.net>
To: linux-kernel@vger.kernel.org
Subject: pata_marvell and Marvell 88SE6121
Date: Sat, 16 Dec 2006 18:41:26 +0100
User-Agent: KMail/1.9.5
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_G/ChFzg6mvv8BdZ"
Message-Id: <200612161841.26700.jareguero@telefonica.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_G/ChFzg6mvv8BdZ
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I am trying to make work the driver pata_marvell of linux-2.6.20-rc1 with 
Marvell 88SE6121.
I added the PCI ID: 0x6121

        { PCI_DEVICE(0x11AB, 0x6101), },
        { PCI_DEVICE(0x11AB, 0x6145), },
        { PCI_DEVICE(0x11AB, 0x6121), },
        { }     /* terminate list */

But not succes.

Log attached.

Any hints are welcome.
Thanks.

Jose Alberto

--Boundary-00=_G/ChFzg6mvv8BdZ
Content-Type: text/plain;
  charset="us-ascii";
  name="log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="log"

Dec 16 12:22:58 jar kernel: ata3: PATA max UDMA/100 cmd 0xEC00 ctl 0xE882 bmdma 0xE400 irq 28
Dec 16 12:22:58 jar kernel: ata4: PATA max UDMA/133 cmd 0xE800 ctl 0xE482 bmdma 0xE408 irq 28
Dec 16 12:22:58 jar kernel: scsi3 : pata_marvell
Dec 16 12:22:58 jar kernel: BAR5:00:02 01:7F 02:22 03:CA 04:00 05:00 06:00 07:80 08:00 09:00 0A:00 0B:00 0C:07 0D:00 0E:00 0F:00
Dec 16 12:22:58 jar kernel: ATA: abnormal status 0x7F on port 0xEC07
Dec 16 12:22:58 jar kernel: scsi4 : pata_marvell
Dec 16 12:22:58 jar kernel: BAR5:00:02 01:7F 02:22 03:CA 04:00 05:00 06:00 07:80 08:00 09:00 0A:00 0B:00 0C:07 0D:00 0E:00 0F:00
Dec 16 12:22:58 jar kernel: ATA: abnormal status 0x7F on port 0xE807

--Boundary-00=_G/ChFzg6mvv8BdZ--
