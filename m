Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289654AbSAJUFc>; Thu, 10 Jan 2002 15:05:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289652AbSAJUFN>; Thu, 10 Jan 2002 15:05:13 -0500
Received: from pedigree.cs.ubc.ca ([142.103.6.50]:33730 "EHLO
	pedigree.cs.ubc.ca") by vger.kernel.org with ESMTP
	id <S289654AbSAJUFE>; Thu, 10 Jan 2002 15:05:04 -0500
Date: Thu, 10 Jan 2002 12:05:01 -0800
From: Dima Brodsky <dima@cs.ubc.ca>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Unable to burn CDs on 2.4.17
Message-ID: <20020110120501.A19535@cascade.cs.ubc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Since about 2.4.9 I have not been able to burn CDs.  I get the following
message in the logs.  I have also noticed that the system becomes less
responsive when large applications, like netscape 6 or staroffice 5.2
load.

scsi : aborting command due to timeout : pid 10818, scsi0, channel 0, id 1, lun 0 Synchronize Cache 00 00 00 00 00 00 00 00 00
hdd: irq timeout: status=0xd0 { Busy }
hdd: DMA disabled
hdd: ATAPI reset complete
hdd: irq timeout: status=0xd0 { Busy }
hdd: ATAPI reset complete
hdd: irq timeout: status=0xd0 { Busy }
hdd: status timeout: status=0xd0 { Busy }
hdd: drive not ready for command
hdd: ATAPI reset complete
scsi0 : channel 0 target 1 lun 0 request sense failed, performing reset.
SCSI bus is being reset for host 0 channel 0.
scsi0 : channel 0 target 1 lun 0 request sense failed, performing reset.

My setup is as follows:

Hardware:

	P III 650Mhz --- 256 MB --- P3B-F MB

	NVidia Geforce DDR - AGP Video Card

	IDE0 - Pri: HD - Sec: HD
	IDE1 - Pri: CD-ROM - Sec: CRW6206A, ATAPI CD/DVD-ROM drive

Kernel:

	2.4.17 compiled with gcc 3.0.2

	EXT3		in-kernel
	AGPGART		module
	NE2K-PCI	in-kernel
	IDE-SCSI	in-kernel
	EMU10K1		in-kernel
	USB		in-kernel

Software:

	cdrecord 1.10
	XFree86 4.1.0 running with the driver from NVidia and agpgart

I have a machine, P II 266 - 256MB with a similiar configuration
minus the XFree + NVidia, the sound, and the USB support and a
Hewlett-Packard CD-Writer Plus 8100 and it is burning perfectly.

Any ideas as to what could be wrong??

Thanks
ttyl
Dima

-- 
Dima Brodsky                                   dima@cs.ubc.ca
                                               http://www.cs.ubc.ca/~dima
201-2366 Main Mall                             (604) 822-9156 (Office)
Department of Computer Science                 (604) 822-2895 (DSG Lab)
University of British Columbia, Canada         (604) 822-5485 (FAX)

"The price of reliability is the pursuit of the utmost simplicity.
 It is a price which the very rich find the most hard to pay."
						  (Sir Antony Hoare, 1980)

