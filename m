Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288898AbSAERcE>; Sat, 5 Jan 2002 12:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288894AbSAERby>; Sat, 5 Jan 2002 12:31:54 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:15373 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288893AbSAERbi>; Sat, 5 Jan 2002 12:31:38 -0500
Subject: Re: atp870u and acard scsi HELP!
To: genlogic@mediaone.net (Sam Krasnik)
Date: Sat, 5 Jan 2002 17:42:41 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C368096.4070207@mediaone.net> from "Sam Krasnik" at Jan 04, 2002 11:27:02 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Muq9-0000Ty-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Umm the atp870u is supported in 2.2 and 2.4 by the default kernels. 
> 
> ...so one would think...yes it is supported technically, and the atp870u
> driver does exist...but the 2.4 one does not work, that is a known fact.

Which tree, and what compiler

> some of the code has a different format in 2.4 than 2.2 and 2.0,
> mostly the external stuff to load as modules...etc, but i can't get it 
> to work.
> so i needed help porting the old one into the new 2.4 framework
> if you will.

I think you need to work out why the newer one is failing on your specific
hardware. Standard Red Hat kernel....

aec671x_detect:
PCI: Found IRQ 10 for device 00:08.0
   ACARD AEC-671X PCI Ultra/W SCSI-3 Host Adapter: 0    IO:d800, IRQ:10.
         ID:  2  HP      C1537A          L105
         ID:  5  IBM     DSAS-3540     !WS47Y
         ID:  7  Host Adapter
scsi0 : ACARD AEC-6710/6712/67160 PCI Ultra/W/LVD SCSI-3 Adapter Driver
V2.4+ac
  Vendor: HP        Model: C1537A            Rev: L105
  Type:   Sequential-Access                  ANSI SCSI revision: 02
  Vendor: IBM       Model: DSAS-3540     !W  Rev: S47Y
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi disk sda at scsi0, channel 0, id 5, lun 0
SCSI device sda: 1056768 512-byte hdwr sectors (541 MB)
 sda: sda1
Journalled Block Device driver loaded

