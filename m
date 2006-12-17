Return-Path: <linux-kernel-owner+w=401wt.eu-S1752588AbWLQNXE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752588AbWLQNXE (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 08:23:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752591AbWLQNXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 08:23:04 -0500
Received: from smtp.telefonica.net ([213.4.149.66]:64466 "EHLO
	ctsmtpout2.frontal.correo" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752588AbWLQNXD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 08:23:03 -0500
From: Jose Alberto Reguero <jareguero@telefonica.net>
To: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: pata_marvell and Marvell 88SE6121
Date: Sun, 17 Dec 2006 14:22:48 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <200612161841.26700.jareguero@telefonica.net> <20061216193146.06373923@localhost.localdomain>
In-Reply-To: <20061216193146.06373923@localhost.localdomain>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_pSUhFfmeh1CfPJN"
Message-Id: <200612171422.49112.jareguero@telefonica.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_pSUhFfmeh1CfPJN
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

El S=E1bado, 16 de Diciembre de 2006 20:31, Alan escribi=F3:
> On Sat, 16 Dec 2006 18:41:26 +0100
>
> Jose Alberto Reguero <jareguero@telefonica.net> wrote:
> > I am trying to make work the driver pata_marvell of linux-2.6.20-rc1 wi=
th
> > Marvell 88SE6121.
>
> The 6121 is I believe ahci.

So there is no change to make work with pata_marvell ?
I thought that 61xx series was similar.

Do you suggest to try with ahci driver?

I atach new log with kernel 2.6.19 and pata_marvell patch.

Thanks.
Jose Alberto

--Boundary-00=_pSUhFfmeh1CfPJN
Content-Type: text/plain;
  charset="iso-8859-15";
  name="log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="log"

Dec 17 13:07:28 jar kernel: ata3: PATA max UDMA/100 cmd 0xEC00 ctl 0xE882 bmdma 0xE400 irq 28
Dec 17 13:07:28 jar kernel: ata4: PATA max UDMA/133 cmd 0xE800 ctl 0xE482 bmdma 0xE408 irq 28
Dec 17 13:07:28 jar kernel: scsi2 : pata_marvell
Dec 17 13:07:28 jar kernel: BAR5:00:02 01:7F 02:22 03:CA 04:00 05:00 06:00 07:80 08:00 09:00 0A:00 0B:00 0C:07 0D:00 0E:00 0F:00 
Dec 17 13:07:28 jar kernel: ATA: abnormal status 0x7F on port 0xEC07
Dec 17 13:07:28 jar kernel: scsi3 : pata_marvell
Dec 17 13:07:28 jar kernel: BAR5:00:02 01:7F 02:22 03:CA 04:00 05:00 06:00 07:80 08:00 09:00 0A:00 0B:00 0C:07 0D:00 0E:00 0F:00 
Dec 17 13:07:28 jar kernel: ATA: abnormal status 0x7F on port 0xE807
Dec 17 13:07:28 jar kernel: ATA: abnormal status 0x7F on port 0xE807
Dec 17 13:07:58 jar kernel: ata4.00: qc timeout (cmd 0xec)
Dec 17 13:07:58 jar kernel: ata4.00: failed to IDENTIFY (I/O error, err_mask=0x4)
Dec 17 13:07:59 jar kernel: BAR5:00:02 01:7F 02:22 03:CA 04:00 05:00 06:00 07:80 08:00 09:00 0A:00 0B:00 0C:07 0D:00 0E:00 0F:00 
Dec 17 13:07:59 jar kernel: ATA: abnormal status 0x7F on port 0xE807
Dec 17 13:07:59 jar kernel: ATA: abnormal status 0x7F on port 0xE807
Dec 17 13:08:29 jar kernel: ata4.00: qc timeout (cmd 0xec)
Dec 17 13:08:29 jar kernel: ata4.00: failed to IDENTIFY (I/O error, err_mask=0x4)
Dec 17 13:08:29 jar kernel: BAR5:00:02 01:7F 02:22 03:CA 04:00 05:00 06:00 07:80 08:00 09:00 0A:00 0B:00 0C:07 0D:00 0E:00 0F:00 
Dec 17 13:08:30 jar kernel: ATA: abnormal status 0x7F on port 0xE807
Dec 17 13:08:30 jar kernel: ATA: abnormal status 0x7F on port 0xE807
Dec 17 13:09:00 jar kernel: ata4.00: qc timeout (cmd 0xec)
Dec 17 13:09:00 jar kernel: ata4.00: failed to IDENTIFY (I/O error, err_mask=0x4)
Dec 17 13:09:00 jar kernel: BAR5:00:02 01:7F 02:22 03:CA 04:00 05:00 06:00 07:80 08:00 09:00 0A:00 0B:00 0C:07 0D:00 0E:00 0F:00 
Dec 17 13:14:30 jar vdr: [3345] connect from 127.0.0.1, port 33449 - accepted

--Boundary-00=_pSUhFfmeh1CfPJN--
