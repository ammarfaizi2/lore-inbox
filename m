Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264257AbTCUXh3>; Fri, 21 Mar 2003 18:37:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264267AbTCUXh3>; Fri, 21 Mar 2003 18:37:29 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:19253
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S264257AbTCUXh1>; Fri, 21 Mar 2003 18:37:27 -0500
Date: Fri, 21 Mar 2003 18:44:55 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: aic7(censored) dying horribly in 2.5.65-mm2
In-Reply-To: <411800000.1048276482@aslan.btc.adaptec.com>
Message-ID: <Pine.LNX.4.50.0303211842370.28519-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0303210202080.2133-100000@montezuma.mastecende.com>
 <411800000.1048276482@aslan.btc.adaptec.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Mar 2003, Justin T. Gibbs wrote:

> > Hi Justin i got this booting 2.5.65-mm2, 2.5.65 was fine there is an oops 
> > right at the end. Is there anything specific you want?
> 
> It would be nice to know the devices that are attached to the controller.
> Could you also use the latest driver from here:

This is from a 2.4.18-RH kernel

scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.5
        <Adaptec aic7870 SCSI adapter>
        aic7870: Wide Channel A, SCSI Id=7, 16/253 SCBs

scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.5
        <Adaptec aic7870 SCSI adapter>
        aic7870: Wide Channel A, SCSI Id=7, 16/253 SCBs

  Vendor: DEC       Model: DLT2000           Rev: 830A
  Type:   Sequential-Access                  ANSI SCSI revision: 02
  Vendor: TOSHIBA   Model: CD-ROM XM-5401TA  Rev: 3605
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: SEAGATE   Model: ST15150W          Rev: 9103
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: SEAGATE   Model: ST15150W          Rev: 9103
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: SEAGATE   Model: ST15150W          Rev: 9103
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: SEAGATE   Model: ST15150W          Rev: 9103
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: SEAGATE   Model: ST15150W          Rev: 9103
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: SEAGATE   Model: ST15150W          Rev: 9103
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi1:A:0:0: Tagged Queuing enabled.  Depth 253
scsi1:A:1:0: Tagged Queuing enabled.  Depth 253
scsi1:A:2:0: Tagged Queuing enabled.  Depth 253
scsi1:A:3:0: Tagged Queuing enabled.  Depth 253
scsi1:A:4:0: Tagged Queuing enabled.  Depth 253
scsi1:A:5:0: Tagged Queuing enabled.  Depth 253
Attached scsi disk sda at scsi1, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi1, channel 0, id 1, lun 0
Attached scsi disk sdc at scsi1, channel 0, id 2, lun 0
Attached scsi disk sdd at scsi1, channel 0, id 3, lun 0
Attached scsi disk sde at scsi1, channel 0, id 4, lun 0
Attached scsi disk sdf at scsi1, channel 0, id 5, lun 0
(scsi1:A:0): 20.000MB/s transfers (10.000MHz, offset 8, 16bit)
SCSI device sda: 8388315 512-byte hdwr sectors (4295 MB)
Partition check:
 sda: sda1
(scsi1:A:1): 20.000MB/s transfers (10.000MHz, offset 8, 16bit)
SCSI device sdb: 8388315 512-byte hdwr sectors (4295 MB)
 sdb: sdb1 sdb2
(scsi1:A:2): 20.000MB/s transfers (10.000MHz, offset 8, 16bit)
SCSI device sdc: 8388315 512-byte hdwr sectors (4295 MB)
 sdc: sdc1
(scsi1:A:3): 20.000MB/s transfers (10.000MHz, offset 8, 16bit)
SCSI device sdd: 8388315 512-byte hdwr sectors (4295 MB)
 sdd: sdd1
(scsi1:A:4): 20.000MB/s transfers (10.000MHz, offset 8, 16bit)
SCSI device sde: 8388315 512-byte hdwr sectors (4295 MB)
 sde: sde1
(scsi1:A:5): 20.000MB/s transfers (10.000MHz, offset 8, 16bit)
SCSI device sdf: 8388315 512-byte hdwr sectors (4295 MB)
 sdf: sdf1


> http://people.FreeBSD.org/~gibbs/linux/SRC/

I'll try that driver this evening.

> the driver and send me the output you get.

Thanks,
	Zwane

-- 
function.linuxpower.ca
