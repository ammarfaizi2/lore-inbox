Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265998AbTAFEk6>; Sun, 5 Jan 2003 23:40:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266010AbTAFEk6>; Sun, 5 Jan 2003 23:40:58 -0500
Received: from [209.195.52.121] ([209.195.52.121]:3038 "HELO
	warden2b.diginsite.com") by vger.kernel.org with SMTP
	id <S265998AbTAFEk4>; Sun, 5 Jan 2003 23:40:56 -0500
From: David Lang <david.lang@digitalinsight.com>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: Paul Rolland <rol@witbe.net>, linux-kernel@vger.kernel.org
Date: Sun, 5 Jan 2003 20:36:53 -0800 (PST)
Subject: Re: [2.5.54] Oops IDE-SCSI and failure AIC7xxx
In-Reply-To: <459240000.1041823747@aslan.scsiguy.com>
Message-ID: <Pine.LNX.4.44.0301052032430.25482-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

other then the memmap error (in my case device 0:10:0 I get the first
three lines of the driver init and then nothing. the machine
completely locks up (driver version on .54 is 6.2.25 but I've
had this same problem since .50)

here is what I get on 2.4.18, the only difference on the first three lines
between this and 2.5.54 is the driver version number

scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.4
        <Adaptec 2940 SCSI adapter>
        aic7870: Single Channel A, SCSI Id=7, 16/253 SCBs

  Vendor: SEAGATE   Model: ST32430N          Rev: 0510
  Type:   Direct-Access                      ANSI SCSI revision: 02
(scsi0:A:0): 8.064MB/s transfers (8.064MHz, offset 15)
  Vendor: RICOH     Model: CD-R/RW MP7040S   Rev: 1.10
  Type:   CD-ROM                             ANSI SCSI revision: 02
scsi0:A:0:0: Tagged Queuing enabled.  Depth 15
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sda: 4197405 512-byte hdwr sectors (2149 MB)
 /dev/scsi/host0/bus0/target0/lun0: p1 p2
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 3, lun 0
sr0: scsi3-mmc drive: 20x/20x writer cd/rw xa/form2 cdda tray

David Lang


On Sun, 5 Jan 2003, Justin T. Gibbs wrote:

> Date: Sun, 05 Jan 2003 20:29:07 -0700
> From: Justin T. Gibbs <gibbs@scsiguy.com>
> To: David Lang <david.lang@digitalinsight.com>
> Cc: Paul Rolland <rol@witbe.net>, linux-kernel@vger.kernel.org
> Subject: Re: [2.5.54] Oops IDE-SCSI and failure AIC7xxx
>
> > Ok, but it's the only error message I get and the AIX7xxx driver then
> > fails to initialize.
>
> Can you be just a bit more specific?  Actual driver messages are
> usually a big help.
>
> --
> Justin
>
