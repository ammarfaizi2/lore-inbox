Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263851AbTKXUDi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 15:03:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263853AbTKXUDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 15:03:38 -0500
Received: from roc-24-169-2-225.rochester.rr.com ([24.169.2.225]:30336 "EHLO
	death.krwtech.com") by vger.kernel.org with ESMTP id S263851AbTKXUDg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 15:03:36 -0500
Date: Mon, 24 Nov 2003 15:03:34 -0500 (EST)
From: Ken Witherow <phantoml@rochester.rr.com>
X-X-Sender: ken@death
Reply-To: Ken Witherow <ken@krwtech.com>
To: linux-kernel@vger.kernel.org
Subject: Re: aic7xxx loading oops in 2.6.0-test10
In-Reply-To: <1069700224.459.60.camel@hosts>
Message-ID: <Pine.LNX.4.58.0311241457330.575@death>
References: <200311241736.23824.jlell@JakobLell.de>  <Pine.LNX.4.53.0311241205500.18425@chaos>
  <20031124173527.GA1561@mail.shareable.org> <1069700224.459.60.camel@hosts>
Organization: KRW Technologies
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

possibly related, I hang on boot when it's time to scan my 2940U2W. No
errors are displayed and keyboard is locked out. Below is what I see in
test9 with a note of where it hangs. I see the drives attached to the
controller flash their access light prior to the hang.

ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
scsi0 : AdvanSys SCSI 3.3GJ: PCI Ultra: IO 0x1800-0x180F, IRQ 0x11
  Vendor: ARCHIVE   Model: 4326XX 27871-XXX  Rev: 0316
  Type:   Sequential-Access                  ANSI SCSI revision: 02
  Vendor: SEAGATE   Model: SX410800N         Rev: 7117
  Type:   Direct-Access                      ANSI SCSI revision: 02

***hangs here***

scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.35
        <Adaptec 2940 Ultra2 SCSI adapter>
        aic7890/91: Ultra2 Wide Channel A, SCSI Id=7, 32/253 SCBs
(scsi1:A:0): 20.000MB/s transfers (20.000MHz, offset 31)
(scsi1:A:1): 20.000MB/s transfers (20.000MHz, offset 31)
(scsi1:A:2): 20.000MB/s transfers (20.000MHz, offset 8)
(scsi1:A:6): 10.000MB/s transfers (10.000MHz, offset 8)
(scsi1:A:14): 80.000MB/s transfers (40.000MHz, offset 15, 16bit)
  Vendor: IBM       Model: DNES-309170       Rev: SAH0
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi1:A:0:0: Tagged Queuing enabled.  Depth 32
  Vendor: WDIGTL    Model: WD183 ULTRA2      Rev: 1.00
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi1:A:1:0: Tagged Queuing enabled.  Depth 32
  Vendor: TEAC      Model: CD-W512SB         Rev: 1.0C
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: CyberDrv  Model:  CD-ROM TW240S    Rev: 1.20
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: SEAGATE   Model: SX118273LC        Rev: 6367
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi1:A:14:0: Tagged Queuing enabled.  Depth 32
st: Version 20030811, fixed bufsize 32768, s/g segs 256
Attached scsi tape st0 at scsi0, channel 0, id 4, lun 0
st0: try direct i/o: yes, max page reachable by HBA 1048575
SCSI device sda: 17096357 512-byte hdwr sectors (8753 MB)
SCSI device sda: drive cache: write through
 sda: sda1 sda4 < sda5 >
