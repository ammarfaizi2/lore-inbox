Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273985AbRIXQZQ>; Mon, 24 Sep 2001 12:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273989AbRIXQZG>; Mon, 24 Sep 2001 12:25:06 -0400
Received: from smtp.mediascape.net ([212.105.192.20]:42246 "EHLO
	smtp.mediascape.net") by vger.kernel.org with ESMTP
	id <S273985AbRIXQY5>; Mon, 24 Sep 2001 12:24:57 -0400
Message-ID: <3BAF5E1E.759630A0@mediascape.de>
Date: Mon, 24 Sep 2001 18:23:58 +0200
From: Olaf Zaplinski <o.zaplinski@mediascape.de>
X-Mailer: Mozilla 4.77 [de] (X11; U; Linux 2.4.10-pre15 i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: AIC7xxx errors (again) with 2.4.10pre15
In-Reply-To: <200109241608.f8OG80Y89488@aslan.scsiguy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Justin T. Gibbs" wrote:
> 
> >Hi all,
> >
> >my software RAID1 (hda1+sda1) worked fine with the current aic7xxx driver
> >when using 2.4.10pre13, but with 2.4.10pre15 I get the old behaviour I know
> >from 2.4.9:
> 
> What is your hardware configuration?  A full dmesg with aic7xxx=verbose
> should be sufficient.

Here it is:

[snip]
SCSI subsystem driver Revision: 1.00
(scsi0) <Adaptec AHA-294X Ultra SCSI host adapter> found at PCI 0/11/0
(scsi0) Narrow Channel, SCSI ID=7, 16/255 SCBs
(scsi0) Downloading sequencer code... 436 instructions downloaded
scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.2.4/5.2.0
       <Adaptec AHA-294X Ultra SCSI host adapter>
  Vendor: IBM OEM   Model: 0662S12           Rev: 3 30
  Type:   Direct-Access                      ANSI SCSI revision: 02
(scsi0:0:0:0) Enabled tagged queuing, queue depth 32.
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
(scsi0:0:0:0) Sending SDTR 25/15 message.
(scsi0:0:0:0) Synchronous at 10.0 Mbyte/sec, offset 15.
SCSI device sda: 2055035 512-byte hdwr sectors (1052 MB)
 sda: sda1
md: raid1 personality registered as nr 3
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
[/snip]

Olaf
